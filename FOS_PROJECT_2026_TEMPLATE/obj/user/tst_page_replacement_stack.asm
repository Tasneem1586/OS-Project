
obj/user/tst_page_replacement_stack:     file format elf32-i386


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
  800031:	e8 fd 00 00 00       	call   800133 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/************************************************************/

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec 14 a0 00 00    	sub    $0xa014,%esp
	int8 arr[PAGE_SIZE*10];

	uint32 kilo = 1024;
  800042:	c7 45 f0 00 04 00 00 	movl   $0x400,-0x10(%ebp)

//	cprintf("envID = %d\n",envID);

	int freePages = sys_calculate_free_frames();
  800049:	e8 17 16 00 00       	call   801665 <sys_calculate_free_frames>
  80004e:	89 45 ec             	mov    %eax,-0x14(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  800051:	e8 5a 16 00 00       	call   8016b0 <sys_pf_calculate_allocated_pages>
  800056:	89 45 e8             	mov    %eax,-0x18(%ebp)

	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800059:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800060:	eb 15                	jmp    800077 <_main+0x3f>
		arr[i] = -1 ;
  800062:	8d 95 e8 5f ff ff    	lea    -0xa018(%ebp),%edx
  800068:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80006b:	01 d0                	add    %edx,%eax
  80006d:	c6 00 ff             	movb   $0xff,(%eax)

	int freePages = sys_calculate_free_frames();
	int usedDiskPages = sys_pf_calculate_allocated_pages();

	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800070:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  800077:	81 7d f4 ff 9f 00 00 	cmpl   $0x9fff,-0xc(%ebp)
  80007e:	7e e2                	jle    800062 <_main+0x2a>
		arr[i] = -1 ;


	cprintf_colored(TEXT_cyan, "%~\nchecking REPLACEMENT fault handling of STACK pages... \n");
  800080:	83 ec 08             	sub    $0x8,%esp
  800083:	68 20 1d 80 00       	push   $0x801d20
  800088:	6a 03                	push   $0x3
  80008a:	e8 ff 05 00 00       	call   80068e <cprintf_colored>
  80008f:	83 c4 10             	add    $0x10,%esp
	{
		for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800092:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800099:	eb 2c                	jmp    8000c7 <_main+0x8f>
			if( arr[i] != -1) panic("modified stack page(s) not restored correctly");
  80009b:	8d 95 e8 5f ff ff    	lea    -0xa018(%ebp),%edx
  8000a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000a4:	01 d0                	add    %edx,%eax
  8000a6:	8a 00                	mov    (%eax),%al
  8000a8:	3c ff                	cmp    $0xff,%al
  8000aa:	74 14                	je     8000c0 <_main+0x88>
  8000ac:	83 ec 04             	sub    $0x4,%esp
  8000af:	68 5c 1d 80 00       	push   $0x801d5c
  8000b4:	6a 1a                	push   $0x1a
  8000b6:	68 8c 1d 80 00       	push   $0x801d8c
  8000bb:	e8 d3 02 00 00       	call   800393 <_panic>
		arr[i] = -1 ;


	cprintf_colored(TEXT_cyan, "%~\nchecking REPLACEMENT fault handling of STACK pages... \n");
	{
		for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8000c0:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  8000c7:	81 7d f4 ff 9f 00 00 	cmpl   $0x9fff,-0xc(%ebp)
  8000ce:	7e cb                	jle    80009b <_main+0x63>
			if( arr[i] != -1) panic("modified stack page(s) not restored correctly");

		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  10) panic("Unexpected extra/less pages have been added to page file");
  8000d0:	e8 db 15 00 00       	call   8016b0 <sys_pf_calculate_allocated_pages>
  8000d5:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8000d8:	83 f8 0a             	cmp    $0xa,%eax
  8000db:	74 14                	je     8000f1 <_main+0xb9>
  8000dd:	83 ec 04             	sub    $0x4,%esp
  8000e0:	68 b0 1d 80 00       	push   $0x801db0
  8000e5:	6a 1c                	push   $0x1c
  8000e7:	68 8c 1d 80 00       	push   $0x801d8c
  8000ec:	e8 a2 02 00 00       	call   800393 <_panic>

		if( (freePages - (sys_calculate_free_frames() + sys_calculate_modified_frames())) != 0 ) panic("Extra memory are wrongly allocated... It's REplacement: expected that no extra frames are allocated");
  8000f1:	e8 6f 15 00 00       	call   801665 <sys_calculate_free_frames>
  8000f6:	89 c3                	mov    %eax,%ebx
  8000f8:	e8 81 15 00 00       	call   80167e <sys_calculate_modified_frames>
  8000fd:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  800100:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800103:	39 c2                	cmp    %eax,%edx
  800105:	74 14                	je     80011b <_main+0xe3>
  800107:	83 ec 04             	sub    $0x4,%esp
  80010a:	68 ec 1d 80 00       	push   $0x801dec
  80010f:	6a 1e                	push   $0x1e
  800111:	68 8c 1d 80 00       	push   $0x801d8c
  800116:	e8 78 02 00 00       	call   800393 <_panic>
	}//consider tables of PF, disk pages

	cprintf_colored(TEXT_light_green, "%~\nCongratulations: stack pages created, modified and read is completed successfully\n\n");
  80011b:	83 ec 08             	sub    $0x8,%esp
  80011e:	68 50 1e 80 00       	push   $0x801e50
  800123:	6a 0a                	push   $0xa
  800125:	e8 64 05 00 00       	call   80068e <cprintf_colored>
  80012a:	83 c4 10             	add    $0x10,%esp


	return;
  80012d:	90                   	nop
}
  80012e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800131:	c9                   	leave  
  800132:	c3                   	ret    

00800133 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  800133:	55                   	push   %ebp
  800134:	89 e5                	mov    %esp,%ebp
  800136:	57                   	push   %edi
  800137:	56                   	push   %esi
  800138:	53                   	push   %ebx
  800139:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  80013f:	e8 e9 16 00 00       	call   80182d <sys_getenvindex>
  800144:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  800147:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80014a:	89 d0                	mov    %edx,%eax
  80014c:	c1 e0 03             	shl    $0x3,%eax
  80014f:	01 d0                	add    %edx,%eax
  800151:	c1 e0 06             	shl    $0x6,%eax
  800154:	01 d0                	add    %edx,%eax
  800156:	c1 e0 03             	shl    $0x3,%eax
  800159:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80015e:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800163:	a1 20 30 80 00       	mov    0x803020,%eax
  800168:	8a 40 10             	mov    0x10(%eax),%al
  80016b:	84 c0                	test   %al,%al
  80016d:	74 0d                	je     80017c <libmain+0x49>
		binaryname = myEnv->prog_name;
  80016f:	a1 20 30 80 00       	mov    0x803020,%eax
  800174:	83 c0 10             	add    $0x10,%eax
  800177:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80017c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800180:	7e 0a                	jle    80018c <libmain+0x59>
		binaryname = argv[0];
  800182:	8b 45 0c             	mov    0xc(%ebp),%eax
  800185:	8b 00                	mov    (%eax),%eax
  800187:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  80018c:	83 ec 08             	sub    $0x8,%esp
  80018f:	ff 75 0c             	pushl  0xc(%ebp)
  800192:	ff 75 08             	pushl  0x8(%ebp)
  800195:	e8 9e fe ff ff       	call   800038 <_main>
  80019a:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  80019d:	a1 00 30 80 00       	mov    0x803000,%eax
  8001a2:	85 c0                	test   %eax,%eax
  8001a4:	0f 84 b7 01 00 00    	je     800361 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  8001aa:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8001b0:	bb e4 1f 80 00       	mov    $0x801fe4,%ebx
  8001b5:	ba 0e 00 00 00       	mov    $0xe,%edx
  8001ba:	89 c7                	mov    %eax,%edi
  8001bc:	89 de                	mov    %ebx,%esi
  8001be:	89 d1                	mov    %edx,%ecx
  8001c0:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8001c2:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  8001c8:	b9 56 00 00 00       	mov    $0x56,%ecx
  8001cd:	b0 00                	mov    $0x0,%al
  8001cf:	89 d7                	mov    %edx,%edi
  8001d1:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  8001d3:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  8001da:	8d 45 d8             	lea    -0x28(%ebp),%eax
  8001dd:	83 ec 08             	sub    $0x8,%esp
  8001e0:	50                   	push   %eax
  8001e1:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8001e7:	50                   	push   %eax
  8001e8:	e8 40 18 00 00       	call   801a2d <sys_utilities>
  8001ed:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8001f0:	e8 c0 13 00 00       	call   8015b5 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  8001f5:	83 ec 0c             	sub    $0xc,%esp
  8001f8:	68 c0 1e 80 00       	push   $0x801ec0
  8001fd:	e8 5f 04 00 00       	call   800661 <cprintf>
  800202:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  800205:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800208:	85 c0                	test   %eax,%eax
  80020a:	74 58                	je     800264 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  80020c:	e8 3a 18 00 00       	call   801a4b <sys_get_optimal_num_faults>
  800211:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  800214:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  80021a:	bb 48 20 80 00       	mov    $0x802048,%ebx
  80021f:	ba 11 00 00 00       	mov    $0x11,%edx
  800224:	89 c7                	mov    %eax,%edi
  800226:	89 de                	mov    %ebx,%esi
  800228:	89 d1                	mov    %edx,%ecx
  80022a:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80022c:	8d 55 85             	lea    -0x7b(%ebp),%edx
  80022f:	b9 53 00 00 00       	mov    $0x53,%ecx
  800234:	b0 00                	mov    $0x0,%al
  800236:	89 d7                	mov    %edx,%edi
  800238:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  80023a:	83 ec 08             	sub    $0x8,%esp
  80023d:	ff 75 dc             	pushl  -0x24(%ebp)
  800240:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800246:	50                   	push   %eax
  800247:	e8 e1 17 00 00       	call   801a2d <sys_utilities>
  80024c:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  80024f:	83 ec 08             	sub    $0x8,%esp
  800252:	ff 75 dc             	pushl  -0x24(%ebp)
  800255:	68 e8 1e 80 00       	push   $0x801ee8
  80025a:	e8 02 04 00 00       	call   800661 <cprintf>
  80025f:	83 c4 10             	add    $0x10,%esp
  800262:	eb 59                	jmp    8002bd <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800264:	a1 20 30 80 00       	mov    0x803020,%eax
  800269:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  80026f:	a1 20 30 80 00       	mov    0x803020,%eax
  800274:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  80027a:	83 ec 04             	sub    $0x4,%esp
  80027d:	52                   	push   %edx
  80027e:	50                   	push   %eax
  80027f:	68 0c 1f 80 00       	push   $0x801f0c
  800284:	e8 d8 03 00 00       	call   800661 <cprintf>
  800289:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  80028c:	a1 20 30 80 00       	mov    0x803020,%eax
  800291:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  800297:	a1 20 30 80 00       	mov    0x803020,%eax
  80029c:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  8002a2:	a1 20 30 80 00       	mov    0x803020,%eax
  8002a7:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  8002ad:	51                   	push   %ecx
  8002ae:	52                   	push   %edx
  8002af:	50                   	push   %eax
  8002b0:	68 34 1f 80 00       	push   $0x801f34
  8002b5:	e8 a7 03 00 00       	call   800661 <cprintf>
  8002ba:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8002bd:	a1 20 30 80 00       	mov    0x803020,%eax
  8002c2:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  8002c8:	83 ec 08             	sub    $0x8,%esp
  8002cb:	50                   	push   %eax
  8002cc:	68 8c 1f 80 00       	push   $0x801f8c
  8002d1:	e8 8b 03 00 00       	call   800661 <cprintf>
  8002d6:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  8002d9:	83 ec 0c             	sub    $0xc,%esp
  8002dc:	68 a0 1f 80 00       	push   $0x801fa0
  8002e1:	e8 7b 03 00 00       	call   800661 <cprintf>
  8002e6:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  8002e9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8002f0:	eb 28                	jmp    80031a <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  8002f2:	a1 20 30 80 00       	mov    0x803020,%eax
  8002f7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8002fa:	81 c2 74 04 00 00    	add    $0x474,%edx
  800300:	8b 04 90             	mov    (%eax,%edx,4),%eax
  800303:	83 ec 04             	sub    $0x4,%esp
  800306:	50                   	push   %eax
  800307:	ff 75 e4             	pushl  -0x1c(%ebp)
  80030a:	68 b7 1f 80 00       	push   $0x801fb7
  80030f:	e8 4d 03 00 00       	call   800661 <cprintf>
  800314:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  800317:	ff 45 e4             	incl   -0x1c(%ebp)
  80031a:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  80031e:	7e d2                	jle    8002f2 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  800320:	83 ec 0c             	sub    $0xc,%esp
  800323:	68 c6 1f 80 00       	push   $0x801fc6
  800328:	e8 34 03 00 00       	call   800661 <cprintf>
  80032d:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  800330:	a1 20 30 80 00       	mov    0x803020,%eax
  800335:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  80033b:	83 ec 08             	sub    $0x8,%esp
  80033e:	50                   	push   %eax
  80033f:	68 ca 1f 80 00       	push   $0x801fca
  800344:	e8 18 03 00 00       	call   800661 <cprintf>
  800349:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  80034c:	83 ec 0c             	sub    $0xc,%esp
  80034f:	68 c0 1e 80 00       	push   $0x801ec0
  800354:	e8 08 03 00 00       	call   800661 <cprintf>
  800359:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  80035c:	e8 6e 12 00 00       	call   8015cf <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  800361:	e8 1f 00 00 00       	call   800385 <exit>
}
  800366:	90                   	nop
  800367:	8d 65 f4             	lea    -0xc(%ebp),%esp
  80036a:	5b                   	pop    %ebx
  80036b:	5e                   	pop    %esi
  80036c:	5f                   	pop    %edi
  80036d:	5d                   	pop    %ebp
  80036e:	c3                   	ret    

0080036f <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80036f:	55                   	push   %ebp
  800370:	89 e5                	mov    %esp,%ebp
  800372:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  800375:	83 ec 0c             	sub    $0xc,%esp
  800378:	6a 00                	push   $0x0
  80037a:	e8 7a 14 00 00       	call   8017f9 <sys_destroy_env>
  80037f:	83 c4 10             	add    $0x10,%esp
}
  800382:	90                   	nop
  800383:	c9                   	leave  
  800384:	c3                   	ret    

00800385 <exit>:

void
exit(void)
{
  800385:	55                   	push   %ebp
  800386:	89 e5                	mov    %esp,%ebp
  800388:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  80038b:	e8 cf 14 00 00       	call   80185f <sys_exit_env>
}
  800390:	90                   	nop
  800391:	c9                   	leave  
  800392:	c3                   	ret    

00800393 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800393:	55                   	push   %ebp
  800394:	89 e5                	mov    %esp,%ebp
  800396:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800399:	8d 45 10             	lea    0x10(%ebp),%eax
  80039c:	83 c0 04             	add    $0x4,%eax
  80039f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8003a2:	a1 28 31 80 00       	mov    0x803128,%eax
  8003a7:	85 c0                	test   %eax,%eax
  8003a9:	74 16                	je     8003c1 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8003ab:	a1 28 31 80 00       	mov    0x803128,%eax
  8003b0:	83 ec 08             	sub    $0x8,%esp
  8003b3:	50                   	push   %eax
  8003b4:	68 ac 20 80 00       	push   $0x8020ac
  8003b9:	e8 a3 02 00 00       	call   800661 <cprintf>
  8003be:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  8003c1:	a1 04 30 80 00       	mov    0x803004,%eax
  8003c6:	83 ec 0c             	sub    $0xc,%esp
  8003c9:	ff 75 0c             	pushl  0xc(%ebp)
  8003cc:	ff 75 08             	pushl  0x8(%ebp)
  8003cf:	50                   	push   %eax
  8003d0:	68 b4 20 80 00       	push   $0x8020b4
  8003d5:	6a 74                	push   $0x74
  8003d7:	e8 b2 02 00 00       	call   80068e <cprintf_colored>
  8003dc:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  8003df:	8b 45 10             	mov    0x10(%ebp),%eax
  8003e2:	83 ec 08             	sub    $0x8,%esp
  8003e5:	ff 75 f4             	pushl  -0xc(%ebp)
  8003e8:	50                   	push   %eax
  8003e9:	e8 04 02 00 00       	call   8005f2 <vcprintf>
  8003ee:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8003f1:	83 ec 08             	sub    $0x8,%esp
  8003f4:	6a 00                	push   $0x0
  8003f6:	68 dc 20 80 00       	push   $0x8020dc
  8003fb:	e8 f2 01 00 00       	call   8005f2 <vcprintf>
  800400:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800403:	e8 7d ff ff ff       	call   800385 <exit>

	// should not return here
	while (1) ;
  800408:	eb fe                	jmp    800408 <_panic+0x75>

0080040a <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80040a:	55                   	push   %ebp
  80040b:	89 e5                	mov    %esp,%ebp
  80040d:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800410:	a1 20 30 80 00       	mov    0x803020,%eax
  800415:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  80041b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80041e:	39 c2                	cmp    %eax,%edx
  800420:	74 14                	je     800436 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800422:	83 ec 04             	sub    $0x4,%esp
  800425:	68 e0 20 80 00       	push   $0x8020e0
  80042a:	6a 26                	push   $0x26
  80042c:	68 2c 21 80 00       	push   $0x80212c
  800431:	e8 5d ff ff ff       	call   800393 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800436:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80043d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800444:	e9 c5 00 00 00       	jmp    80050e <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  800449:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80044c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800453:	8b 45 08             	mov    0x8(%ebp),%eax
  800456:	01 d0                	add    %edx,%eax
  800458:	8b 00                	mov    (%eax),%eax
  80045a:	85 c0                	test   %eax,%eax
  80045c:	75 08                	jne    800466 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  80045e:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800461:	e9 a5 00 00 00       	jmp    80050b <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  800466:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80046d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800474:	eb 69                	jmp    8004df <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800476:	a1 20 30 80 00       	mov    0x803020,%eax
  80047b:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800481:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800484:	89 d0                	mov    %edx,%eax
  800486:	01 c0                	add    %eax,%eax
  800488:	01 d0                	add    %edx,%eax
  80048a:	c1 e0 03             	shl    $0x3,%eax
  80048d:	01 c8                	add    %ecx,%eax
  80048f:	8a 40 04             	mov    0x4(%eax),%al
  800492:	84 c0                	test   %al,%al
  800494:	75 46                	jne    8004dc <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800496:	a1 20 30 80 00       	mov    0x803020,%eax
  80049b:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8004a1:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004a4:	89 d0                	mov    %edx,%eax
  8004a6:	01 c0                	add    %eax,%eax
  8004a8:	01 d0                	add    %edx,%eax
  8004aa:	c1 e0 03             	shl    $0x3,%eax
  8004ad:	01 c8                	add    %ecx,%eax
  8004af:	8b 00                	mov    (%eax),%eax
  8004b1:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8004b4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004b7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004bc:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8004be:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004c1:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8004c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8004cb:	01 c8                	add    %ecx,%eax
  8004cd:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8004cf:	39 c2                	cmp    %eax,%edx
  8004d1:	75 09                	jne    8004dc <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  8004d3:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8004da:	eb 15                	jmp    8004f1 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004dc:	ff 45 e8             	incl   -0x18(%ebp)
  8004df:	a1 20 30 80 00       	mov    0x803020,%eax
  8004e4:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8004ea:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8004ed:	39 c2                	cmp    %eax,%edx
  8004ef:	77 85                	ja     800476 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8004f1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8004f5:	75 14                	jne    80050b <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  8004f7:	83 ec 04             	sub    $0x4,%esp
  8004fa:	68 38 21 80 00       	push   $0x802138
  8004ff:	6a 3a                	push   $0x3a
  800501:	68 2c 21 80 00       	push   $0x80212c
  800506:	e8 88 fe ff ff       	call   800393 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80050b:	ff 45 f0             	incl   -0x10(%ebp)
  80050e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800511:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800514:	0f 8c 2f ff ff ff    	jl     800449 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80051a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800521:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800528:	eb 26                	jmp    800550 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80052a:	a1 20 30 80 00       	mov    0x803020,%eax
  80052f:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800535:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800538:	89 d0                	mov    %edx,%eax
  80053a:	01 c0                	add    %eax,%eax
  80053c:	01 d0                	add    %edx,%eax
  80053e:	c1 e0 03             	shl    $0x3,%eax
  800541:	01 c8                	add    %ecx,%eax
  800543:	8a 40 04             	mov    0x4(%eax),%al
  800546:	3c 01                	cmp    $0x1,%al
  800548:	75 03                	jne    80054d <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  80054a:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80054d:	ff 45 e0             	incl   -0x20(%ebp)
  800550:	a1 20 30 80 00       	mov    0x803020,%eax
  800555:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  80055b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80055e:	39 c2                	cmp    %eax,%edx
  800560:	77 c8                	ja     80052a <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800562:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800565:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800568:	74 14                	je     80057e <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  80056a:	83 ec 04             	sub    $0x4,%esp
  80056d:	68 8c 21 80 00       	push   $0x80218c
  800572:	6a 44                	push   $0x44
  800574:	68 2c 21 80 00       	push   $0x80212c
  800579:	e8 15 fe ff ff       	call   800393 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80057e:	90                   	nop
  80057f:	c9                   	leave  
  800580:	c3                   	ret    

00800581 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800581:	55                   	push   %ebp
  800582:	89 e5                	mov    %esp,%ebp
  800584:	53                   	push   %ebx
  800585:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800588:	8b 45 0c             	mov    0xc(%ebp),%eax
  80058b:	8b 00                	mov    (%eax),%eax
  80058d:	8d 48 01             	lea    0x1(%eax),%ecx
  800590:	8b 55 0c             	mov    0xc(%ebp),%edx
  800593:	89 0a                	mov    %ecx,(%edx)
  800595:	8b 55 08             	mov    0x8(%ebp),%edx
  800598:	88 d1                	mov    %dl,%cl
  80059a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80059d:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8005a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005a4:	8b 00                	mov    (%eax),%eax
  8005a6:	3d ff 00 00 00       	cmp    $0xff,%eax
  8005ab:	75 30                	jne    8005dd <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  8005ad:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  8005b3:	a0 40 30 80 00       	mov    0x803040,%al
  8005b8:	0f b6 c0             	movzbl %al,%eax
  8005bb:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8005be:	8b 09                	mov    (%ecx),%ecx
  8005c0:	89 cb                	mov    %ecx,%ebx
  8005c2:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8005c5:	83 c1 08             	add    $0x8,%ecx
  8005c8:	52                   	push   %edx
  8005c9:	50                   	push   %eax
  8005ca:	53                   	push   %ebx
  8005cb:	51                   	push   %ecx
  8005cc:	e8 a0 0f 00 00       	call   801571 <sys_cputs>
  8005d1:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8005d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005d7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8005dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005e0:	8b 40 04             	mov    0x4(%eax),%eax
  8005e3:	8d 50 01             	lea    0x1(%eax),%edx
  8005e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005e9:	89 50 04             	mov    %edx,0x4(%eax)
}
  8005ec:	90                   	nop
  8005ed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8005f0:	c9                   	leave  
  8005f1:	c3                   	ret    

008005f2 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8005f2:	55                   	push   %ebp
  8005f3:	89 e5                	mov    %esp,%ebp
  8005f5:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8005fb:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800602:	00 00 00 
	b.cnt = 0;
  800605:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80060c:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80060f:	ff 75 0c             	pushl  0xc(%ebp)
  800612:	ff 75 08             	pushl  0x8(%ebp)
  800615:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80061b:	50                   	push   %eax
  80061c:	68 81 05 80 00       	push   $0x800581
  800621:	e8 5a 02 00 00       	call   800880 <vprintfmt>
  800626:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800629:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  80062f:	a0 40 30 80 00       	mov    0x803040,%al
  800634:	0f b6 c0             	movzbl %al,%eax
  800637:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  80063d:	52                   	push   %edx
  80063e:	50                   	push   %eax
  80063f:	51                   	push   %ecx
  800640:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800646:	83 c0 08             	add    $0x8,%eax
  800649:	50                   	push   %eax
  80064a:	e8 22 0f 00 00       	call   801571 <sys_cputs>
  80064f:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800652:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  800659:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80065f:	c9                   	leave  
  800660:	c3                   	ret    

00800661 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800661:	55                   	push   %ebp
  800662:	89 e5                	mov    %esp,%ebp
  800664:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800667:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  80066e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800671:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800674:	8b 45 08             	mov    0x8(%ebp),%eax
  800677:	83 ec 08             	sub    $0x8,%esp
  80067a:	ff 75 f4             	pushl  -0xc(%ebp)
  80067d:	50                   	push   %eax
  80067e:	e8 6f ff ff ff       	call   8005f2 <vcprintf>
  800683:	83 c4 10             	add    $0x10,%esp
  800686:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800689:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80068c:	c9                   	leave  
  80068d:	c3                   	ret    

0080068e <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  80068e:	55                   	push   %ebp
  80068f:	89 e5                	mov    %esp,%ebp
  800691:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800694:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  80069b:	8b 45 08             	mov    0x8(%ebp),%eax
  80069e:	c1 e0 08             	shl    $0x8,%eax
  8006a1:	a3 2c 31 80 00       	mov    %eax,0x80312c
	va_start(ap, fmt);
  8006a6:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006a9:	83 c0 04             	add    $0x4,%eax
  8006ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006b2:	83 ec 08             	sub    $0x8,%esp
  8006b5:	ff 75 f4             	pushl  -0xc(%ebp)
  8006b8:	50                   	push   %eax
  8006b9:	e8 34 ff ff ff       	call   8005f2 <vcprintf>
  8006be:	83 c4 10             	add    $0x10,%esp
  8006c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  8006c4:	c7 05 2c 31 80 00 00 	movl   $0x700,0x80312c
  8006cb:	07 00 00 

	return cnt;
  8006ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006d1:	c9                   	leave  
  8006d2:	c3                   	ret    

008006d3 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  8006d3:	55                   	push   %ebp
  8006d4:	89 e5                	mov    %esp,%ebp
  8006d6:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  8006d9:	e8 d7 0e 00 00       	call   8015b5 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  8006de:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  8006e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e7:	83 ec 08             	sub    $0x8,%esp
  8006ea:	ff 75 f4             	pushl  -0xc(%ebp)
  8006ed:	50                   	push   %eax
  8006ee:	e8 ff fe ff ff       	call   8005f2 <vcprintf>
  8006f3:	83 c4 10             	add    $0x10,%esp
  8006f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  8006f9:	e8 d1 0e 00 00       	call   8015cf <sys_unlock_cons>
	return cnt;
  8006fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800701:	c9                   	leave  
  800702:	c3                   	ret    

00800703 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800703:	55                   	push   %ebp
  800704:	89 e5                	mov    %esp,%ebp
  800706:	53                   	push   %ebx
  800707:	83 ec 14             	sub    $0x14,%esp
  80070a:	8b 45 10             	mov    0x10(%ebp),%eax
  80070d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800710:	8b 45 14             	mov    0x14(%ebp),%eax
  800713:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800716:	8b 45 18             	mov    0x18(%ebp),%eax
  800719:	ba 00 00 00 00       	mov    $0x0,%edx
  80071e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800721:	77 55                	ja     800778 <printnum+0x75>
  800723:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800726:	72 05                	jb     80072d <printnum+0x2a>
  800728:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80072b:	77 4b                	ja     800778 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80072d:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800730:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800733:	8b 45 18             	mov    0x18(%ebp),%eax
  800736:	ba 00 00 00 00       	mov    $0x0,%edx
  80073b:	52                   	push   %edx
  80073c:	50                   	push   %eax
  80073d:	ff 75 f4             	pushl  -0xc(%ebp)
  800740:	ff 75 f0             	pushl  -0x10(%ebp)
  800743:	e8 74 13 00 00       	call   801abc <__udivdi3>
  800748:	83 c4 10             	add    $0x10,%esp
  80074b:	83 ec 04             	sub    $0x4,%esp
  80074e:	ff 75 20             	pushl  0x20(%ebp)
  800751:	53                   	push   %ebx
  800752:	ff 75 18             	pushl  0x18(%ebp)
  800755:	52                   	push   %edx
  800756:	50                   	push   %eax
  800757:	ff 75 0c             	pushl  0xc(%ebp)
  80075a:	ff 75 08             	pushl  0x8(%ebp)
  80075d:	e8 a1 ff ff ff       	call   800703 <printnum>
  800762:	83 c4 20             	add    $0x20,%esp
  800765:	eb 1a                	jmp    800781 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800767:	83 ec 08             	sub    $0x8,%esp
  80076a:	ff 75 0c             	pushl  0xc(%ebp)
  80076d:	ff 75 20             	pushl  0x20(%ebp)
  800770:	8b 45 08             	mov    0x8(%ebp),%eax
  800773:	ff d0                	call   *%eax
  800775:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800778:	ff 4d 1c             	decl   0x1c(%ebp)
  80077b:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80077f:	7f e6                	jg     800767 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800781:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800784:	bb 00 00 00 00       	mov    $0x0,%ebx
  800789:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80078c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80078f:	53                   	push   %ebx
  800790:	51                   	push   %ecx
  800791:	52                   	push   %edx
  800792:	50                   	push   %eax
  800793:	e8 34 14 00 00       	call   801bcc <__umoddi3>
  800798:	83 c4 10             	add    $0x10,%esp
  80079b:	05 f4 23 80 00       	add    $0x8023f4,%eax
  8007a0:	8a 00                	mov    (%eax),%al
  8007a2:	0f be c0             	movsbl %al,%eax
  8007a5:	83 ec 08             	sub    $0x8,%esp
  8007a8:	ff 75 0c             	pushl  0xc(%ebp)
  8007ab:	50                   	push   %eax
  8007ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8007af:	ff d0                	call   *%eax
  8007b1:	83 c4 10             	add    $0x10,%esp
}
  8007b4:	90                   	nop
  8007b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8007b8:	c9                   	leave  
  8007b9:	c3                   	ret    

008007ba <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8007ba:	55                   	push   %ebp
  8007bb:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007bd:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8007c1:	7e 1c                	jle    8007df <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8007c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c6:	8b 00                	mov    (%eax),%eax
  8007c8:	8d 50 08             	lea    0x8(%eax),%edx
  8007cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ce:	89 10                	mov    %edx,(%eax)
  8007d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d3:	8b 00                	mov    (%eax),%eax
  8007d5:	83 e8 08             	sub    $0x8,%eax
  8007d8:	8b 50 04             	mov    0x4(%eax),%edx
  8007db:	8b 00                	mov    (%eax),%eax
  8007dd:	eb 40                	jmp    80081f <getuint+0x65>
	else if (lflag)
  8007df:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8007e3:	74 1e                	je     800803 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8007e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e8:	8b 00                	mov    (%eax),%eax
  8007ea:	8d 50 04             	lea    0x4(%eax),%edx
  8007ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f0:	89 10                	mov    %edx,(%eax)
  8007f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f5:	8b 00                	mov    (%eax),%eax
  8007f7:	83 e8 04             	sub    $0x4,%eax
  8007fa:	8b 00                	mov    (%eax),%eax
  8007fc:	ba 00 00 00 00       	mov    $0x0,%edx
  800801:	eb 1c                	jmp    80081f <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800803:	8b 45 08             	mov    0x8(%ebp),%eax
  800806:	8b 00                	mov    (%eax),%eax
  800808:	8d 50 04             	lea    0x4(%eax),%edx
  80080b:	8b 45 08             	mov    0x8(%ebp),%eax
  80080e:	89 10                	mov    %edx,(%eax)
  800810:	8b 45 08             	mov    0x8(%ebp),%eax
  800813:	8b 00                	mov    (%eax),%eax
  800815:	83 e8 04             	sub    $0x4,%eax
  800818:	8b 00                	mov    (%eax),%eax
  80081a:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80081f:	5d                   	pop    %ebp
  800820:	c3                   	ret    

00800821 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800821:	55                   	push   %ebp
  800822:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800824:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800828:	7e 1c                	jle    800846 <getint+0x25>
		return va_arg(*ap, long long);
  80082a:	8b 45 08             	mov    0x8(%ebp),%eax
  80082d:	8b 00                	mov    (%eax),%eax
  80082f:	8d 50 08             	lea    0x8(%eax),%edx
  800832:	8b 45 08             	mov    0x8(%ebp),%eax
  800835:	89 10                	mov    %edx,(%eax)
  800837:	8b 45 08             	mov    0x8(%ebp),%eax
  80083a:	8b 00                	mov    (%eax),%eax
  80083c:	83 e8 08             	sub    $0x8,%eax
  80083f:	8b 50 04             	mov    0x4(%eax),%edx
  800842:	8b 00                	mov    (%eax),%eax
  800844:	eb 38                	jmp    80087e <getint+0x5d>
	else if (lflag)
  800846:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80084a:	74 1a                	je     800866 <getint+0x45>
		return va_arg(*ap, long);
  80084c:	8b 45 08             	mov    0x8(%ebp),%eax
  80084f:	8b 00                	mov    (%eax),%eax
  800851:	8d 50 04             	lea    0x4(%eax),%edx
  800854:	8b 45 08             	mov    0x8(%ebp),%eax
  800857:	89 10                	mov    %edx,(%eax)
  800859:	8b 45 08             	mov    0x8(%ebp),%eax
  80085c:	8b 00                	mov    (%eax),%eax
  80085e:	83 e8 04             	sub    $0x4,%eax
  800861:	8b 00                	mov    (%eax),%eax
  800863:	99                   	cltd   
  800864:	eb 18                	jmp    80087e <getint+0x5d>
	else
		return va_arg(*ap, int);
  800866:	8b 45 08             	mov    0x8(%ebp),%eax
  800869:	8b 00                	mov    (%eax),%eax
  80086b:	8d 50 04             	lea    0x4(%eax),%edx
  80086e:	8b 45 08             	mov    0x8(%ebp),%eax
  800871:	89 10                	mov    %edx,(%eax)
  800873:	8b 45 08             	mov    0x8(%ebp),%eax
  800876:	8b 00                	mov    (%eax),%eax
  800878:	83 e8 04             	sub    $0x4,%eax
  80087b:	8b 00                	mov    (%eax),%eax
  80087d:	99                   	cltd   
}
  80087e:	5d                   	pop    %ebp
  80087f:	c3                   	ret    

00800880 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800880:	55                   	push   %ebp
  800881:	89 e5                	mov    %esp,%ebp
  800883:	56                   	push   %esi
  800884:	53                   	push   %ebx
  800885:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800888:	eb 17                	jmp    8008a1 <vprintfmt+0x21>
			if (ch == '\0')
  80088a:	85 db                	test   %ebx,%ebx
  80088c:	0f 84 c1 03 00 00    	je     800c53 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  800892:	83 ec 08             	sub    $0x8,%esp
  800895:	ff 75 0c             	pushl  0xc(%ebp)
  800898:	53                   	push   %ebx
  800899:	8b 45 08             	mov    0x8(%ebp),%eax
  80089c:	ff d0                	call   *%eax
  80089e:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8008a1:	8b 45 10             	mov    0x10(%ebp),%eax
  8008a4:	8d 50 01             	lea    0x1(%eax),%edx
  8008a7:	89 55 10             	mov    %edx,0x10(%ebp)
  8008aa:	8a 00                	mov    (%eax),%al
  8008ac:	0f b6 d8             	movzbl %al,%ebx
  8008af:	83 fb 25             	cmp    $0x25,%ebx
  8008b2:	75 d6                	jne    80088a <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8008b4:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8008b8:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8008bf:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8008c6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8008cd:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8008d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8008d7:	8d 50 01             	lea    0x1(%eax),%edx
  8008da:	89 55 10             	mov    %edx,0x10(%ebp)
  8008dd:	8a 00                	mov    (%eax),%al
  8008df:	0f b6 d8             	movzbl %al,%ebx
  8008e2:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8008e5:	83 f8 5b             	cmp    $0x5b,%eax
  8008e8:	0f 87 3d 03 00 00    	ja     800c2b <vprintfmt+0x3ab>
  8008ee:	8b 04 85 18 24 80 00 	mov    0x802418(,%eax,4),%eax
  8008f5:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8008f7:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8008fb:	eb d7                	jmp    8008d4 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8008fd:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800901:	eb d1                	jmp    8008d4 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800903:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80090a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80090d:	89 d0                	mov    %edx,%eax
  80090f:	c1 e0 02             	shl    $0x2,%eax
  800912:	01 d0                	add    %edx,%eax
  800914:	01 c0                	add    %eax,%eax
  800916:	01 d8                	add    %ebx,%eax
  800918:	83 e8 30             	sub    $0x30,%eax
  80091b:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80091e:	8b 45 10             	mov    0x10(%ebp),%eax
  800921:	8a 00                	mov    (%eax),%al
  800923:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800926:	83 fb 2f             	cmp    $0x2f,%ebx
  800929:	7e 3e                	jle    800969 <vprintfmt+0xe9>
  80092b:	83 fb 39             	cmp    $0x39,%ebx
  80092e:	7f 39                	jg     800969 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800930:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800933:	eb d5                	jmp    80090a <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800935:	8b 45 14             	mov    0x14(%ebp),%eax
  800938:	83 c0 04             	add    $0x4,%eax
  80093b:	89 45 14             	mov    %eax,0x14(%ebp)
  80093e:	8b 45 14             	mov    0x14(%ebp),%eax
  800941:	83 e8 04             	sub    $0x4,%eax
  800944:	8b 00                	mov    (%eax),%eax
  800946:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800949:	eb 1f                	jmp    80096a <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80094b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80094f:	79 83                	jns    8008d4 <vprintfmt+0x54>
				width = 0;
  800951:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800958:	e9 77 ff ff ff       	jmp    8008d4 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80095d:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800964:	e9 6b ff ff ff       	jmp    8008d4 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800969:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80096a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80096e:	0f 89 60 ff ff ff    	jns    8008d4 <vprintfmt+0x54>
				width = precision, precision = -1;
  800974:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800977:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80097a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800981:	e9 4e ff ff ff       	jmp    8008d4 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800986:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800989:	e9 46 ff ff ff       	jmp    8008d4 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80098e:	8b 45 14             	mov    0x14(%ebp),%eax
  800991:	83 c0 04             	add    $0x4,%eax
  800994:	89 45 14             	mov    %eax,0x14(%ebp)
  800997:	8b 45 14             	mov    0x14(%ebp),%eax
  80099a:	83 e8 04             	sub    $0x4,%eax
  80099d:	8b 00                	mov    (%eax),%eax
  80099f:	83 ec 08             	sub    $0x8,%esp
  8009a2:	ff 75 0c             	pushl  0xc(%ebp)
  8009a5:	50                   	push   %eax
  8009a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a9:	ff d0                	call   *%eax
  8009ab:	83 c4 10             	add    $0x10,%esp
			break;
  8009ae:	e9 9b 02 00 00       	jmp    800c4e <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8009b3:	8b 45 14             	mov    0x14(%ebp),%eax
  8009b6:	83 c0 04             	add    $0x4,%eax
  8009b9:	89 45 14             	mov    %eax,0x14(%ebp)
  8009bc:	8b 45 14             	mov    0x14(%ebp),%eax
  8009bf:	83 e8 04             	sub    $0x4,%eax
  8009c2:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8009c4:	85 db                	test   %ebx,%ebx
  8009c6:	79 02                	jns    8009ca <vprintfmt+0x14a>
				err = -err;
  8009c8:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8009ca:	83 fb 64             	cmp    $0x64,%ebx
  8009cd:	7f 0b                	jg     8009da <vprintfmt+0x15a>
  8009cf:	8b 34 9d 60 22 80 00 	mov    0x802260(,%ebx,4),%esi
  8009d6:	85 f6                	test   %esi,%esi
  8009d8:	75 19                	jne    8009f3 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8009da:	53                   	push   %ebx
  8009db:	68 05 24 80 00       	push   $0x802405
  8009e0:	ff 75 0c             	pushl  0xc(%ebp)
  8009e3:	ff 75 08             	pushl  0x8(%ebp)
  8009e6:	e8 70 02 00 00       	call   800c5b <printfmt>
  8009eb:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8009ee:	e9 5b 02 00 00       	jmp    800c4e <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8009f3:	56                   	push   %esi
  8009f4:	68 0e 24 80 00       	push   $0x80240e
  8009f9:	ff 75 0c             	pushl  0xc(%ebp)
  8009fc:	ff 75 08             	pushl  0x8(%ebp)
  8009ff:	e8 57 02 00 00       	call   800c5b <printfmt>
  800a04:	83 c4 10             	add    $0x10,%esp
			break;
  800a07:	e9 42 02 00 00       	jmp    800c4e <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800a0c:	8b 45 14             	mov    0x14(%ebp),%eax
  800a0f:	83 c0 04             	add    $0x4,%eax
  800a12:	89 45 14             	mov    %eax,0x14(%ebp)
  800a15:	8b 45 14             	mov    0x14(%ebp),%eax
  800a18:	83 e8 04             	sub    $0x4,%eax
  800a1b:	8b 30                	mov    (%eax),%esi
  800a1d:	85 f6                	test   %esi,%esi
  800a1f:	75 05                	jne    800a26 <vprintfmt+0x1a6>
				p = "(null)";
  800a21:	be 11 24 80 00       	mov    $0x802411,%esi
			if (width > 0 && padc != '-')
  800a26:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a2a:	7e 6d                	jle    800a99 <vprintfmt+0x219>
  800a2c:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800a30:	74 67                	je     800a99 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800a32:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a35:	83 ec 08             	sub    $0x8,%esp
  800a38:	50                   	push   %eax
  800a39:	56                   	push   %esi
  800a3a:	e8 1e 03 00 00       	call   800d5d <strnlen>
  800a3f:	83 c4 10             	add    $0x10,%esp
  800a42:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800a45:	eb 16                	jmp    800a5d <vprintfmt+0x1dd>
					putch(padc, putdat);
  800a47:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800a4b:	83 ec 08             	sub    $0x8,%esp
  800a4e:	ff 75 0c             	pushl  0xc(%ebp)
  800a51:	50                   	push   %eax
  800a52:	8b 45 08             	mov    0x8(%ebp),%eax
  800a55:	ff d0                	call   *%eax
  800a57:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800a5a:	ff 4d e4             	decl   -0x1c(%ebp)
  800a5d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a61:	7f e4                	jg     800a47 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a63:	eb 34                	jmp    800a99 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800a65:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800a69:	74 1c                	je     800a87 <vprintfmt+0x207>
  800a6b:	83 fb 1f             	cmp    $0x1f,%ebx
  800a6e:	7e 05                	jle    800a75 <vprintfmt+0x1f5>
  800a70:	83 fb 7e             	cmp    $0x7e,%ebx
  800a73:	7e 12                	jle    800a87 <vprintfmt+0x207>
					putch('?', putdat);
  800a75:	83 ec 08             	sub    $0x8,%esp
  800a78:	ff 75 0c             	pushl  0xc(%ebp)
  800a7b:	6a 3f                	push   $0x3f
  800a7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a80:	ff d0                	call   *%eax
  800a82:	83 c4 10             	add    $0x10,%esp
  800a85:	eb 0f                	jmp    800a96 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800a87:	83 ec 08             	sub    $0x8,%esp
  800a8a:	ff 75 0c             	pushl  0xc(%ebp)
  800a8d:	53                   	push   %ebx
  800a8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a91:	ff d0                	call   *%eax
  800a93:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a96:	ff 4d e4             	decl   -0x1c(%ebp)
  800a99:	89 f0                	mov    %esi,%eax
  800a9b:	8d 70 01             	lea    0x1(%eax),%esi
  800a9e:	8a 00                	mov    (%eax),%al
  800aa0:	0f be d8             	movsbl %al,%ebx
  800aa3:	85 db                	test   %ebx,%ebx
  800aa5:	74 24                	je     800acb <vprintfmt+0x24b>
  800aa7:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800aab:	78 b8                	js     800a65 <vprintfmt+0x1e5>
  800aad:	ff 4d e0             	decl   -0x20(%ebp)
  800ab0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800ab4:	79 af                	jns    800a65 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ab6:	eb 13                	jmp    800acb <vprintfmt+0x24b>
				putch(' ', putdat);
  800ab8:	83 ec 08             	sub    $0x8,%esp
  800abb:	ff 75 0c             	pushl  0xc(%ebp)
  800abe:	6a 20                	push   $0x20
  800ac0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac3:	ff d0                	call   *%eax
  800ac5:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ac8:	ff 4d e4             	decl   -0x1c(%ebp)
  800acb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800acf:	7f e7                	jg     800ab8 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800ad1:	e9 78 01 00 00       	jmp    800c4e <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800ad6:	83 ec 08             	sub    $0x8,%esp
  800ad9:	ff 75 e8             	pushl  -0x18(%ebp)
  800adc:	8d 45 14             	lea    0x14(%ebp),%eax
  800adf:	50                   	push   %eax
  800ae0:	e8 3c fd ff ff       	call   800821 <getint>
  800ae5:	83 c4 10             	add    $0x10,%esp
  800ae8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800aeb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800aee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800af1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800af4:	85 d2                	test   %edx,%edx
  800af6:	79 23                	jns    800b1b <vprintfmt+0x29b>
				putch('-', putdat);
  800af8:	83 ec 08             	sub    $0x8,%esp
  800afb:	ff 75 0c             	pushl  0xc(%ebp)
  800afe:	6a 2d                	push   $0x2d
  800b00:	8b 45 08             	mov    0x8(%ebp),%eax
  800b03:	ff d0                	call   *%eax
  800b05:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800b08:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b0b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b0e:	f7 d8                	neg    %eax
  800b10:	83 d2 00             	adc    $0x0,%edx
  800b13:	f7 da                	neg    %edx
  800b15:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b18:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800b1b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b22:	e9 bc 00 00 00       	jmp    800be3 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800b27:	83 ec 08             	sub    $0x8,%esp
  800b2a:	ff 75 e8             	pushl  -0x18(%ebp)
  800b2d:	8d 45 14             	lea    0x14(%ebp),%eax
  800b30:	50                   	push   %eax
  800b31:	e8 84 fc ff ff       	call   8007ba <getuint>
  800b36:	83 c4 10             	add    $0x10,%esp
  800b39:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b3c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800b3f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b46:	e9 98 00 00 00       	jmp    800be3 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800b4b:	83 ec 08             	sub    $0x8,%esp
  800b4e:	ff 75 0c             	pushl  0xc(%ebp)
  800b51:	6a 58                	push   $0x58
  800b53:	8b 45 08             	mov    0x8(%ebp),%eax
  800b56:	ff d0                	call   *%eax
  800b58:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b5b:	83 ec 08             	sub    $0x8,%esp
  800b5e:	ff 75 0c             	pushl  0xc(%ebp)
  800b61:	6a 58                	push   $0x58
  800b63:	8b 45 08             	mov    0x8(%ebp),%eax
  800b66:	ff d0                	call   *%eax
  800b68:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b6b:	83 ec 08             	sub    $0x8,%esp
  800b6e:	ff 75 0c             	pushl  0xc(%ebp)
  800b71:	6a 58                	push   $0x58
  800b73:	8b 45 08             	mov    0x8(%ebp),%eax
  800b76:	ff d0                	call   *%eax
  800b78:	83 c4 10             	add    $0x10,%esp
			break;
  800b7b:	e9 ce 00 00 00       	jmp    800c4e <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800b80:	83 ec 08             	sub    $0x8,%esp
  800b83:	ff 75 0c             	pushl  0xc(%ebp)
  800b86:	6a 30                	push   $0x30
  800b88:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8b:	ff d0                	call   *%eax
  800b8d:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800b90:	83 ec 08             	sub    $0x8,%esp
  800b93:	ff 75 0c             	pushl  0xc(%ebp)
  800b96:	6a 78                	push   $0x78
  800b98:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9b:	ff d0                	call   *%eax
  800b9d:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ba0:	8b 45 14             	mov    0x14(%ebp),%eax
  800ba3:	83 c0 04             	add    $0x4,%eax
  800ba6:	89 45 14             	mov    %eax,0x14(%ebp)
  800ba9:	8b 45 14             	mov    0x14(%ebp),%eax
  800bac:	83 e8 04             	sub    $0x4,%eax
  800baf:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800bb1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bb4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800bbb:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800bc2:	eb 1f                	jmp    800be3 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800bc4:	83 ec 08             	sub    $0x8,%esp
  800bc7:	ff 75 e8             	pushl  -0x18(%ebp)
  800bca:	8d 45 14             	lea    0x14(%ebp),%eax
  800bcd:	50                   	push   %eax
  800bce:	e8 e7 fb ff ff       	call   8007ba <getuint>
  800bd3:	83 c4 10             	add    $0x10,%esp
  800bd6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bd9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800bdc:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800be3:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800be7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800bea:	83 ec 04             	sub    $0x4,%esp
  800bed:	52                   	push   %edx
  800bee:	ff 75 e4             	pushl  -0x1c(%ebp)
  800bf1:	50                   	push   %eax
  800bf2:	ff 75 f4             	pushl  -0xc(%ebp)
  800bf5:	ff 75 f0             	pushl  -0x10(%ebp)
  800bf8:	ff 75 0c             	pushl  0xc(%ebp)
  800bfb:	ff 75 08             	pushl  0x8(%ebp)
  800bfe:	e8 00 fb ff ff       	call   800703 <printnum>
  800c03:	83 c4 20             	add    $0x20,%esp
			break;
  800c06:	eb 46                	jmp    800c4e <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800c08:	83 ec 08             	sub    $0x8,%esp
  800c0b:	ff 75 0c             	pushl  0xc(%ebp)
  800c0e:	53                   	push   %ebx
  800c0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c12:	ff d0                	call   *%eax
  800c14:	83 c4 10             	add    $0x10,%esp
			break;
  800c17:	eb 35                	jmp    800c4e <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800c19:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  800c20:	eb 2c                	jmp    800c4e <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800c22:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  800c29:	eb 23                	jmp    800c4e <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800c2b:	83 ec 08             	sub    $0x8,%esp
  800c2e:	ff 75 0c             	pushl  0xc(%ebp)
  800c31:	6a 25                	push   $0x25
  800c33:	8b 45 08             	mov    0x8(%ebp),%eax
  800c36:	ff d0                	call   *%eax
  800c38:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800c3b:	ff 4d 10             	decl   0x10(%ebp)
  800c3e:	eb 03                	jmp    800c43 <vprintfmt+0x3c3>
  800c40:	ff 4d 10             	decl   0x10(%ebp)
  800c43:	8b 45 10             	mov    0x10(%ebp),%eax
  800c46:	48                   	dec    %eax
  800c47:	8a 00                	mov    (%eax),%al
  800c49:	3c 25                	cmp    $0x25,%al
  800c4b:	75 f3                	jne    800c40 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800c4d:	90                   	nop
		}
	}
  800c4e:	e9 35 fc ff ff       	jmp    800888 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800c53:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800c54:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800c57:	5b                   	pop    %ebx
  800c58:	5e                   	pop    %esi
  800c59:	5d                   	pop    %ebp
  800c5a:	c3                   	ret    

00800c5b <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800c5b:	55                   	push   %ebp
  800c5c:	89 e5                	mov    %esp,%ebp
  800c5e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800c61:	8d 45 10             	lea    0x10(%ebp),%eax
  800c64:	83 c0 04             	add    $0x4,%eax
  800c67:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800c6a:	8b 45 10             	mov    0x10(%ebp),%eax
  800c6d:	ff 75 f4             	pushl  -0xc(%ebp)
  800c70:	50                   	push   %eax
  800c71:	ff 75 0c             	pushl  0xc(%ebp)
  800c74:	ff 75 08             	pushl  0x8(%ebp)
  800c77:	e8 04 fc ff ff       	call   800880 <vprintfmt>
  800c7c:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800c7f:	90                   	nop
  800c80:	c9                   	leave  
  800c81:	c3                   	ret    

00800c82 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800c82:	55                   	push   %ebp
  800c83:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800c85:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c88:	8b 40 08             	mov    0x8(%eax),%eax
  800c8b:	8d 50 01             	lea    0x1(%eax),%edx
  800c8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c91:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800c94:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c97:	8b 10                	mov    (%eax),%edx
  800c99:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c9c:	8b 40 04             	mov    0x4(%eax),%eax
  800c9f:	39 c2                	cmp    %eax,%edx
  800ca1:	73 12                	jae    800cb5 <sprintputch+0x33>
		*b->buf++ = ch;
  800ca3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca6:	8b 00                	mov    (%eax),%eax
  800ca8:	8d 48 01             	lea    0x1(%eax),%ecx
  800cab:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cae:	89 0a                	mov    %ecx,(%edx)
  800cb0:	8b 55 08             	mov    0x8(%ebp),%edx
  800cb3:	88 10                	mov    %dl,(%eax)
}
  800cb5:	90                   	nop
  800cb6:	5d                   	pop    %ebp
  800cb7:	c3                   	ret    

00800cb8 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800cb8:	55                   	push   %ebp
  800cb9:	89 e5                	mov    %esp,%ebp
  800cbb:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800cbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800cc4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc7:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cca:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccd:	01 d0                	add    %edx,%eax
  800ccf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cd2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800cd9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800cdd:	74 06                	je     800ce5 <vsnprintf+0x2d>
  800cdf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ce3:	7f 07                	jg     800cec <vsnprintf+0x34>
		return -E_INVAL;
  800ce5:	b8 03 00 00 00       	mov    $0x3,%eax
  800cea:	eb 20                	jmp    800d0c <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800cec:	ff 75 14             	pushl  0x14(%ebp)
  800cef:	ff 75 10             	pushl  0x10(%ebp)
  800cf2:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800cf5:	50                   	push   %eax
  800cf6:	68 82 0c 80 00       	push   $0x800c82
  800cfb:	e8 80 fb ff ff       	call   800880 <vprintfmt>
  800d00:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800d03:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d06:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800d09:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800d0c:	c9                   	leave  
  800d0d:	c3                   	ret    

00800d0e <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800d0e:	55                   	push   %ebp
  800d0f:	89 e5                	mov    %esp,%ebp
  800d11:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800d14:	8d 45 10             	lea    0x10(%ebp),%eax
  800d17:	83 c0 04             	add    $0x4,%eax
  800d1a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800d1d:	8b 45 10             	mov    0x10(%ebp),%eax
  800d20:	ff 75 f4             	pushl  -0xc(%ebp)
  800d23:	50                   	push   %eax
  800d24:	ff 75 0c             	pushl  0xc(%ebp)
  800d27:	ff 75 08             	pushl  0x8(%ebp)
  800d2a:	e8 89 ff ff ff       	call   800cb8 <vsnprintf>
  800d2f:	83 c4 10             	add    $0x10,%esp
  800d32:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800d35:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d38:	c9                   	leave  
  800d39:	c3                   	ret    

00800d3a <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800d3a:	55                   	push   %ebp
  800d3b:	89 e5                	mov    %esp,%ebp
  800d3d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800d40:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d47:	eb 06                	jmp    800d4f <strlen+0x15>
		n++;
  800d49:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800d4c:	ff 45 08             	incl   0x8(%ebp)
  800d4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d52:	8a 00                	mov    (%eax),%al
  800d54:	84 c0                	test   %al,%al
  800d56:	75 f1                	jne    800d49 <strlen+0xf>
		n++;
	return n;
  800d58:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d5b:	c9                   	leave  
  800d5c:	c3                   	ret    

00800d5d <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800d5d:	55                   	push   %ebp
  800d5e:	89 e5                	mov    %esp,%ebp
  800d60:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d63:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d6a:	eb 09                	jmp    800d75 <strnlen+0x18>
		n++;
  800d6c:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d6f:	ff 45 08             	incl   0x8(%ebp)
  800d72:	ff 4d 0c             	decl   0xc(%ebp)
  800d75:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d79:	74 09                	je     800d84 <strnlen+0x27>
  800d7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7e:	8a 00                	mov    (%eax),%al
  800d80:	84 c0                	test   %al,%al
  800d82:	75 e8                	jne    800d6c <strnlen+0xf>
		n++;
	return n;
  800d84:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d87:	c9                   	leave  
  800d88:	c3                   	ret    

00800d89 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800d89:	55                   	push   %ebp
  800d8a:	89 e5                	mov    %esp,%ebp
  800d8c:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800d8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d92:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800d95:	90                   	nop
  800d96:	8b 45 08             	mov    0x8(%ebp),%eax
  800d99:	8d 50 01             	lea    0x1(%eax),%edx
  800d9c:	89 55 08             	mov    %edx,0x8(%ebp)
  800d9f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800da2:	8d 4a 01             	lea    0x1(%edx),%ecx
  800da5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800da8:	8a 12                	mov    (%edx),%dl
  800daa:	88 10                	mov    %dl,(%eax)
  800dac:	8a 00                	mov    (%eax),%al
  800dae:	84 c0                	test   %al,%al
  800db0:	75 e4                	jne    800d96 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800db2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800db5:	c9                   	leave  
  800db6:	c3                   	ret    

00800db7 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800db7:	55                   	push   %ebp
  800db8:	89 e5                	mov    %esp,%ebp
  800dba:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800dbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800dc3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800dca:	eb 1f                	jmp    800deb <strncpy+0x34>
		*dst++ = *src;
  800dcc:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcf:	8d 50 01             	lea    0x1(%eax),%edx
  800dd2:	89 55 08             	mov    %edx,0x8(%ebp)
  800dd5:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dd8:	8a 12                	mov    (%edx),%dl
  800dda:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800ddc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ddf:	8a 00                	mov    (%eax),%al
  800de1:	84 c0                	test   %al,%al
  800de3:	74 03                	je     800de8 <strncpy+0x31>
			src++;
  800de5:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800de8:	ff 45 fc             	incl   -0x4(%ebp)
  800deb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dee:	3b 45 10             	cmp    0x10(%ebp),%eax
  800df1:	72 d9                	jb     800dcc <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800df3:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800df6:	c9                   	leave  
  800df7:	c3                   	ret    

00800df8 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800df8:	55                   	push   %ebp
  800df9:	89 e5                	mov    %esp,%ebp
  800dfb:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800dfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800e01:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800e04:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e08:	74 30                	je     800e3a <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800e0a:	eb 16                	jmp    800e22 <strlcpy+0x2a>
			*dst++ = *src++;
  800e0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0f:	8d 50 01             	lea    0x1(%eax),%edx
  800e12:	89 55 08             	mov    %edx,0x8(%ebp)
  800e15:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e18:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e1b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e1e:	8a 12                	mov    (%edx),%dl
  800e20:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800e22:	ff 4d 10             	decl   0x10(%ebp)
  800e25:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e29:	74 09                	je     800e34 <strlcpy+0x3c>
  800e2b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e2e:	8a 00                	mov    (%eax),%al
  800e30:	84 c0                	test   %al,%al
  800e32:	75 d8                	jne    800e0c <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800e34:	8b 45 08             	mov    0x8(%ebp),%eax
  800e37:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800e3a:	8b 55 08             	mov    0x8(%ebp),%edx
  800e3d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e40:	29 c2                	sub    %eax,%edx
  800e42:	89 d0                	mov    %edx,%eax
}
  800e44:	c9                   	leave  
  800e45:	c3                   	ret    

00800e46 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800e46:	55                   	push   %ebp
  800e47:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800e49:	eb 06                	jmp    800e51 <strcmp+0xb>
		p++, q++;
  800e4b:	ff 45 08             	incl   0x8(%ebp)
  800e4e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800e51:	8b 45 08             	mov    0x8(%ebp),%eax
  800e54:	8a 00                	mov    (%eax),%al
  800e56:	84 c0                	test   %al,%al
  800e58:	74 0e                	je     800e68 <strcmp+0x22>
  800e5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5d:	8a 10                	mov    (%eax),%dl
  800e5f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e62:	8a 00                	mov    (%eax),%al
  800e64:	38 c2                	cmp    %al,%dl
  800e66:	74 e3                	je     800e4b <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800e68:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6b:	8a 00                	mov    (%eax),%al
  800e6d:	0f b6 d0             	movzbl %al,%edx
  800e70:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e73:	8a 00                	mov    (%eax),%al
  800e75:	0f b6 c0             	movzbl %al,%eax
  800e78:	29 c2                	sub    %eax,%edx
  800e7a:	89 d0                	mov    %edx,%eax
}
  800e7c:	5d                   	pop    %ebp
  800e7d:	c3                   	ret    

00800e7e <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800e7e:	55                   	push   %ebp
  800e7f:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800e81:	eb 09                	jmp    800e8c <strncmp+0xe>
		n--, p++, q++;
  800e83:	ff 4d 10             	decl   0x10(%ebp)
  800e86:	ff 45 08             	incl   0x8(%ebp)
  800e89:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800e8c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e90:	74 17                	je     800ea9 <strncmp+0x2b>
  800e92:	8b 45 08             	mov    0x8(%ebp),%eax
  800e95:	8a 00                	mov    (%eax),%al
  800e97:	84 c0                	test   %al,%al
  800e99:	74 0e                	je     800ea9 <strncmp+0x2b>
  800e9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9e:	8a 10                	mov    (%eax),%dl
  800ea0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea3:	8a 00                	mov    (%eax),%al
  800ea5:	38 c2                	cmp    %al,%dl
  800ea7:	74 da                	je     800e83 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800ea9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ead:	75 07                	jne    800eb6 <strncmp+0x38>
		return 0;
  800eaf:	b8 00 00 00 00       	mov    $0x0,%eax
  800eb4:	eb 14                	jmp    800eca <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800eb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb9:	8a 00                	mov    (%eax),%al
  800ebb:	0f b6 d0             	movzbl %al,%edx
  800ebe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec1:	8a 00                	mov    (%eax),%al
  800ec3:	0f b6 c0             	movzbl %al,%eax
  800ec6:	29 c2                	sub    %eax,%edx
  800ec8:	89 d0                	mov    %edx,%eax
}
  800eca:	5d                   	pop    %ebp
  800ecb:	c3                   	ret    

00800ecc <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ecc:	55                   	push   %ebp
  800ecd:	89 e5                	mov    %esp,%ebp
  800ecf:	83 ec 04             	sub    $0x4,%esp
  800ed2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed5:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ed8:	eb 12                	jmp    800eec <strchr+0x20>
		if (*s == c)
  800eda:	8b 45 08             	mov    0x8(%ebp),%eax
  800edd:	8a 00                	mov    (%eax),%al
  800edf:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ee2:	75 05                	jne    800ee9 <strchr+0x1d>
			return (char *) s;
  800ee4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee7:	eb 11                	jmp    800efa <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ee9:	ff 45 08             	incl   0x8(%ebp)
  800eec:	8b 45 08             	mov    0x8(%ebp),%eax
  800eef:	8a 00                	mov    (%eax),%al
  800ef1:	84 c0                	test   %al,%al
  800ef3:	75 e5                	jne    800eda <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ef5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800efa:	c9                   	leave  
  800efb:	c3                   	ret    

00800efc <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800efc:	55                   	push   %ebp
  800efd:	89 e5                	mov    %esp,%ebp
  800eff:	83 ec 04             	sub    $0x4,%esp
  800f02:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f05:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f08:	eb 0d                	jmp    800f17 <strfind+0x1b>
		if (*s == c)
  800f0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0d:	8a 00                	mov    (%eax),%al
  800f0f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f12:	74 0e                	je     800f22 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800f14:	ff 45 08             	incl   0x8(%ebp)
  800f17:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1a:	8a 00                	mov    (%eax),%al
  800f1c:	84 c0                	test   %al,%al
  800f1e:	75 ea                	jne    800f0a <strfind+0xe>
  800f20:	eb 01                	jmp    800f23 <strfind+0x27>
		if (*s == c)
			break;
  800f22:	90                   	nop
	return (char *) s;
  800f23:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f26:	c9                   	leave  
  800f27:	c3                   	ret    

00800f28 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800f28:	55                   	push   %ebp
  800f29:	89 e5                	mov    %esp,%ebp
  800f2b:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800f2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f31:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800f34:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f38:	76 63                	jbe    800f9d <memset+0x75>
		uint64 data_block = c;
  800f3a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f3d:	99                   	cltd   
  800f3e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f41:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800f44:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f47:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f4a:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800f4e:	c1 e0 08             	shl    $0x8,%eax
  800f51:	09 45 f0             	or     %eax,-0x10(%ebp)
  800f54:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800f57:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f5a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f5d:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800f61:	c1 e0 10             	shl    $0x10,%eax
  800f64:	09 45 f0             	or     %eax,-0x10(%ebp)
  800f67:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800f6a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f6d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f70:	89 c2                	mov    %eax,%edx
  800f72:	b8 00 00 00 00       	mov    $0x0,%eax
  800f77:	09 45 f0             	or     %eax,-0x10(%ebp)
  800f7a:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800f7d:	eb 18                	jmp    800f97 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800f7f:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f82:	8d 41 08             	lea    0x8(%ecx),%eax
  800f85:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800f88:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f8b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f8e:	89 01                	mov    %eax,(%ecx)
  800f90:	89 51 04             	mov    %edx,0x4(%ecx)
  800f93:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800f97:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f9b:	77 e2                	ja     800f7f <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800f9d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fa1:	74 23                	je     800fc6 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  800fa3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fa6:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  800fa9:	eb 0e                	jmp    800fb9 <memset+0x91>
			*p8++ = (uint8)c;
  800fab:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fae:	8d 50 01             	lea    0x1(%eax),%edx
  800fb1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fb4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fb7:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  800fb9:	8b 45 10             	mov    0x10(%ebp),%eax
  800fbc:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fbf:	89 55 10             	mov    %edx,0x10(%ebp)
  800fc2:	85 c0                	test   %eax,%eax
  800fc4:	75 e5                	jne    800fab <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  800fc6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fc9:	c9                   	leave  
  800fca:	c3                   	ret    

00800fcb <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800fcb:	55                   	push   %ebp
  800fcc:	89 e5                	mov    %esp,%ebp
  800fce:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  800fd1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  800fd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fda:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  800fdd:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800fe1:	76 24                	jbe    801007 <memcpy+0x3c>
		while(n >= 8){
  800fe3:	eb 1c                	jmp    801001 <memcpy+0x36>
			*d64 = *s64;
  800fe5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fe8:	8b 50 04             	mov    0x4(%eax),%edx
  800feb:	8b 00                	mov    (%eax),%eax
  800fed:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800ff0:	89 01                	mov    %eax,(%ecx)
  800ff2:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  800ff5:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  800ff9:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  800ffd:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  801001:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801005:	77 de                	ja     800fe5 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  801007:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80100b:	74 31                	je     80103e <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  80100d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801010:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  801013:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801016:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  801019:	eb 16                	jmp    801031 <memcpy+0x66>
			*d8++ = *s8++;
  80101b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80101e:	8d 50 01             	lea    0x1(%eax),%edx
  801021:	89 55 f0             	mov    %edx,-0x10(%ebp)
  801024:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801027:	8d 4a 01             	lea    0x1(%edx),%ecx
  80102a:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  80102d:	8a 12                	mov    (%edx),%dl
  80102f:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  801031:	8b 45 10             	mov    0x10(%ebp),%eax
  801034:	8d 50 ff             	lea    -0x1(%eax),%edx
  801037:	89 55 10             	mov    %edx,0x10(%ebp)
  80103a:	85 c0                	test   %eax,%eax
  80103c:	75 dd                	jne    80101b <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  80103e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801041:	c9                   	leave  
  801042:	c3                   	ret    

00801043 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801043:	55                   	push   %ebp
  801044:	89 e5                	mov    %esp,%ebp
  801046:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801049:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80104f:	8b 45 08             	mov    0x8(%ebp),%eax
  801052:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801055:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801058:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80105b:	73 50                	jae    8010ad <memmove+0x6a>
  80105d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801060:	8b 45 10             	mov    0x10(%ebp),%eax
  801063:	01 d0                	add    %edx,%eax
  801065:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801068:	76 43                	jbe    8010ad <memmove+0x6a>
		s += n;
  80106a:	8b 45 10             	mov    0x10(%ebp),%eax
  80106d:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801070:	8b 45 10             	mov    0x10(%ebp),%eax
  801073:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801076:	eb 10                	jmp    801088 <memmove+0x45>
			*--d = *--s;
  801078:	ff 4d f8             	decl   -0x8(%ebp)
  80107b:	ff 4d fc             	decl   -0x4(%ebp)
  80107e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801081:	8a 10                	mov    (%eax),%dl
  801083:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801086:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801088:	8b 45 10             	mov    0x10(%ebp),%eax
  80108b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80108e:	89 55 10             	mov    %edx,0x10(%ebp)
  801091:	85 c0                	test   %eax,%eax
  801093:	75 e3                	jne    801078 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801095:	eb 23                	jmp    8010ba <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801097:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80109a:	8d 50 01             	lea    0x1(%eax),%edx
  80109d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010a0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010a3:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010a6:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8010a9:	8a 12                	mov    (%edx),%dl
  8010ab:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8010ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8010b0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010b3:	89 55 10             	mov    %edx,0x10(%ebp)
  8010b6:	85 c0                	test   %eax,%eax
  8010b8:	75 dd                	jne    801097 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8010ba:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010bd:	c9                   	leave  
  8010be:	c3                   	ret    

008010bf <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8010bf:	55                   	push   %ebp
  8010c0:	89 e5                	mov    %esp,%ebp
  8010c2:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8010c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8010cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ce:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8010d1:	eb 2a                	jmp    8010fd <memcmp+0x3e>
		if (*s1 != *s2)
  8010d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010d6:	8a 10                	mov    (%eax),%dl
  8010d8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010db:	8a 00                	mov    (%eax),%al
  8010dd:	38 c2                	cmp    %al,%dl
  8010df:	74 16                	je     8010f7 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8010e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010e4:	8a 00                	mov    (%eax),%al
  8010e6:	0f b6 d0             	movzbl %al,%edx
  8010e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010ec:	8a 00                	mov    (%eax),%al
  8010ee:	0f b6 c0             	movzbl %al,%eax
  8010f1:	29 c2                	sub    %eax,%edx
  8010f3:	89 d0                	mov    %edx,%eax
  8010f5:	eb 18                	jmp    80110f <memcmp+0x50>
		s1++, s2++;
  8010f7:	ff 45 fc             	incl   -0x4(%ebp)
  8010fa:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8010fd:	8b 45 10             	mov    0x10(%ebp),%eax
  801100:	8d 50 ff             	lea    -0x1(%eax),%edx
  801103:	89 55 10             	mov    %edx,0x10(%ebp)
  801106:	85 c0                	test   %eax,%eax
  801108:	75 c9                	jne    8010d3 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80110a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80110f:	c9                   	leave  
  801110:	c3                   	ret    

00801111 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801111:	55                   	push   %ebp
  801112:	89 e5                	mov    %esp,%ebp
  801114:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801117:	8b 55 08             	mov    0x8(%ebp),%edx
  80111a:	8b 45 10             	mov    0x10(%ebp),%eax
  80111d:	01 d0                	add    %edx,%eax
  80111f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801122:	eb 15                	jmp    801139 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801124:	8b 45 08             	mov    0x8(%ebp),%eax
  801127:	8a 00                	mov    (%eax),%al
  801129:	0f b6 d0             	movzbl %al,%edx
  80112c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112f:	0f b6 c0             	movzbl %al,%eax
  801132:	39 c2                	cmp    %eax,%edx
  801134:	74 0d                	je     801143 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801136:	ff 45 08             	incl   0x8(%ebp)
  801139:	8b 45 08             	mov    0x8(%ebp),%eax
  80113c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80113f:	72 e3                	jb     801124 <memfind+0x13>
  801141:	eb 01                	jmp    801144 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801143:	90                   	nop
	return (void *) s;
  801144:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801147:	c9                   	leave  
  801148:	c3                   	ret    

00801149 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801149:	55                   	push   %ebp
  80114a:	89 e5                	mov    %esp,%ebp
  80114c:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80114f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801156:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80115d:	eb 03                	jmp    801162 <strtol+0x19>
		s++;
  80115f:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801162:	8b 45 08             	mov    0x8(%ebp),%eax
  801165:	8a 00                	mov    (%eax),%al
  801167:	3c 20                	cmp    $0x20,%al
  801169:	74 f4                	je     80115f <strtol+0x16>
  80116b:	8b 45 08             	mov    0x8(%ebp),%eax
  80116e:	8a 00                	mov    (%eax),%al
  801170:	3c 09                	cmp    $0x9,%al
  801172:	74 eb                	je     80115f <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801174:	8b 45 08             	mov    0x8(%ebp),%eax
  801177:	8a 00                	mov    (%eax),%al
  801179:	3c 2b                	cmp    $0x2b,%al
  80117b:	75 05                	jne    801182 <strtol+0x39>
		s++;
  80117d:	ff 45 08             	incl   0x8(%ebp)
  801180:	eb 13                	jmp    801195 <strtol+0x4c>
	else if (*s == '-')
  801182:	8b 45 08             	mov    0x8(%ebp),%eax
  801185:	8a 00                	mov    (%eax),%al
  801187:	3c 2d                	cmp    $0x2d,%al
  801189:	75 0a                	jne    801195 <strtol+0x4c>
		s++, neg = 1;
  80118b:	ff 45 08             	incl   0x8(%ebp)
  80118e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801195:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801199:	74 06                	je     8011a1 <strtol+0x58>
  80119b:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80119f:	75 20                	jne    8011c1 <strtol+0x78>
  8011a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a4:	8a 00                	mov    (%eax),%al
  8011a6:	3c 30                	cmp    $0x30,%al
  8011a8:	75 17                	jne    8011c1 <strtol+0x78>
  8011aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ad:	40                   	inc    %eax
  8011ae:	8a 00                	mov    (%eax),%al
  8011b0:	3c 78                	cmp    $0x78,%al
  8011b2:	75 0d                	jne    8011c1 <strtol+0x78>
		s += 2, base = 16;
  8011b4:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8011b8:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8011bf:	eb 28                	jmp    8011e9 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8011c1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011c5:	75 15                	jne    8011dc <strtol+0x93>
  8011c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ca:	8a 00                	mov    (%eax),%al
  8011cc:	3c 30                	cmp    $0x30,%al
  8011ce:	75 0c                	jne    8011dc <strtol+0x93>
		s++, base = 8;
  8011d0:	ff 45 08             	incl   0x8(%ebp)
  8011d3:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8011da:	eb 0d                	jmp    8011e9 <strtol+0xa0>
	else if (base == 0)
  8011dc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011e0:	75 07                	jne    8011e9 <strtol+0xa0>
		base = 10;
  8011e2:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8011e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ec:	8a 00                	mov    (%eax),%al
  8011ee:	3c 2f                	cmp    $0x2f,%al
  8011f0:	7e 19                	jle    80120b <strtol+0xc2>
  8011f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f5:	8a 00                	mov    (%eax),%al
  8011f7:	3c 39                	cmp    $0x39,%al
  8011f9:	7f 10                	jg     80120b <strtol+0xc2>
			dig = *s - '0';
  8011fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fe:	8a 00                	mov    (%eax),%al
  801200:	0f be c0             	movsbl %al,%eax
  801203:	83 e8 30             	sub    $0x30,%eax
  801206:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801209:	eb 42                	jmp    80124d <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80120b:	8b 45 08             	mov    0x8(%ebp),%eax
  80120e:	8a 00                	mov    (%eax),%al
  801210:	3c 60                	cmp    $0x60,%al
  801212:	7e 19                	jle    80122d <strtol+0xe4>
  801214:	8b 45 08             	mov    0x8(%ebp),%eax
  801217:	8a 00                	mov    (%eax),%al
  801219:	3c 7a                	cmp    $0x7a,%al
  80121b:	7f 10                	jg     80122d <strtol+0xe4>
			dig = *s - 'a' + 10;
  80121d:	8b 45 08             	mov    0x8(%ebp),%eax
  801220:	8a 00                	mov    (%eax),%al
  801222:	0f be c0             	movsbl %al,%eax
  801225:	83 e8 57             	sub    $0x57,%eax
  801228:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80122b:	eb 20                	jmp    80124d <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80122d:	8b 45 08             	mov    0x8(%ebp),%eax
  801230:	8a 00                	mov    (%eax),%al
  801232:	3c 40                	cmp    $0x40,%al
  801234:	7e 39                	jle    80126f <strtol+0x126>
  801236:	8b 45 08             	mov    0x8(%ebp),%eax
  801239:	8a 00                	mov    (%eax),%al
  80123b:	3c 5a                	cmp    $0x5a,%al
  80123d:	7f 30                	jg     80126f <strtol+0x126>
			dig = *s - 'A' + 10;
  80123f:	8b 45 08             	mov    0x8(%ebp),%eax
  801242:	8a 00                	mov    (%eax),%al
  801244:	0f be c0             	movsbl %al,%eax
  801247:	83 e8 37             	sub    $0x37,%eax
  80124a:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80124d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801250:	3b 45 10             	cmp    0x10(%ebp),%eax
  801253:	7d 19                	jge    80126e <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801255:	ff 45 08             	incl   0x8(%ebp)
  801258:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80125b:	0f af 45 10          	imul   0x10(%ebp),%eax
  80125f:	89 c2                	mov    %eax,%edx
  801261:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801264:	01 d0                	add    %edx,%eax
  801266:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801269:	e9 7b ff ff ff       	jmp    8011e9 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80126e:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80126f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801273:	74 08                	je     80127d <strtol+0x134>
		*endptr = (char *) s;
  801275:	8b 45 0c             	mov    0xc(%ebp),%eax
  801278:	8b 55 08             	mov    0x8(%ebp),%edx
  80127b:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80127d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801281:	74 07                	je     80128a <strtol+0x141>
  801283:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801286:	f7 d8                	neg    %eax
  801288:	eb 03                	jmp    80128d <strtol+0x144>
  80128a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80128d:	c9                   	leave  
  80128e:	c3                   	ret    

0080128f <ltostr>:

void
ltostr(long value, char *str)
{
  80128f:	55                   	push   %ebp
  801290:	89 e5                	mov    %esp,%ebp
  801292:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801295:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80129c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8012a3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012a7:	79 13                	jns    8012bc <ltostr+0x2d>
	{
		neg = 1;
  8012a9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8012b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b3:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8012b6:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8012b9:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8012bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012bf:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8012c4:	99                   	cltd   
  8012c5:	f7 f9                	idiv   %ecx
  8012c7:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8012ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012cd:	8d 50 01             	lea    0x1(%eax),%edx
  8012d0:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012d3:	89 c2                	mov    %eax,%edx
  8012d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d8:	01 d0                	add    %edx,%eax
  8012da:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012dd:	83 c2 30             	add    $0x30,%edx
  8012e0:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8012e2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012e5:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012ea:	f7 e9                	imul   %ecx
  8012ec:	c1 fa 02             	sar    $0x2,%edx
  8012ef:	89 c8                	mov    %ecx,%eax
  8012f1:	c1 f8 1f             	sar    $0x1f,%eax
  8012f4:	29 c2                	sub    %eax,%edx
  8012f6:	89 d0                	mov    %edx,%eax
  8012f8:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  8012fb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012ff:	75 bb                	jne    8012bc <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801301:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801308:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80130b:	48                   	dec    %eax
  80130c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80130f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801313:	74 3d                	je     801352 <ltostr+0xc3>
		start = 1 ;
  801315:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80131c:	eb 34                	jmp    801352 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  80131e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801321:	8b 45 0c             	mov    0xc(%ebp),%eax
  801324:	01 d0                	add    %edx,%eax
  801326:	8a 00                	mov    (%eax),%al
  801328:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80132b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80132e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801331:	01 c2                	add    %eax,%edx
  801333:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801336:	8b 45 0c             	mov    0xc(%ebp),%eax
  801339:	01 c8                	add    %ecx,%eax
  80133b:	8a 00                	mov    (%eax),%al
  80133d:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80133f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801342:	8b 45 0c             	mov    0xc(%ebp),%eax
  801345:	01 c2                	add    %eax,%edx
  801347:	8a 45 eb             	mov    -0x15(%ebp),%al
  80134a:	88 02                	mov    %al,(%edx)
		start++ ;
  80134c:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80134f:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801352:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801355:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801358:	7c c4                	jl     80131e <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80135a:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80135d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801360:	01 d0                	add    %edx,%eax
  801362:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801365:	90                   	nop
  801366:	c9                   	leave  
  801367:	c3                   	ret    

00801368 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801368:	55                   	push   %ebp
  801369:	89 e5                	mov    %esp,%ebp
  80136b:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80136e:	ff 75 08             	pushl  0x8(%ebp)
  801371:	e8 c4 f9 ff ff       	call   800d3a <strlen>
  801376:	83 c4 04             	add    $0x4,%esp
  801379:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80137c:	ff 75 0c             	pushl  0xc(%ebp)
  80137f:	e8 b6 f9 ff ff       	call   800d3a <strlen>
  801384:	83 c4 04             	add    $0x4,%esp
  801387:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80138a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801391:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801398:	eb 17                	jmp    8013b1 <strcconcat+0x49>
		final[s] = str1[s] ;
  80139a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80139d:	8b 45 10             	mov    0x10(%ebp),%eax
  8013a0:	01 c2                	add    %eax,%edx
  8013a2:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8013a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a8:	01 c8                	add    %ecx,%eax
  8013aa:	8a 00                	mov    (%eax),%al
  8013ac:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8013ae:	ff 45 fc             	incl   -0x4(%ebp)
  8013b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013b4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8013b7:	7c e1                	jl     80139a <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8013b9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8013c0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8013c7:	eb 1f                	jmp    8013e8 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8013c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013cc:	8d 50 01             	lea    0x1(%eax),%edx
  8013cf:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8013d2:	89 c2                	mov    %eax,%edx
  8013d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8013d7:	01 c2                	add    %eax,%edx
  8013d9:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8013dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013df:	01 c8                	add    %ecx,%eax
  8013e1:	8a 00                	mov    (%eax),%al
  8013e3:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8013e5:	ff 45 f8             	incl   -0x8(%ebp)
  8013e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013eb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013ee:	7c d9                	jl     8013c9 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8013f0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8013f6:	01 d0                	add    %edx,%eax
  8013f8:	c6 00 00             	movb   $0x0,(%eax)
}
  8013fb:	90                   	nop
  8013fc:	c9                   	leave  
  8013fd:	c3                   	ret    

008013fe <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8013fe:	55                   	push   %ebp
  8013ff:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801401:	8b 45 14             	mov    0x14(%ebp),%eax
  801404:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80140a:	8b 45 14             	mov    0x14(%ebp),%eax
  80140d:	8b 00                	mov    (%eax),%eax
  80140f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801416:	8b 45 10             	mov    0x10(%ebp),%eax
  801419:	01 d0                	add    %edx,%eax
  80141b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801421:	eb 0c                	jmp    80142f <strsplit+0x31>
			*string++ = 0;
  801423:	8b 45 08             	mov    0x8(%ebp),%eax
  801426:	8d 50 01             	lea    0x1(%eax),%edx
  801429:	89 55 08             	mov    %edx,0x8(%ebp)
  80142c:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80142f:	8b 45 08             	mov    0x8(%ebp),%eax
  801432:	8a 00                	mov    (%eax),%al
  801434:	84 c0                	test   %al,%al
  801436:	74 18                	je     801450 <strsplit+0x52>
  801438:	8b 45 08             	mov    0x8(%ebp),%eax
  80143b:	8a 00                	mov    (%eax),%al
  80143d:	0f be c0             	movsbl %al,%eax
  801440:	50                   	push   %eax
  801441:	ff 75 0c             	pushl  0xc(%ebp)
  801444:	e8 83 fa ff ff       	call   800ecc <strchr>
  801449:	83 c4 08             	add    $0x8,%esp
  80144c:	85 c0                	test   %eax,%eax
  80144e:	75 d3                	jne    801423 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801450:	8b 45 08             	mov    0x8(%ebp),%eax
  801453:	8a 00                	mov    (%eax),%al
  801455:	84 c0                	test   %al,%al
  801457:	74 5a                	je     8014b3 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801459:	8b 45 14             	mov    0x14(%ebp),%eax
  80145c:	8b 00                	mov    (%eax),%eax
  80145e:	83 f8 0f             	cmp    $0xf,%eax
  801461:	75 07                	jne    80146a <strsplit+0x6c>
		{
			return 0;
  801463:	b8 00 00 00 00       	mov    $0x0,%eax
  801468:	eb 66                	jmp    8014d0 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80146a:	8b 45 14             	mov    0x14(%ebp),%eax
  80146d:	8b 00                	mov    (%eax),%eax
  80146f:	8d 48 01             	lea    0x1(%eax),%ecx
  801472:	8b 55 14             	mov    0x14(%ebp),%edx
  801475:	89 0a                	mov    %ecx,(%edx)
  801477:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80147e:	8b 45 10             	mov    0x10(%ebp),%eax
  801481:	01 c2                	add    %eax,%edx
  801483:	8b 45 08             	mov    0x8(%ebp),%eax
  801486:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801488:	eb 03                	jmp    80148d <strsplit+0x8f>
			string++;
  80148a:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80148d:	8b 45 08             	mov    0x8(%ebp),%eax
  801490:	8a 00                	mov    (%eax),%al
  801492:	84 c0                	test   %al,%al
  801494:	74 8b                	je     801421 <strsplit+0x23>
  801496:	8b 45 08             	mov    0x8(%ebp),%eax
  801499:	8a 00                	mov    (%eax),%al
  80149b:	0f be c0             	movsbl %al,%eax
  80149e:	50                   	push   %eax
  80149f:	ff 75 0c             	pushl  0xc(%ebp)
  8014a2:	e8 25 fa ff ff       	call   800ecc <strchr>
  8014a7:	83 c4 08             	add    $0x8,%esp
  8014aa:	85 c0                	test   %eax,%eax
  8014ac:	74 dc                	je     80148a <strsplit+0x8c>
			string++;
	}
  8014ae:	e9 6e ff ff ff       	jmp    801421 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8014b3:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8014b4:	8b 45 14             	mov    0x14(%ebp),%eax
  8014b7:	8b 00                	mov    (%eax),%eax
  8014b9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014c0:	8b 45 10             	mov    0x10(%ebp),%eax
  8014c3:	01 d0                	add    %edx,%eax
  8014c5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8014cb:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8014d0:	c9                   	leave  
  8014d1:	c3                   	ret    

008014d2 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  8014d2:	55                   	push   %ebp
  8014d3:	89 e5                	mov    %esp,%ebp
  8014d5:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  8014d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014db:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  8014de:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014e5:	eb 4a                	jmp    801531 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  8014e7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ed:	01 c2                	add    %eax,%edx
  8014ef:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8014f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014f5:	01 c8                	add    %ecx,%eax
  8014f7:	8a 00                	mov    (%eax),%al
  8014f9:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  8014fb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801501:	01 d0                	add    %edx,%eax
  801503:	8a 00                	mov    (%eax),%al
  801505:	3c 40                	cmp    $0x40,%al
  801507:	7e 25                	jle    80152e <str2lower+0x5c>
  801509:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80150c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80150f:	01 d0                	add    %edx,%eax
  801511:	8a 00                	mov    (%eax),%al
  801513:	3c 5a                	cmp    $0x5a,%al
  801515:	7f 17                	jg     80152e <str2lower+0x5c>
		{
			dst[i] += 32 ;
  801517:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80151a:	8b 45 08             	mov    0x8(%ebp),%eax
  80151d:	01 d0                	add    %edx,%eax
  80151f:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801522:	8b 55 08             	mov    0x8(%ebp),%edx
  801525:	01 ca                	add    %ecx,%edx
  801527:	8a 12                	mov    (%edx),%dl
  801529:	83 c2 20             	add    $0x20,%edx
  80152c:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  80152e:	ff 45 fc             	incl   -0x4(%ebp)
  801531:	ff 75 0c             	pushl  0xc(%ebp)
  801534:	e8 01 f8 ff ff       	call   800d3a <strlen>
  801539:	83 c4 04             	add    $0x4,%esp
  80153c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80153f:	7f a6                	jg     8014e7 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801541:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801544:	c9                   	leave  
  801545:	c3                   	ret    

00801546 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801546:	55                   	push   %ebp
  801547:	89 e5                	mov    %esp,%ebp
  801549:	57                   	push   %edi
  80154a:	56                   	push   %esi
  80154b:	53                   	push   %ebx
  80154c:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80154f:	8b 45 08             	mov    0x8(%ebp),%eax
  801552:	8b 55 0c             	mov    0xc(%ebp),%edx
  801555:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801558:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80155b:	8b 7d 18             	mov    0x18(%ebp),%edi
  80155e:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801561:	cd 30                	int    $0x30
  801563:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801566:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801569:	83 c4 10             	add    $0x10,%esp
  80156c:	5b                   	pop    %ebx
  80156d:	5e                   	pop    %esi
  80156e:	5f                   	pop    %edi
  80156f:	5d                   	pop    %ebp
  801570:	c3                   	ret    

00801571 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801571:	55                   	push   %ebp
  801572:	89 e5                	mov    %esp,%ebp
  801574:	83 ec 04             	sub    $0x4,%esp
  801577:	8b 45 10             	mov    0x10(%ebp),%eax
  80157a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  80157d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801580:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801584:	8b 45 08             	mov    0x8(%ebp),%eax
  801587:	6a 00                	push   $0x0
  801589:	51                   	push   %ecx
  80158a:	52                   	push   %edx
  80158b:	ff 75 0c             	pushl  0xc(%ebp)
  80158e:	50                   	push   %eax
  80158f:	6a 00                	push   $0x0
  801591:	e8 b0 ff ff ff       	call   801546 <syscall>
  801596:	83 c4 18             	add    $0x18,%esp
}
  801599:	90                   	nop
  80159a:	c9                   	leave  
  80159b:	c3                   	ret    

0080159c <sys_cgetc>:

int
sys_cgetc(void)
{
  80159c:	55                   	push   %ebp
  80159d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80159f:	6a 00                	push   $0x0
  8015a1:	6a 00                	push   $0x0
  8015a3:	6a 00                	push   $0x0
  8015a5:	6a 00                	push   $0x0
  8015a7:	6a 00                	push   $0x0
  8015a9:	6a 02                	push   $0x2
  8015ab:	e8 96 ff ff ff       	call   801546 <syscall>
  8015b0:	83 c4 18             	add    $0x18,%esp
}
  8015b3:	c9                   	leave  
  8015b4:	c3                   	ret    

008015b5 <sys_lock_cons>:

void sys_lock_cons(void)
{
  8015b5:	55                   	push   %ebp
  8015b6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  8015b8:	6a 00                	push   $0x0
  8015ba:	6a 00                	push   $0x0
  8015bc:	6a 00                	push   $0x0
  8015be:	6a 00                	push   $0x0
  8015c0:	6a 00                	push   $0x0
  8015c2:	6a 03                	push   $0x3
  8015c4:	e8 7d ff ff ff       	call   801546 <syscall>
  8015c9:	83 c4 18             	add    $0x18,%esp
}
  8015cc:	90                   	nop
  8015cd:	c9                   	leave  
  8015ce:	c3                   	ret    

008015cf <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  8015cf:	55                   	push   %ebp
  8015d0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  8015d2:	6a 00                	push   $0x0
  8015d4:	6a 00                	push   $0x0
  8015d6:	6a 00                	push   $0x0
  8015d8:	6a 00                	push   $0x0
  8015da:	6a 00                	push   $0x0
  8015dc:	6a 04                	push   $0x4
  8015de:	e8 63 ff ff ff       	call   801546 <syscall>
  8015e3:	83 c4 18             	add    $0x18,%esp
}
  8015e6:	90                   	nop
  8015e7:	c9                   	leave  
  8015e8:	c3                   	ret    

008015e9 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  8015e9:	55                   	push   %ebp
  8015ea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8015ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f2:	6a 00                	push   $0x0
  8015f4:	6a 00                	push   $0x0
  8015f6:	6a 00                	push   $0x0
  8015f8:	52                   	push   %edx
  8015f9:	50                   	push   %eax
  8015fa:	6a 08                	push   $0x8
  8015fc:	e8 45 ff ff ff       	call   801546 <syscall>
  801601:	83 c4 18             	add    $0x18,%esp
}
  801604:	c9                   	leave  
  801605:	c3                   	ret    

00801606 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801606:	55                   	push   %ebp
  801607:	89 e5                	mov    %esp,%ebp
  801609:	56                   	push   %esi
  80160a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80160b:	8b 75 18             	mov    0x18(%ebp),%esi
  80160e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801611:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801614:	8b 55 0c             	mov    0xc(%ebp),%edx
  801617:	8b 45 08             	mov    0x8(%ebp),%eax
  80161a:	56                   	push   %esi
  80161b:	53                   	push   %ebx
  80161c:	51                   	push   %ecx
  80161d:	52                   	push   %edx
  80161e:	50                   	push   %eax
  80161f:	6a 09                	push   $0x9
  801621:	e8 20 ff ff ff       	call   801546 <syscall>
  801626:	83 c4 18             	add    $0x18,%esp
}
  801629:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80162c:	5b                   	pop    %ebx
  80162d:	5e                   	pop    %esi
  80162e:	5d                   	pop    %ebp
  80162f:	c3                   	ret    

00801630 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  801630:	55                   	push   %ebp
  801631:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  801633:	6a 00                	push   $0x0
  801635:	6a 00                	push   $0x0
  801637:	6a 00                	push   $0x0
  801639:	6a 00                	push   $0x0
  80163b:	ff 75 08             	pushl  0x8(%ebp)
  80163e:	6a 0a                	push   $0xa
  801640:	e8 01 ff ff ff       	call   801546 <syscall>
  801645:	83 c4 18             	add    $0x18,%esp
}
  801648:	c9                   	leave  
  801649:	c3                   	ret    

0080164a <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80164a:	55                   	push   %ebp
  80164b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80164d:	6a 00                	push   $0x0
  80164f:	6a 00                	push   $0x0
  801651:	6a 00                	push   $0x0
  801653:	ff 75 0c             	pushl  0xc(%ebp)
  801656:	ff 75 08             	pushl  0x8(%ebp)
  801659:	6a 0b                	push   $0xb
  80165b:	e8 e6 fe ff ff       	call   801546 <syscall>
  801660:	83 c4 18             	add    $0x18,%esp
}
  801663:	c9                   	leave  
  801664:	c3                   	ret    

00801665 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801665:	55                   	push   %ebp
  801666:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801668:	6a 00                	push   $0x0
  80166a:	6a 00                	push   $0x0
  80166c:	6a 00                	push   $0x0
  80166e:	6a 00                	push   $0x0
  801670:	6a 00                	push   $0x0
  801672:	6a 0c                	push   $0xc
  801674:	e8 cd fe ff ff       	call   801546 <syscall>
  801679:	83 c4 18             	add    $0x18,%esp
}
  80167c:	c9                   	leave  
  80167d:	c3                   	ret    

0080167e <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80167e:	55                   	push   %ebp
  80167f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801681:	6a 00                	push   $0x0
  801683:	6a 00                	push   $0x0
  801685:	6a 00                	push   $0x0
  801687:	6a 00                	push   $0x0
  801689:	6a 00                	push   $0x0
  80168b:	6a 0d                	push   $0xd
  80168d:	e8 b4 fe ff ff       	call   801546 <syscall>
  801692:	83 c4 18             	add    $0x18,%esp
}
  801695:	c9                   	leave  
  801696:	c3                   	ret    

00801697 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801697:	55                   	push   %ebp
  801698:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80169a:	6a 00                	push   $0x0
  80169c:	6a 00                	push   $0x0
  80169e:	6a 00                	push   $0x0
  8016a0:	6a 00                	push   $0x0
  8016a2:	6a 00                	push   $0x0
  8016a4:	6a 0e                	push   $0xe
  8016a6:	e8 9b fe ff ff       	call   801546 <syscall>
  8016ab:	83 c4 18             	add    $0x18,%esp
}
  8016ae:	c9                   	leave  
  8016af:	c3                   	ret    

008016b0 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8016b0:	55                   	push   %ebp
  8016b1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8016b3:	6a 00                	push   $0x0
  8016b5:	6a 00                	push   $0x0
  8016b7:	6a 00                	push   $0x0
  8016b9:	6a 00                	push   $0x0
  8016bb:	6a 00                	push   $0x0
  8016bd:	6a 0f                	push   $0xf
  8016bf:	e8 82 fe ff ff       	call   801546 <syscall>
  8016c4:	83 c4 18             	add    $0x18,%esp
}
  8016c7:	c9                   	leave  
  8016c8:	c3                   	ret    

008016c9 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8016c9:	55                   	push   %ebp
  8016ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8016cc:	6a 00                	push   $0x0
  8016ce:	6a 00                	push   $0x0
  8016d0:	6a 00                	push   $0x0
  8016d2:	6a 00                	push   $0x0
  8016d4:	ff 75 08             	pushl  0x8(%ebp)
  8016d7:	6a 10                	push   $0x10
  8016d9:	e8 68 fe ff ff       	call   801546 <syscall>
  8016de:	83 c4 18             	add    $0x18,%esp
}
  8016e1:	c9                   	leave  
  8016e2:	c3                   	ret    

008016e3 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8016e3:	55                   	push   %ebp
  8016e4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8016e6:	6a 00                	push   $0x0
  8016e8:	6a 00                	push   $0x0
  8016ea:	6a 00                	push   $0x0
  8016ec:	6a 00                	push   $0x0
  8016ee:	6a 00                	push   $0x0
  8016f0:	6a 11                	push   $0x11
  8016f2:	e8 4f fe ff ff       	call   801546 <syscall>
  8016f7:	83 c4 18             	add    $0x18,%esp
}
  8016fa:	90                   	nop
  8016fb:	c9                   	leave  
  8016fc:	c3                   	ret    

008016fd <sys_cputc>:

void
sys_cputc(const char c)
{
  8016fd:	55                   	push   %ebp
  8016fe:	89 e5                	mov    %esp,%ebp
  801700:	83 ec 04             	sub    $0x4,%esp
  801703:	8b 45 08             	mov    0x8(%ebp),%eax
  801706:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801709:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80170d:	6a 00                	push   $0x0
  80170f:	6a 00                	push   $0x0
  801711:	6a 00                	push   $0x0
  801713:	6a 00                	push   $0x0
  801715:	50                   	push   %eax
  801716:	6a 01                	push   $0x1
  801718:	e8 29 fe ff ff       	call   801546 <syscall>
  80171d:	83 c4 18             	add    $0x18,%esp
}
  801720:	90                   	nop
  801721:	c9                   	leave  
  801722:	c3                   	ret    

00801723 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801723:	55                   	push   %ebp
  801724:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801726:	6a 00                	push   $0x0
  801728:	6a 00                	push   $0x0
  80172a:	6a 00                	push   $0x0
  80172c:	6a 00                	push   $0x0
  80172e:	6a 00                	push   $0x0
  801730:	6a 14                	push   $0x14
  801732:	e8 0f fe ff ff       	call   801546 <syscall>
  801737:	83 c4 18             	add    $0x18,%esp
}
  80173a:	90                   	nop
  80173b:	c9                   	leave  
  80173c:	c3                   	ret    

0080173d <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  80173d:	55                   	push   %ebp
  80173e:	89 e5                	mov    %esp,%ebp
  801740:	83 ec 04             	sub    $0x4,%esp
  801743:	8b 45 10             	mov    0x10(%ebp),%eax
  801746:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  801749:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80174c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801750:	8b 45 08             	mov    0x8(%ebp),%eax
  801753:	6a 00                	push   $0x0
  801755:	51                   	push   %ecx
  801756:	52                   	push   %edx
  801757:	ff 75 0c             	pushl  0xc(%ebp)
  80175a:	50                   	push   %eax
  80175b:	6a 15                	push   $0x15
  80175d:	e8 e4 fd ff ff       	call   801546 <syscall>
  801762:	83 c4 18             	add    $0x18,%esp
}
  801765:	c9                   	leave  
  801766:	c3                   	ret    

00801767 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801767:	55                   	push   %ebp
  801768:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  80176a:	8b 55 10             	mov    0x10(%ebp),%edx
  80176d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801770:	6a 00                	push   $0x0
  801772:	6a 00                	push   $0x0
  801774:	52                   	push   %edx
  801775:	50                   	push   %eax
  801776:	ff 75 08             	pushl  0x8(%ebp)
  801779:	6a 16                	push   $0x16
  80177b:	e8 c6 fd ff ff       	call   801546 <syscall>
  801780:	83 c4 18             	add    $0x18,%esp
}
  801783:	c9                   	leave  
  801784:	c3                   	ret    

00801785 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  801785:	55                   	push   %ebp
  801786:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801788:	8b 55 0c             	mov    0xc(%ebp),%edx
  80178b:	8b 45 08             	mov    0x8(%ebp),%eax
  80178e:	6a 00                	push   $0x0
  801790:	6a 00                	push   $0x0
  801792:	6a 00                	push   $0x0
  801794:	52                   	push   %edx
  801795:	50                   	push   %eax
  801796:	6a 17                	push   $0x17
  801798:	e8 a9 fd ff ff       	call   801546 <syscall>
  80179d:	83 c4 18             	add    $0x18,%esp
}
  8017a0:	c9                   	leave  
  8017a1:	c3                   	ret    

008017a2 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  8017a2:	55                   	push   %ebp
  8017a3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8017a5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ab:	6a 00                	push   $0x0
  8017ad:	6a 00                	push   $0x0
  8017af:	6a 00                	push   $0x0
  8017b1:	52                   	push   %edx
  8017b2:	50                   	push   %eax
  8017b3:	6a 18                	push   $0x18
  8017b5:	e8 8c fd ff ff       	call   801546 <syscall>
  8017ba:	83 c4 18             	add    $0x18,%esp
}
  8017bd:	c9                   	leave  
  8017be:	c3                   	ret    

008017bf <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8017bf:	55                   	push   %ebp
  8017c0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8017c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c5:	6a 00                	push   $0x0
  8017c7:	ff 75 14             	pushl  0x14(%ebp)
  8017ca:	ff 75 10             	pushl  0x10(%ebp)
  8017cd:	ff 75 0c             	pushl  0xc(%ebp)
  8017d0:	50                   	push   %eax
  8017d1:	6a 19                	push   $0x19
  8017d3:	e8 6e fd ff ff       	call   801546 <syscall>
  8017d8:	83 c4 18             	add    $0x18,%esp
}
  8017db:	c9                   	leave  
  8017dc:	c3                   	ret    

008017dd <sys_run_env>:

void sys_run_env(int32 envId)
{
  8017dd:	55                   	push   %ebp
  8017de:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8017e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e3:	6a 00                	push   $0x0
  8017e5:	6a 00                	push   $0x0
  8017e7:	6a 00                	push   $0x0
  8017e9:	6a 00                	push   $0x0
  8017eb:	50                   	push   %eax
  8017ec:	6a 1a                	push   $0x1a
  8017ee:	e8 53 fd ff ff       	call   801546 <syscall>
  8017f3:	83 c4 18             	add    $0x18,%esp
}
  8017f6:	90                   	nop
  8017f7:	c9                   	leave  
  8017f8:	c3                   	ret    

008017f9 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  8017f9:	55                   	push   %ebp
  8017fa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  8017fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ff:	6a 00                	push   $0x0
  801801:	6a 00                	push   $0x0
  801803:	6a 00                	push   $0x0
  801805:	6a 00                	push   $0x0
  801807:	50                   	push   %eax
  801808:	6a 1b                	push   $0x1b
  80180a:	e8 37 fd ff ff       	call   801546 <syscall>
  80180f:	83 c4 18             	add    $0x18,%esp
}
  801812:	c9                   	leave  
  801813:	c3                   	ret    

00801814 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801814:	55                   	push   %ebp
  801815:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801817:	6a 00                	push   $0x0
  801819:	6a 00                	push   $0x0
  80181b:	6a 00                	push   $0x0
  80181d:	6a 00                	push   $0x0
  80181f:	6a 00                	push   $0x0
  801821:	6a 05                	push   $0x5
  801823:	e8 1e fd ff ff       	call   801546 <syscall>
  801828:	83 c4 18             	add    $0x18,%esp
}
  80182b:	c9                   	leave  
  80182c:	c3                   	ret    

0080182d <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80182d:	55                   	push   %ebp
  80182e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801830:	6a 00                	push   $0x0
  801832:	6a 00                	push   $0x0
  801834:	6a 00                	push   $0x0
  801836:	6a 00                	push   $0x0
  801838:	6a 00                	push   $0x0
  80183a:	6a 06                	push   $0x6
  80183c:	e8 05 fd ff ff       	call   801546 <syscall>
  801841:	83 c4 18             	add    $0x18,%esp
}
  801844:	c9                   	leave  
  801845:	c3                   	ret    

00801846 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801846:	55                   	push   %ebp
  801847:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801849:	6a 00                	push   $0x0
  80184b:	6a 00                	push   $0x0
  80184d:	6a 00                	push   $0x0
  80184f:	6a 00                	push   $0x0
  801851:	6a 00                	push   $0x0
  801853:	6a 07                	push   $0x7
  801855:	e8 ec fc ff ff       	call   801546 <syscall>
  80185a:	83 c4 18             	add    $0x18,%esp
}
  80185d:	c9                   	leave  
  80185e:	c3                   	ret    

0080185f <sys_exit_env>:


void sys_exit_env(void)
{
  80185f:	55                   	push   %ebp
  801860:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  801862:	6a 00                	push   $0x0
  801864:	6a 00                	push   $0x0
  801866:	6a 00                	push   $0x0
  801868:	6a 00                	push   $0x0
  80186a:	6a 00                	push   $0x0
  80186c:	6a 1c                	push   $0x1c
  80186e:	e8 d3 fc ff ff       	call   801546 <syscall>
  801873:	83 c4 18             	add    $0x18,%esp
}
  801876:	90                   	nop
  801877:	c9                   	leave  
  801878:	c3                   	ret    

00801879 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801879:	55                   	push   %ebp
  80187a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80187c:	6a 00                	push   $0x0
  80187e:	6a 00                	push   $0x0
  801880:	ff 75 10             	pushl  0x10(%ebp)
  801883:	ff 75 0c             	pushl  0xc(%ebp)
  801886:	ff 75 08             	pushl  0x8(%ebp)
  801889:	6a 13                	push   $0x13
  80188b:	e8 b6 fc ff ff       	call   801546 <syscall>
  801890:	83 c4 18             	add    $0x18,%esp
	return ;
  801893:	90                   	nop
}
  801894:	c9                   	leave  
  801895:	c3                   	ret    

00801896 <sys_rcr2>:
uint32 sys_rcr2()
{
  801896:	55                   	push   %ebp
  801897:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801899:	6a 00                	push   $0x0
  80189b:	6a 00                	push   $0x0
  80189d:	6a 00                	push   $0x0
  80189f:	6a 00                	push   $0x0
  8018a1:	6a 00                	push   $0x0
  8018a3:	6a 1e                	push   $0x1e
  8018a5:	e8 9c fc ff ff       	call   801546 <syscall>
  8018aa:	83 c4 18             	add    $0x18,%esp
}
  8018ad:	c9                   	leave  
  8018ae:	c3                   	ret    

008018af <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  8018af:	55                   	push   %ebp
  8018b0:	89 e5                	mov    %esp,%ebp
  8018b2:	83 ec 04             	sub    $0x4,%esp
  8018b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8018bb:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8018bf:	6a 00                	push   $0x0
  8018c1:	6a 00                	push   $0x0
  8018c3:	6a 00                	push   $0x0
  8018c5:	6a 00                	push   $0x0
  8018c7:	50                   	push   %eax
  8018c8:	6a 1f                	push   $0x1f
  8018ca:	e8 77 fc ff ff       	call   801546 <syscall>
  8018cf:	83 c4 18             	add    $0x18,%esp
	return ;
  8018d2:	90                   	nop
}
  8018d3:	c9                   	leave  
  8018d4:	c3                   	ret    

008018d5 <rsttst>:
void rsttst()
{
  8018d5:	55                   	push   %ebp
  8018d6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8018d8:	6a 00                	push   $0x0
  8018da:	6a 00                	push   $0x0
  8018dc:	6a 00                	push   $0x0
  8018de:	6a 00                	push   $0x0
  8018e0:	6a 00                	push   $0x0
  8018e2:	6a 21                	push   $0x21
  8018e4:	e8 5d fc ff ff       	call   801546 <syscall>
  8018e9:	83 c4 18             	add    $0x18,%esp
	return ;
  8018ec:	90                   	nop
}
  8018ed:	c9                   	leave  
  8018ee:	c3                   	ret    

008018ef <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8018ef:	55                   	push   %ebp
  8018f0:	89 e5                	mov    %esp,%ebp
  8018f2:	83 ec 04             	sub    $0x4,%esp
  8018f5:	8b 45 14             	mov    0x14(%ebp),%eax
  8018f8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8018fb:	8b 55 18             	mov    0x18(%ebp),%edx
  8018fe:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801902:	52                   	push   %edx
  801903:	50                   	push   %eax
  801904:	ff 75 10             	pushl  0x10(%ebp)
  801907:	ff 75 0c             	pushl  0xc(%ebp)
  80190a:	ff 75 08             	pushl  0x8(%ebp)
  80190d:	6a 20                	push   $0x20
  80190f:	e8 32 fc ff ff       	call   801546 <syscall>
  801914:	83 c4 18             	add    $0x18,%esp
	return ;
  801917:	90                   	nop
}
  801918:	c9                   	leave  
  801919:	c3                   	ret    

0080191a <chktst>:
void chktst(uint32 n)
{
  80191a:	55                   	push   %ebp
  80191b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80191d:	6a 00                	push   $0x0
  80191f:	6a 00                	push   $0x0
  801921:	6a 00                	push   $0x0
  801923:	6a 00                	push   $0x0
  801925:	ff 75 08             	pushl  0x8(%ebp)
  801928:	6a 22                	push   $0x22
  80192a:	e8 17 fc ff ff       	call   801546 <syscall>
  80192f:	83 c4 18             	add    $0x18,%esp
	return ;
  801932:	90                   	nop
}
  801933:	c9                   	leave  
  801934:	c3                   	ret    

00801935 <inctst>:

void inctst()
{
  801935:	55                   	push   %ebp
  801936:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801938:	6a 00                	push   $0x0
  80193a:	6a 00                	push   $0x0
  80193c:	6a 00                	push   $0x0
  80193e:	6a 00                	push   $0x0
  801940:	6a 00                	push   $0x0
  801942:	6a 23                	push   $0x23
  801944:	e8 fd fb ff ff       	call   801546 <syscall>
  801949:	83 c4 18             	add    $0x18,%esp
	return ;
  80194c:	90                   	nop
}
  80194d:	c9                   	leave  
  80194e:	c3                   	ret    

0080194f <gettst>:
uint32 gettst()
{
  80194f:	55                   	push   %ebp
  801950:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801952:	6a 00                	push   $0x0
  801954:	6a 00                	push   $0x0
  801956:	6a 00                	push   $0x0
  801958:	6a 00                	push   $0x0
  80195a:	6a 00                	push   $0x0
  80195c:	6a 24                	push   $0x24
  80195e:	e8 e3 fb ff ff       	call   801546 <syscall>
  801963:	83 c4 18             	add    $0x18,%esp
}
  801966:	c9                   	leave  
  801967:	c3                   	ret    

00801968 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801968:	55                   	push   %ebp
  801969:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80196b:	6a 00                	push   $0x0
  80196d:	6a 00                	push   $0x0
  80196f:	6a 00                	push   $0x0
  801971:	6a 00                	push   $0x0
  801973:	6a 00                	push   $0x0
  801975:	6a 25                	push   $0x25
  801977:	e8 ca fb ff ff       	call   801546 <syscall>
  80197c:	83 c4 18             	add    $0x18,%esp
  80197f:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  801984:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801989:	c9                   	leave  
  80198a:	c3                   	ret    

0080198b <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80198b:	55                   	push   %ebp
  80198c:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  80198e:	8b 45 08             	mov    0x8(%ebp),%eax
  801991:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801996:	6a 00                	push   $0x0
  801998:	6a 00                	push   $0x0
  80199a:	6a 00                	push   $0x0
  80199c:	6a 00                	push   $0x0
  80199e:	ff 75 08             	pushl  0x8(%ebp)
  8019a1:	6a 26                	push   $0x26
  8019a3:	e8 9e fb ff ff       	call   801546 <syscall>
  8019a8:	83 c4 18             	add    $0x18,%esp
	return ;
  8019ab:	90                   	nop
}
  8019ac:	c9                   	leave  
  8019ad:	c3                   	ret    

008019ae <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8019ae:	55                   	push   %ebp
  8019af:	89 e5                	mov    %esp,%ebp
  8019b1:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8019b2:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8019b5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8019b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8019be:	6a 00                	push   $0x0
  8019c0:	53                   	push   %ebx
  8019c1:	51                   	push   %ecx
  8019c2:	52                   	push   %edx
  8019c3:	50                   	push   %eax
  8019c4:	6a 27                	push   $0x27
  8019c6:	e8 7b fb ff ff       	call   801546 <syscall>
  8019cb:	83 c4 18             	add    $0x18,%esp
}
  8019ce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8019d1:	c9                   	leave  
  8019d2:	c3                   	ret    

008019d3 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8019d3:	55                   	push   %ebp
  8019d4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8019d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8019dc:	6a 00                	push   $0x0
  8019de:	6a 00                	push   $0x0
  8019e0:	6a 00                	push   $0x0
  8019e2:	52                   	push   %edx
  8019e3:	50                   	push   %eax
  8019e4:	6a 28                	push   $0x28
  8019e6:	e8 5b fb ff ff       	call   801546 <syscall>
  8019eb:	83 c4 18             	add    $0x18,%esp
}
  8019ee:	c9                   	leave  
  8019ef:	c3                   	ret    

008019f0 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  8019f0:	55                   	push   %ebp
  8019f1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  8019f3:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8019f6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fc:	6a 00                	push   $0x0
  8019fe:	51                   	push   %ecx
  8019ff:	ff 75 10             	pushl  0x10(%ebp)
  801a02:	52                   	push   %edx
  801a03:	50                   	push   %eax
  801a04:	6a 29                	push   $0x29
  801a06:	e8 3b fb ff ff       	call   801546 <syscall>
  801a0b:	83 c4 18             	add    $0x18,%esp
}
  801a0e:	c9                   	leave  
  801a0f:	c3                   	ret    

00801a10 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801a10:	55                   	push   %ebp
  801a11:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801a13:	6a 00                	push   $0x0
  801a15:	6a 00                	push   $0x0
  801a17:	ff 75 10             	pushl  0x10(%ebp)
  801a1a:	ff 75 0c             	pushl  0xc(%ebp)
  801a1d:	ff 75 08             	pushl  0x8(%ebp)
  801a20:	6a 12                	push   $0x12
  801a22:	e8 1f fb ff ff       	call   801546 <syscall>
  801a27:	83 c4 18             	add    $0x18,%esp
	return ;
  801a2a:	90                   	nop
}
  801a2b:	c9                   	leave  
  801a2c:	c3                   	ret    

00801a2d <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801a2d:	55                   	push   %ebp
  801a2e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801a30:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a33:	8b 45 08             	mov    0x8(%ebp),%eax
  801a36:	6a 00                	push   $0x0
  801a38:	6a 00                	push   $0x0
  801a3a:	6a 00                	push   $0x0
  801a3c:	52                   	push   %edx
  801a3d:	50                   	push   %eax
  801a3e:	6a 2a                	push   $0x2a
  801a40:	e8 01 fb ff ff       	call   801546 <syscall>
  801a45:	83 c4 18             	add    $0x18,%esp
	return;
  801a48:	90                   	nop
}
  801a49:	c9                   	leave  
  801a4a:	c3                   	ret    

00801a4b <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801a4b:	55                   	push   %ebp
  801a4c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801a4e:	6a 00                	push   $0x0
  801a50:	6a 00                	push   $0x0
  801a52:	6a 00                	push   $0x0
  801a54:	6a 00                	push   $0x0
  801a56:	6a 00                	push   $0x0
  801a58:	6a 2b                	push   $0x2b
  801a5a:	e8 e7 fa ff ff       	call   801546 <syscall>
  801a5f:	83 c4 18             	add    $0x18,%esp
}
  801a62:	c9                   	leave  
  801a63:	c3                   	ret    

00801a64 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801a64:	55                   	push   %ebp
  801a65:	89 e5                	mov    %esp,%ebp
  801a67:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801a6a:	83 ec 04             	sub    $0x4,%esp
  801a6d:	68 88 25 80 00       	push   $0x802588
  801a72:	68 0a 01 00 00       	push   $0x10a
  801a77:	68 98 25 80 00       	push   $0x802598
  801a7c:	e8 12 e9 ff ff       	call   800393 <_panic>

00801a81 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801a81:	55                   	push   %ebp
  801a82:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801a84:	6a 00                	push   $0x0
  801a86:	6a 00                	push   $0x0
  801a88:	6a 00                	push   $0x0
  801a8a:	ff 75 0c             	pushl  0xc(%ebp)
  801a8d:	ff 75 08             	pushl  0x8(%ebp)
  801a90:	6a 33                	push   $0x33
  801a92:	e8 af fa ff ff       	call   801546 <syscall>
  801a97:	83 c4 18             	add    $0x18,%esp
	return;
  801a9a:	90                   	nop
}
  801a9b:	c9                   	leave  
  801a9c:	c3                   	ret    

00801a9d <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801a9d:	55                   	push   %ebp
  801a9e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801aa0:	6a 00                	push   $0x0
  801aa2:	6a 00                	push   $0x0
  801aa4:	6a 00                	push   $0x0
  801aa6:	ff 75 0c             	pushl  0xc(%ebp)
  801aa9:	ff 75 08             	pushl  0x8(%ebp)
  801aac:	6a 34                	push   $0x34
  801aae:	e8 93 fa ff ff       	call   801546 <syscall>
  801ab3:	83 c4 18             	add    $0x18,%esp
	return ;
  801ab6:	90                   	nop
}
  801ab7:	c9                   	leave  
  801ab8:	c3                   	ret    
  801ab9:	66 90                	xchg   %ax,%ax
  801abb:	90                   	nop

00801abc <__udivdi3>:
  801abc:	55                   	push   %ebp
  801abd:	57                   	push   %edi
  801abe:	56                   	push   %esi
  801abf:	53                   	push   %ebx
  801ac0:	83 ec 1c             	sub    $0x1c,%esp
  801ac3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801ac7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801acb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801acf:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801ad3:	89 ca                	mov    %ecx,%edx
  801ad5:	89 f8                	mov    %edi,%eax
  801ad7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801adb:	85 f6                	test   %esi,%esi
  801add:	75 2d                	jne    801b0c <__udivdi3+0x50>
  801adf:	39 cf                	cmp    %ecx,%edi
  801ae1:	77 65                	ja     801b48 <__udivdi3+0x8c>
  801ae3:	89 fd                	mov    %edi,%ebp
  801ae5:	85 ff                	test   %edi,%edi
  801ae7:	75 0b                	jne    801af4 <__udivdi3+0x38>
  801ae9:	b8 01 00 00 00       	mov    $0x1,%eax
  801aee:	31 d2                	xor    %edx,%edx
  801af0:	f7 f7                	div    %edi
  801af2:	89 c5                	mov    %eax,%ebp
  801af4:	31 d2                	xor    %edx,%edx
  801af6:	89 c8                	mov    %ecx,%eax
  801af8:	f7 f5                	div    %ebp
  801afa:	89 c1                	mov    %eax,%ecx
  801afc:	89 d8                	mov    %ebx,%eax
  801afe:	f7 f5                	div    %ebp
  801b00:	89 cf                	mov    %ecx,%edi
  801b02:	89 fa                	mov    %edi,%edx
  801b04:	83 c4 1c             	add    $0x1c,%esp
  801b07:	5b                   	pop    %ebx
  801b08:	5e                   	pop    %esi
  801b09:	5f                   	pop    %edi
  801b0a:	5d                   	pop    %ebp
  801b0b:	c3                   	ret    
  801b0c:	39 ce                	cmp    %ecx,%esi
  801b0e:	77 28                	ja     801b38 <__udivdi3+0x7c>
  801b10:	0f bd fe             	bsr    %esi,%edi
  801b13:	83 f7 1f             	xor    $0x1f,%edi
  801b16:	75 40                	jne    801b58 <__udivdi3+0x9c>
  801b18:	39 ce                	cmp    %ecx,%esi
  801b1a:	72 0a                	jb     801b26 <__udivdi3+0x6a>
  801b1c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801b20:	0f 87 9e 00 00 00    	ja     801bc4 <__udivdi3+0x108>
  801b26:	b8 01 00 00 00       	mov    $0x1,%eax
  801b2b:	89 fa                	mov    %edi,%edx
  801b2d:	83 c4 1c             	add    $0x1c,%esp
  801b30:	5b                   	pop    %ebx
  801b31:	5e                   	pop    %esi
  801b32:	5f                   	pop    %edi
  801b33:	5d                   	pop    %ebp
  801b34:	c3                   	ret    
  801b35:	8d 76 00             	lea    0x0(%esi),%esi
  801b38:	31 ff                	xor    %edi,%edi
  801b3a:	31 c0                	xor    %eax,%eax
  801b3c:	89 fa                	mov    %edi,%edx
  801b3e:	83 c4 1c             	add    $0x1c,%esp
  801b41:	5b                   	pop    %ebx
  801b42:	5e                   	pop    %esi
  801b43:	5f                   	pop    %edi
  801b44:	5d                   	pop    %ebp
  801b45:	c3                   	ret    
  801b46:	66 90                	xchg   %ax,%ax
  801b48:	89 d8                	mov    %ebx,%eax
  801b4a:	f7 f7                	div    %edi
  801b4c:	31 ff                	xor    %edi,%edi
  801b4e:	89 fa                	mov    %edi,%edx
  801b50:	83 c4 1c             	add    $0x1c,%esp
  801b53:	5b                   	pop    %ebx
  801b54:	5e                   	pop    %esi
  801b55:	5f                   	pop    %edi
  801b56:	5d                   	pop    %ebp
  801b57:	c3                   	ret    
  801b58:	bd 20 00 00 00       	mov    $0x20,%ebp
  801b5d:	89 eb                	mov    %ebp,%ebx
  801b5f:	29 fb                	sub    %edi,%ebx
  801b61:	89 f9                	mov    %edi,%ecx
  801b63:	d3 e6                	shl    %cl,%esi
  801b65:	89 c5                	mov    %eax,%ebp
  801b67:	88 d9                	mov    %bl,%cl
  801b69:	d3 ed                	shr    %cl,%ebp
  801b6b:	89 e9                	mov    %ebp,%ecx
  801b6d:	09 f1                	or     %esi,%ecx
  801b6f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801b73:	89 f9                	mov    %edi,%ecx
  801b75:	d3 e0                	shl    %cl,%eax
  801b77:	89 c5                	mov    %eax,%ebp
  801b79:	89 d6                	mov    %edx,%esi
  801b7b:	88 d9                	mov    %bl,%cl
  801b7d:	d3 ee                	shr    %cl,%esi
  801b7f:	89 f9                	mov    %edi,%ecx
  801b81:	d3 e2                	shl    %cl,%edx
  801b83:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b87:	88 d9                	mov    %bl,%cl
  801b89:	d3 e8                	shr    %cl,%eax
  801b8b:	09 c2                	or     %eax,%edx
  801b8d:	89 d0                	mov    %edx,%eax
  801b8f:	89 f2                	mov    %esi,%edx
  801b91:	f7 74 24 0c          	divl   0xc(%esp)
  801b95:	89 d6                	mov    %edx,%esi
  801b97:	89 c3                	mov    %eax,%ebx
  801b99:	f7 e5                	mul    %ebp
  801b9b:	39 d6                	cmp    %edx,%esi
  801b9d:	72 19                	jb     801bb8 <__udivdi3+0xfc>
  801b9f:	74 0b                	je     801bac <__udivdi3+0xf0>
  801ba1:	89 d8                	mov    %ebx,%eax
  801ba3:	31 ff                	xor    %edi,%edi
  801ba5:	e9 58 ff ff ff       	jmp    801b02 <__udivdi3+0x46>
  801baa:	66 90                	xchg   %ax,%ax
  801bac:	8b 54 24 08          	mov    0x8(%esp),%edx
  801bb0:	89 f9                	mov    %edi,%ecx
  801bb2:	d3 e2                	shl    %cl,%edx
  801bb4:	39 c2                	cmp    %eax,%edx
  801bb6:	73 e9                	jae    801ba1 <__udivdi3+0xe5>
  801bb8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801bbb:	31 ff                	xor    %edi,%edi
  801bbd:	e9 40 ff ff ff       	jmp    801b02 <__udivdi3+0x46>
  801bc2:	66 90                	xchg   %ax,%ax
  801bc4:	31 c0                	xor    %eax,%eax
  801bc6:	e9 37 ff ff ff       	jmp    801b02 <__udivdi3+0x46>
  801bcb:	90                   	nop

00801bcc <__umoddi3>:
  801bcc:	55                   	push   %ebp
  801bcd:	57                   	push   %edi
  801bce:	56                   	push   %esi
  801bcf:	53                   	push   %ebx
  801bd0:	83 ec 1c             	sub    $0x1c,%esp
  801bd3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801bd7:	8b 74 24 34          	mov    0x34(%esp),%esi
  801bdb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801bdf:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801be3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801be7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801beb:	89 f3                	mov    %esi,%ebx
  801bed:	89 fa                	mov    %edi,%edx
  801bef:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801bf3:	89 34 24             	mov    %esi,(%esp)
  801bf6:	85 c0                	test   %eax,%eax
  801bf8:	75 1a                	jne    801c14 <__umoddi3+0x48>
  801bfa:	39 f7                	cmp    %esi,%edi
  801bfc:	0f 86 a2 00 00 00    	jbe    801ca4 <__umoddi3+0xd8>
  801c02:	89 c8                	mov    %ecx,%eax
  801c04:	89 f2                	mov    %esi,%edx
  801c06:	f7 f7                	div    %edi
  801c08:	89 d0                	mov    %edx,%eax
  801c0a:	31 d2                	xor    %edx,%edx
  801c0c:	83 c4 1c             	add    $0x1c,%esp
  801c0f:	5b                   	pop    %ebx
  801c10:	5e                   	pop    %esi
  801c11:	5f                   	pop    %edi
  801c12:	5d                   	pop    %ebp
  801c13:	c3                   	ret    
  801c14:	39 f0                	cmp    %esi,%eax
  801c16:	0f 87 ac 00 00 00    	ja     801cc8 <__umoddi3+0xfc>
  801c1c:	0f bd e8             	bsr    %eax,%ebp
  801c1f:	83 f5 1f             	xor    $0x1f,%ebp
  801c22:	0f 84 ac 00 00 00    	je     801cd4 <__umoddi3+0x108>
  801c28:	bf 20 00 00 00       	mov    $0x20,%edi
  801c2d:	29 ef                	sub    %ebp,%edi
  801c2f:	89 fe                	mov    %edi,%esi
  801c31:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801c35:	89 e9                	mov    %ebp,%ecx
  801c37:	d3 e0                	shl    %cl,%eax
  801c39:	89 d7                	mov    %edx,%edi
  801c3b:	89 f1                	mov    %esi,%ecx
  801c3d:	d3 ef                	shr    %cl,%edi
  801c3f:	09 c7                	or     %eax,%edi
  801c41:	89 e9                	mov    %ebp,%ecx
  801c43:	d3 e2                	shl    %cl,%edx
  801c45:	89 14 24             	mov    %edx,(%esp)
  801c48:	89 d8                	mov    %ebx,%eax
  801c4a:	d3 e0                	shl    %cl,%eax
  801c4c:	89 c2                	mov    %eax,%edx
  801c4e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c52:	d3 e0                	shl    %cl,%eax
  801c54:	89 44 24 04          	mov    %eax,0x4(%esp)
  801c58:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c5c:	89 f1                	mov    %esi,%ecx
  801c5e:	d3 e8                	shr    %cl,%eax
  801c60:	09 d0                	or     %edx,%eax
  801c62:	d3 eb                	shr    %cl,%ebx
  801c64:	89 da                	mov    %ebx,%edx
  801c66:	f7 f7                	div    %edi
  801c68:	89 d3                	mov    %edx,%ebx
  801c6a:	f7 24 24             	mull   (%esp)
  801c6d:	89 c6                	mov    %eax,%esi
  801c6f:	89 d1                	mov    %edx,%ecx
  801c71:	39 d3                	cmp    %edx,%ebx
  801c73:	0f 82 87 00 00 00    	jb     801d00 <__umoddi3+0x134>
  801c79:	0f 84 91 00 00 00    	je     801d10 <__umoddi3+0x144>
  801c7f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801c83:	29 f2                	sub    %esi,%edx
  801c85:	19 cb                	sbb    %ecx,%ebx
  801c87:	89 d8                	mov    %ebx,%eax
  801c89:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801c8d:	d3 e0                	shl    %cl,%eax
  801c8f:	89 e9                	mov    %ebp,%ecx
  801c91:	d3 ea                	shr    %cl,%edx
  801c93:	09 d0                	or     %edx,%eax
  801c95:	89 e9                	mov    %ebp,%ecx
  801c97:	d3 eb                	shr    %cl,%ebx
  801c99:	89 da                	mov    %ebx,%edx
  801c9b:	83 c4 1c             	add    $0x1c,%esp
  801c9e:	5b                   	pop    %ebx
  801c9f:	5e                   	pop    %esi
  801ca0:	5f                   	pop    %edi
  801ca1:	5d                   	pop    %ebp
  801ca2:	c3                   	ret    
  801ca3:	90                   	nop
  801ca4:	89 fd                	mov    %edi,%ebp
  801ca6:	85 ff                	test   %edi,%edi
  801ca8:	75 0b                	jne    801cb5 <__umoddi3+0xe9>
  801caa:	b8 01 00 00 00       	mov    $0x1,%eax
  801caf:	31 d2                	xor    %edx,%edx
  801cb1:	f7 f7                	div    %edi
  801cb3:	89 c5                	mov    %eax,%ebp
  801cb5:	89 f0                	mov    %esi,%eax
  801cb7:	31 d2                	xor    %edx,%edx
  801cb9:	f7 f5                	div    %ebp
  801cbb:	89 c8                	mov    %ecx,%eax
  801cbd:	f7 f5                	div    %ebp
  801cbf:	89 d0                	mov    %edx,%eax
  801cc1:	e9 44 ff ff ff       	jmp    801c0a <__umoddi3+0x3e>
  801cc6:	66 90                	xchg   %ax,%ax
  801cc8:	89 c8                	mov    %ecx,%eax
  801cca:	89 f2                	mov    %esi,%edx
  801ccc:	83 c4 1c             	add    $0x1c,%esp
  801ccf:	5b                   	pop    %ebx
  801cd0:	5e                   	pop    %esi
  801cd1:	5f                   	pop    %edi
  801cd2:	5d                   	pop    %ebp
  801cd3:	c3                   	ret    
  801cd4:	3b 04 24             	cmp    (%esp),%eax
  801cd7:	72 06                	jb     801cdf <__umoddi3+0x113>
  801cd9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801cdd:	77 0f                	ja     801cee <__umoddi3+0x122>
  801cdf:	89 f2                	mov    %esi,%edx
  801ce1:	29 f9                	sub    %edi,%ecx
  801ce3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801ce7:	89 14 24             	mov    %edx,(%esp)
  801cea:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801cee:	8b 44 24 04          	mov    0x4(%esp),%eax
  801cf2:	8b 14 24             	mov    (%esp),%edx
  801cf5:	83 c4 1c             	add    $0x1c,%esp
  801cf8:	5b                   	pop    %ebx
  801cf9:	5e                   	pop    %esi
  801cfa:	5f                   	pop    %edi
  801cfb:	5d                   	pop    %ebp
  801cfc:	c3                   	ret    
  801cfd:	8d 76 00             	lea    0x0(%esi),%esi
  801d00:	2b 04 24             	sub    (%esp),%eax
  801d03:	19 fa                	sbb    %edi,%edx
  801d05:	89 d1                	mov    %edx,%ecx
  801d07:	89 c6                	mov    %eax,%esi
  801d09:	e9 71 ff ff ff       	jmp    801c7f <__umoddi3+0xb3>
  801d0e:	66 90                	xchg   %ax,%ax
  801d10:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801d14:	72 ea                	jb     801d00 <__umoddi3+0x134>
  801d16:	89 d9                	mov    %ebx,%ecx
  801d18:	e9 62 ff ff ff       	jmp    801c7f <__umoddi3+0xb3>
