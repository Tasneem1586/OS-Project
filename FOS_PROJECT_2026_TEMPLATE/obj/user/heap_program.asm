
obj/user/heap_program:     file format elf32-i386


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
  800031:	e8 12 02 00 00       	call   800248 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/* *********************************************************** */

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	83 ec 5c             	sub    $0x5c,%esp
	int kilo = 1024;
  800041:	c7 45 d8 00 04 00 00 	movl   $0x400,-0x28(%ebp)
	int Mega = 1024*1024;
  800048:	c7 45 d4 00 00 10 00 	movl   $0x100000,-0x2c(%ebp)

	/// testing freeHeap()
	{
		uint32 size = 13*Mega;
  80004f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800052:	89 d0                	mov    %edx,%eax
  800054:	01 c0                	add    %eax,%eax
  800056:	01 d0                	add    %edx,%eax
  800058:	c1 e0 02             	shl    $0x2,%eax
  80005b:	01 d0                	add    %edx,%eax
  80005d:	89 45 d0             	mov    %eax,-0x30(%ebp)
		char *x = malloc(sizeof( char)*size) ;
  800060:	83 ec 0c             	sub    $0xc,%esp
  800063:	ff 75 d0             	pushl  -0x30(%ebp)
  800066:	e8 63 16 00 00       	call   8016ce <malloc>
  80006b:	83 c4 10             	add    $0x10,%esp
  80006e:	89 45 cc             	mov    %eax,-0x34(%ebp)

		char *y = malloc(sizeof( char)*size) ;
  800071:	83 ec 0c             	sub    $0xc,%esp
  800074:	ff 75 d0             	pushl  -0x30(%ebp)
  800077:	e8 52 16 00 00       	call   8016ce <malloc>
  80007c:	83 c4 10             	add    $0x10,%esp
  80007f:	89 45 c8             	mov    %eax,-0x38(%ebp)


		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800082:	e8 66 18 00 00       	call   8018ed <sys_pf_calculate_allocated_pages>
  800087:	89 45 c4             	mov    %eax,-0x3c(%ebp)

		x[1]=-1;
  80008a:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80008d:	40                   	inc    %eax
  80008e:	c6 00 ff             	movb   $0xff,(%eax)

		x[5*Mega]=-1;
  800091:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800094:	89 d0                	mov    %edx,%eax
  800096:	c1 e0 02             	shl    $0x2,%eax
  800099:	01 d0                	add    %edx,%eax
  80009b:	89 c2                	mov    %eax,%edx
  80009d:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8000a0:	01 d0                	add    %edx,%eax
  8000a2:	c6 00 ff             	movb   $0xff,(%eax)

		//Access VA 0x200000
		int *p1 = (int *)0x200000 ;
  8000a5:	c7 45 c0 00 00 20 00 	movl   $0x200000,-0x40(%ebp)
		*p1 = -1 ;
  8000ac:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8000af:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)

		y[1*Mega]=-1;
  8000b5:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  8000b8:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8000bb:	01 d0                	add    %edx,%eax
  8000bd:	c6 00 ff             	movb   $0xff,(%eax)

		x[8*Mega] = -1;
  8000c0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8000c3:	c1 e0 03             	shl    $0x3,%eax
  8000c6:	89 c2                	mov    %eax,%edx
  8000c8:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8000cb:	01 d0                	add    %edx,%eax
  8000cd:	c6 00 ff             	movb   $0xff,(%eax)

		x[12*Mega]=-1;
  8000d0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  8000d3:	89 d0                	mov    %edx,%eax
  8000d5:	01 c0                	add    %eax,%eax
  8000d7:	01 d0                	add    %edx,%eax
  8000d9:	c1 e0 02             	shl    $0x2,%eax
  8000dc:	89 c2                	mov    %eax,%edx
  8000de:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8000e1:	01 d0                	add    %edx,%eax
  8000e3:	c6 00 ff             	movb   $0xff,(%eax)


		//int usedDiskPages = sys_pf_calculate_allocated_pages() ;


		free(x);
  8000e6:	83 ec 0c             	sub    $0xc,%esp
  8000e9:	ff 75 cc             	pushl  -0x34(%ebp)
  8000ec:	e8 0b 16 00 00       	call   8016fc <free>
  8000f1:	83 c4 10             	add    $0x10,%esp
		free(y);
  8000f4:	83 ec 0c             	sub    $0xc,%esp
  8000f7:	ff 75 c8             	pushl  -0x38(%ebp)
  8000fa:	e8 fd 15 00 00       	call   8016fc <free>
  8000ff:	83 c4 10             	add    $0x10,%esp

		///		cprintf("%d\n",sys_pf_calculate_allocated_pages() - usedDiskPages);
		///assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 5 ); //4 pages + 1 table, that was not in WS

		int freePages = sys_calculate_free_frames();
  800102:	e8 9b 17 00 00       	call   8018a2 <sys_calculate_free_frames>
  800107:	89 45 bc             	mov    %eax,-0x44(%ebp)
		x = malloc(sizeof(char)*size) ;
  80010a:	83 ec 0c             	sub    $0xc,%esp
  80010d:	ff 75 d0             	pushl  -0x30(%ebp)
  800110:	e8 b9 15 00 00       	call   8016ce <malloc>
  800115:	83 c4 10             	add    $0x10,%esp
  800118:	89 45 cc             	mov    %eax,-0x34(%ebp)

		//Access VA 0x200000
		*p1 = -1 ;
  80011b:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80011e:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)


		x[1]=-2;
  800124:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800127:	40                   	inc    %eax
  800128:	c6 00 fe             	movb   $0xfe,(%eax)

		x[5*Mega]=-2;
  80012b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80012e:	89 d0                	mov    %edx,%eax
  800130:	c1 e0 02             	shl    $0x2,%eax
  800133:	01 d0                	add    %edx,%eax
  800135:	89 c2                	mov    %eax,%edx
  800137:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80013a:	01 d0                	add    %edx,%eax
  80013c:	c6 00 fe             	movb   $0xfe,(%eax)

		x[8*Mega] = -2;
  80013f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800142:	c1 e0 03             	shl    $0x3,%eax
  800145:	89 c2                	mov    %eax,%edx
  800147:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80014a:	01 d0                	add    %edx,%eax
  80014c:	c6 00 fe             	movb   $0xfe,(%eax)

//		x[12*Mega]=-2;

		uint32 pageWSEntries[7] = {0x80000000, 0x80500000, 0x80800000, 0x800000, 0x803000, 0x200000, 0xeebfd000};
  80014f:	8d 45 9c             	lea    -0x64(%ebp),%eax
  800152:	bb 5c 21 80 00       	mov    $0x80215c,%ebx
  800157:	ba 07 00 00 00       	mov    $0x7,%edx
  80015c:	89 c7                	mov    %eax,%edi
  80015e:	89 de                	mov    %ebx,%esi
  800160:	89 d1                	mov    %edx,%ecx
  800162:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

		int i = 0, j ;
  800164:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
		for (; i < 7; i++)
  80016b:	e9 81 00 00 00       	jmp    8001f1 <_main+0x1b9>
		{
			int found = 0 ;
  800170:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
			for (j=0; j < (myEnv->page_WS_max_size); j++)
  800177:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80017e:	eb 3d                	jmp    8001bd <_main+0x185>
			{
				if (pageWSEntries[i] == ROUNDDOWN(myEnv->__uptr_pws[j].virtual_address,PAGE_SIZE) )
  800180:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800183:	8b 4c 85 9c          	mov    -0x64(%ebp,%eax,4),%ecx
  800187:	a1 20 30 80 00       	mov    0x803020,%eax
  80018c:	8b 98 7c 05 00 00    	mov    0x57c(%eax),%ebx
  800192:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800195:	89 d0                	mov    %edx,%eax
  800197:	01 c0                	add    %eax,%eax
  800199:	01 d0                	add    %edx,%eax
  80019b:	c1 e0 03             	shl    $0x3,%eax
  80019e:	01 d8                	add    %ebx,%eax
  8001a0:	8b 00                	mov    (%eax),%eax
  8001a2:	89 45 b8             	mov    %eax,-0x48(%ebp)
  8001a5:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8001a8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001ad:	39 c1                	cmp    %eax,%ecx
  8001af:	75 09                	jne    8001ba <_main+0x182>
				{
					found = 1 ;
  8001b1:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
					break;
  8001b8:	eb 15                	jmp    8001cf <_main+0x197>

		int i = 0, j ;
		for (; i < 7; i++)
		{
			int found = 0 ;
			for (j=0; j < (myEnv->page_WS_max_size); j++)
  8001ba:	ff 45 e0             	incl   -0x20(%ebp)
  8001bd:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c2:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8001c8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001cb:	39 c2                	cmp    %eax,%edx
  8001cd:	77 b1                	ja     800180 <_main+0x148>
				{
					found = 1 ;
					break;
				}
			}
			if (!found)
  8001cf:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8001d3:	75 19                	jne    8001ee <_main+0x1b6>
				panic("PAGE Placement algorithm failed after applying freeHeap. Page at VA %x is expected but not found", pageWSEntries[i]);
  8001d5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001d8:	8b 44 85 9c          	mov    -0x64(%ebp,%eax,4),%eax
  8001dc:	50                   	push   %eax
  8001dd:	68 60 20 80 00       	push   $0x802060
  8001e2:	6a 4c                	push   $0x4c
  8001e4:	68 c1 20 80 00       	push   $0x8020c1
  8001e9:	e8 ba 02 00 00       	call   8004a8 <_panic>
//		x[12*Mega]=-2;

		uint32 pageWSEntries[7] = {0x80000000, 0x80500000, 0x80800000, 0x800000, 0x803000, 0x200000, 0xeebfd000};

		int i = 0, j ;
		for (; i < 7; i++)
  8001ee:	ff 45 e4             	incl   -0x1c(%ebp)
  8001f1:	83 7d e4 06          	cmpl   $0x6,-0x1c(%ebp)
  8001f5:	0f 8e 75 ff ff ff    	jle    800170 <_main+0x138>
			}
			if (!found)
				panic("PAGE Placement algorithm failed after applying freeHeap. Page at VA %x is expected but not found", pageWSEntries[i]);
		}

		if( (freePages - sys_calculate_free_frames() ) != 6 ) panic("Extra/Less memory are wrongly allocated. diff = %d, expected = %d", freePages - sys_calculate_free_frames(), 8);
  8001fb:	8b 5d bc             	mov    -0x44(%ebp),%ebx
  8001fe:	e8 9f 16 00 00       	call   8018a2 <sys_calculate_free_frames>
  800203:	29 c3                	sub    %eax,%ebx
  800205:	89 d8                	mov    %ebx,%eax
  800207:	83 f8 06             	cmp    $0x6,%eax
  80020a:	74 23                	je     80022f <_main+0x1f7>
  80020c:	8b 5d bc             	mov    -0x44(%ebp),%ebx
  80020f:	e8 8e 16 00 00       	call   8018a2 <sys_calculate_free_frames>
  800214:	29 c3                	sub    %eax,%ebx
  800216:	89 d8                	mov    %ebx,%eax
  800218:	83 ec 0c             	sub    $0xc,%esp
  80021b:	6a 08                	push   $0x8
  80021d:	50                   	push   %eax
  80021e:	68 d8 20 80 00       	push   $0x8020d8
  800223:	6a 4f                	push   $0x4f
  800225:	68 c1 20 80 00       	push   $0x8020c1
  80022a:	e8 79 02 00 00       	call   8004a8 <_panic>
	}

	cprintf("Congratulations!! test HEAP_PROGRAM completed successfully.\n");
  80022f:	83 ec 0c             	sub    $0xc,%esp
  800232:	68 1c 21 80 00       	push   $0x80211c
  800237:	e8 3a 05 00 00       	call   800776 <cprintf>
  80023c:	83 c4 10             	add    $0x10,%esp


	return;
  80023f:	90                   	nop
}
  800240:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800243:	5b                   	pop    %ebx
  800244:	5e                   	pop    %esi
  800245:	5f                   	pop    %edi
  800246:	5d                   	pop    %ebp
  800247:	c3                   	ret    

00800248 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  800248:	55                   	push   %ebp
  800249:	89 e5                	mov    %esp,%ebp
  80024b:	57                   	push   %edi
  80024c:	56                   	push   %esi
  80024d:	53                   	push   %ebx
  80024e:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  800254:	e8 11 18 00 00       	call   801a6a <sys_getenvindex>
  800259:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  80025c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80025f:	89 d0                	mov    %edx,%eax
  800261:	c1 e0 03             	shl    $0x3,%eax
  800264:	01 d0                	add    %edx,%eax
  800266:	c1 e0 06             	shl    $0x6,%eax
  800269:	01 d0                	add    %edx,%eax
  80026b:	c1 e0 03             	shl    $0x3,%eax
  80026e:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800273:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800278:	a1 20 30 80 00       	mov    0x803020,%eax
  80027d:	8a 40 10             	mov    0x10(%eax),%al
  800280:	84 c0                	test   %al,%al
  800282:	74 0d                	je     800291 <libmain+0x49>
		binaryname = myEnv->prog_name;
  800284:	a1 20 30 80 00       	mov    0x803020,%eax
  800289:	83 c0 10             	add    $0x10,%eax
  80028c:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800291:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800295:	7e 0a                	jle    8002a1 <libmain+0x59>
		binaryname = argv[0];
  800297:	8b 45 0c             	mov    0xc(%ebp),%eax
  80029a:	8b 00                	mov    (%eax),%eax
  80029c:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  8002a1:	83 ec 08             	sub    $0x8,%esp
  8002a4:	ff 75 0c             	pushl  0xc(%ebp)
  8002a7:	ff 75 08             	pushl  0x8(%ebp)
  8002aa:	e8 89 fd ff ff       	call   800038 <_main>
  8002af:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  8002b2:	a1 00 30 80 00       	mov    0x803000,%eax
  8002b7:	85 c0                	test   %eax,%eax
  8002b9:	0f 84 b7 01 00 00    	je     800476 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  8002bf:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8002c5:	bb b4 22 80 00       	mov    $0x8022b4,%ebx
  8002ca:	ba 0e 00 00 00       	mov    $0xe,%edx
  8002cf:	89 c7                	mov    %eax,%edi
  8002d1:	89 de                	mov    %ebx,%esi
  8002d3:	89 d1                	mov    %edx,%ecx
  8002d5:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8002d7:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  8002dd:	b9 56 00 00 00       	mov    $0x56,%ecx
  8002e2:	b0 00                	mov    $0x0,%al
  8002e4:	89 d7                	mov    %edx,%edi
  8002e6:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  8002e8:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  8002ef:	8d 45 d8             	lea    -0x28(%ebp),%eax
  8002f2:	83 ec 08             	sub    $0x8,%esp
  8002f5:	50                   	push   %eax
  8002f6:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8002fc:	50                   	push   %eax
  8002fd:	e8 68 19 00 00       	call   801c6a <sys_utilities>
  800302:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800305:	e8 e8 14 00 00       	call   8017f2 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  80030a:	83 ec 0c             	sub    $0xc,%esp
  80030d:	68 90 21 80 00       	push   $0x802190
  800312:	e8 5f 04 00 00       	call   800776 <cprintf>
  800317:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  80031a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80031d:	85 c0                	test   %eax,%eax
  80031f:	74 58                	je     800379 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  800321:	e8 62 19 00 00       	call   801c88 <sys_get_optimal_num_faults>
  800326:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  800329:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  80032f:	bb 18 23 80 00       	mov    $0x802318,%ebx
  800334:	ba 11 00 00 00       	mov    $0x11,%edx
  800339:	89 c7                	mov    %eax,%edi
  80033b:	89 de                	mov    %ebx,%esi
  80033d:	89 d1                	mov    %edx,%ecx
  80033f:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800341:	8d 55 85             	lea    -0x7b(%ebp),%edx
  800344:	b9 53 00 00 00       	mov    $0x53,%ecx
  800349:	b0 00                	mov    $0x0,%al
  80034b:	89 d7                	mov    %edx,%edi
  80034d:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  80034f:	83 ec 08             	sub    $0x8,%esp
  800352:	ff 75 dc             	pushl  -0x24(%ebp)
  800355:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  80035b:	50                   	push   %eax
  80035c:	e8 09 19 00 00       	call   801c6a <sys_utilities>
  800361:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  800364:	83 ec 08             	sub    $0x8,%esp
  800367:	ff 75 dc             	pushl  -0x24(%ebp)
  80036a:	68 b8 21 80 00       	push   $0x8021b8
  80036f:	e8 02 04 00 00       	call   800776 <cprintf>
  800374:	83 c4 10             	add    $0x10,%esp
  800377:	eb 59                	jmp    8003d2 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800379:	a1 20 30 80 00       	mov    0x803020,%eax
  80037e:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  800384:	a1 20 30 80 00       	mov    0x803020,%eax
  800389:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  80038f:	83 ec 04             	sub    $0x4,%esp
  800392:	52                   	push   %edx
  800393:	50                   	push   %eax
  800394:	68 dc 21 80 00       	push   $0x8021dc
  800399:	e8 d8 03 00 00       	call   800776 <cprintf>
  80039e:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  8003a1:	a1 20 30 80 00       	mov    0x803020,%eax
  8003a6:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  8003ac:	a1 20 30 80 00       	mov    0x803020,%eax
  8003b1:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  8003b7:	a1 20 30 80 00       	mov    0x803020,%eax
  8003bc:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  8003c2:	51                   	push   %ecx
  8003c3:	52                   	push   %edx
  8003c4:	50                   	push   %eax
  8003c5:	68 04 22 80 00       	push   $0x802204
  8003ca:	e8 a7 03 00 00       	call   800776 <cprintf>
  8003cf:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8003d2:	a1 20 30 80 00       	mov    0x803020,%eax
  8003d7:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  8003dd:	83 ec 08             	sub    $0x8,%esp
  8003e0:	50                   	push   %eax
  8003e1:	68 5c 22 80 00       	push   $0x80225c
  8003e6:	e8 8b 03 00 00       	call   800776 <cprintf>
  8003eb:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  8003ee:	83 ec 0c             	sub    $0xc,%esp
  8003f1:	68 70 22 80 00       	push   $0x802270
  8003f6:	e8 7b 03 00 00       	call   800776 <cprintf>
  8003fb:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  8003fe:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800405:	eb 28                	jmp    80042f <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  800407:	a1 20 30 80 00       	mov    0x803020,%eax
  80040c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80040f:	81 c2 74 04 00 00    	add    $0x474,%edx
  800415:	8b 04 90             	mov    (%eax,%edx,4),%eax
  800418:	83 ec 04             	sub    $0x4,%esp
  80041b:	50                   	push   %eax
  80041c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80041f:	68 87 22 80 00       	push   $0x802287
  800424:	e8 4d 03 00 00       	call   800776 <cprintf>
  800429:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  80042c:	ff 45 e4             	incl   -0x1c(%ebp)
  80042f:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800433:	7e d2                	jle    800407 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  800435:	83 ec 0c             	sub    $0xc,%esp
  800438:	68 96 22 80 00       	push   $0x802296
  80043d:	e8 34 03 00 00       	call   800776 <cprintf>
  800442:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  800445:	a1 20 30 80 00       	mov    0x803020,%eax
  80044a:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  800450:	83 ec 08             	sub    $0x8,%esp
  800453:	50                   	push   %eax
  800454:	68 9a 22 80 00       	push   $0x80229a
  800459:	e8 18 03 00 00       	call   800776 <cprintf>
  80045e:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  800461:	83 ec 0c             	sub    $0xc,%esp
  800464:	68 90 21 80 00       	push   $0x802190
  800469:	e8 08 03 00 00       	call   800776 <cprintf>
  80046e:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  800471:	e8 96 13 00 00       	call   80180c <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  800476:	e8 1f 00 00 00       	call   80049a <exit>
}
  80047b:	90                   	nop
  80047c:	8d 65 f4             	lea    -0xc(%ebp),%esp
  80047f:	5b                   	pop    %ebx
  800480:	5e                   	pop    %esi
  800481:	5f                   	pop    %edi
  800482:	5d                   	pop    %ebp
  800483:	c3                   	ret    

00800484 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800484:	55                   	push   %ebp
  800485:	89 e5                	mov    %esp,%ebp
  800487:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  80048a:	83 ec 0c             	sub    $0xc,%esp
  80048d:	6a 00                	push   $0x0
  80048f:	e8 a2 15 00 00       	call   801a36 <sys_destroy_env>
  800494:	83 c4 10             	add    $0x10,%esp
}
  800497:	90                   	nop
  800498:	c9                   	leave  
  800499:	c3                   	ret    

0080049a <exit>:

void
exit(void)
{
  80049a:	55                   	push   %ebp
  80049b:	89 e5                	mov    %esp,%ebp
  80049d:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  8004a0:	e8 f7 15 00 00       	call   801a9c <sys_exit_env>
}
  8004a5:	90                   	nop
  8004a6:	c9                   	leave  
  8004a7:	c3                   	ret    

008004a8 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8004a8:	55                   	push   %ebp
  8004a9:	89 e5                	mov    %esp,%ebp
  8004ab:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8004ae:	8d 45 10             	lea    0x10(%ebp),%eax
  8004b1:	83 c0 04             	add    $0x4,%eax
  8004b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8004b7:	a1 28 31 80 00       	mov    0x803128,%eax
  8004bc:	85 c0                	test   %eax,%eax
  8004be:	74 16                	je     8004d6 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8004c0:	a1 28 31 80 00       	mov    0x803128,%eax
  8004c5:	83 ec 08             	sub    $0x8,%esp
  8004c8:	50                   	push   %eax
  8004c9:	68 7c 23 80 00       	push   $0x80237c
  8004ce:	e8 a3 02 00 00       	call   800776 <cprintf>
  8004d3:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  8004d6:	a1 04 30 80 00       	mov    0x803004,%eax
  8004db:	83 ec 0c             	sub    $0xc,%esp
  8004de:	ff 75 0c             	pushl  0xc(%ebp)
  8004e1:	ff 75 08             	pushl  0x8(%ebp)
  8004e4:	50                   	push   %eax
  8004e5:	68 84 23 80 00       	push   $0x802384
  8004ea:	6a 74                	push   $0x74
  8004ec:	e8 b2 02 00 00       	call   8007a3 <cprintf_colored>
  8004f1:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  8004f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8004f7:	83 ec 08             	sub    $0x8,%esp
  8004fa:	ff 75 f4             	pushl  -0xc(%ebp)
  8004fd:	50                   	push   %eax
  8004fe:	e8 04 02 00 00       	call   800707 <vcprintf>
  800503:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800506:	83 ec 08             	sub    $0x8,%esp
  800509:	6a 00                	push   $0x0
  80050b:	68 ac 23 80 00       	push   $0x8023ac
  800510:	e8 f2 01 00 00       	call   800707 <vcprintf>
  800515:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800518:	e8 7d ff ff ff       	call   80049a <exit>

	// should not return here
	while (1) ;
  80051d:	eb fe                	jmp    80051d <_panic+0x75>

0080051f <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80051f:	55                   	push   %ebp
  800520:	89 e5                	mov    %esp,%ebp
  800522:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800525:	a1 20 30 80 00       	mov    0x803020,%eax
  80052a:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800530:	8b 45 0c             	mov    0xc(%ebp),%eax
  800533:	39 c2                	cmp    %eax,%edx
  800535:	74 14                	je     80054b <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800537:	83 ec 04             	sub    $0x4,%esp
  80053a:	68 b0 23 80 00       	push   $0x8023b0
  80053f:	6a 26                	push   $0x26
  800541:	68 fc 23 80 00       	push   $0x8023fc
  800546:	e8 5d ff ff ff       	call   8004a8 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80054b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800552:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800559:	e9 c5 00 00 00       	jmp    800623 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  80055e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800561:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800568:	8b 45 08             	mov    0x8(%ebp),%eax
  80056b:	01 d0                	add    %edx,%eax
  80056d:	8b 00                	mov    (%eax),%eax
  80056f:	85 c0                	test   %eax,%eax
  800571:	75 08                	jne    80057b <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  800573:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800576:	e9 a5 00 00 00       	jmp    800620 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  80057b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800582:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800589:	eb 69                	jmp    8005f4 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80058b:	a1 20 30 80 00       	mov    0x803020,%eax
  800590:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800596:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800599:	89 d0                	mov    %edx,%eax
  80059b:	01 c0                	add    %eax,%eax
  80059d:	01 d0                	add    %edx,%eax
  80059f:	c1 e0 03             	shl    $0x3,%eax
  8005a2:	01 c8                	add    %ecx,%eax
  8005a4:	8a 40 04             	mov    0x4(%eax),%al
  8005a7:	84 c0                	test   %al,%al
  8005a9:	75 46                	jne    8005f1 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8005ab:	a1 20 30 80 00       	mov    0x803020,%eax
  8005b0:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8005b6:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005b9:	89 d0                	mov    %edx,%eax
  8005bb:	01 c0                	add    %eax,%eax
  8005bd:	01 d0                	add    %edx,%eax
  8005bf:	c1 e0 03             	shl    $0x3,%eax
  8005c2:	01 c8                	add    %ecx,%eax
  8005c4:	8b 00                	mov    (%eax),%eax
  8005c6:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8005c9:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005cc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005d1:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8005d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005d6:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e0:	01 c8                	add    %ecx,%eax
  8005e2:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8005e4:	39 c2                	cmp    %eax,%edx
  8005e6:	75 09                	jne    8005f1 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  8005e8:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8005ef:	eb 15                	jmp    800606 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005f1:	ff 45 e8             	incl   -0x18(%ebp)
  8005f4:	a1 20 30 80 00       	mov    0x803020,%eax
  8005f9:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8005ff:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800602:	39 c2                	cmp    %eax,%edx
  800604:	77 85                	ja     80058b <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800606:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80060a:	75 14                	jne    800620 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  80060c:	83 ec 04             	sub    $0x4,%esp
  80060f:	68 08 24 80 00       	push   $0x802408
  800614:	6a 3a                	push   $0x3a
  800616:	68 fc 23 80 00       	push   $0x8023fc
  80061b:	e8 88 fe ff ff       	call   8004a8 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800620:	ff 45 f0             	incl   -0x10(%ebp)
  800623:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800626:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800629:	0f 8c 2f ff ff ff    	jl     80055e <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80062f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800636:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80063d:	eb 26                	jmp    800665 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80063f:	a1 20 30 80 00       	mov    0x803020,%eax
  800644:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  80064a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80064d:	89 d0                	mov    %edx,%eax
  80064f:	01 c0                	add    %eax,%eax
  800651:	01 d0                	add    %edx,%eax
  800653:	c1 e0 03             	shl    $0x3,%eax
  800656:	01 c8                	add    %ecx,%eax
  800658:	8a 40 04             	mov    0x4(%eax),%al
  80065b:	3c 01                	cmp    $0x1,%al
  80065d:	75 03                	jne    800662 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  80065f:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800662:	ff 45 e0             	incl   -0x20(%ebp)
  800665:	a1 20 30 80 00       	mov    0x803020,%eax
  80066a:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800670:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800673:	39 c2                	cmp    %eax,%edx
  800675:	77 c8                	ja     80063f <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800677:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80067a:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80067d:	74 14                	je     800693 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  80067f:	83 ec 04             	sub    $0x4,%esp
  800682:	68 5c 24 80 00       	push   $0x80245c
  800687:	6a 44                	push   $0x44
  800689:	68 fc 23 80 00       	push   $0x8023fc
  80068e:	e8 15 fe ff ff       	call   8004a8 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800693:	90                   	nop
  800694:	c9                   	leave  
  800695:	c3                   	ret    

00800696 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800696:	55                   	push   %ebp
  800697:	89 e5                	mov    %esp,%ebp
  800699:	53                   	push   %ebx
  80069a:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  80069d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006a0:	8b 00                	mov    (%eax),%eax
  8006a2:	8d 48 01             	lea    0x1(%eax),%ecx
  8006a5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006a8:	89 0a                	mov    %ecx,(%edx)
  8006aa:	8b 55 08             	mov    0x8(%ebp),%edx
  8006ad:	88 d1                	mov    %dl,%cl
  8006af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006b2:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8006b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006b9:	8b 00                	mov    (%eax),%eax
  8006bb:	3d ff 00 00 00       	cmp    $0xff,%eax
  8006c0:	75 30                	jne    8006f2 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  8006c2:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  8006c8:	a0 40 30 80 00       	mov    0x803040,%al
  8006cd:	0f b6 c0             	movzbl %al,%eax
  8006d0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8006d3:	8b 09                	mov    (%ecx),%ecx
  8006d5:	89 cb                	mov    %ecx,%ebx
  8006d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8006da:	83 c1 08             	add    $0x8,%ecx
  8006dd:	52                   	push   %edx
  8006de:	50                   	push   %eax
  8006df:	53                   	push   %ebx
  8006e0:	51                   	push   %ecx
  8006e1:	e8 c8 10 00 00       	call   8017ae <sys_cputs>
  8006e6:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8006e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006ec:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8006f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006f5:	8b 40 04             	mov    0x4(%eax),%eax
  8006f8:	8d 50 01             	lea    0x1(%eax),%edx
  8006fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006fe:	89 50 04             	mov    %edx,0x4(%eax)
}
  800701:	90                   	nop
  800702:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800705:	c9                   	leave  
  800706:	c3                   	ret    

00800707 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800707:	55                   	push   %ebp
  800708:	89 e5                	mov    %esp,%ebp
  80070a:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800710:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800717:	00 00 00 
	b.cnt = 0;
  80071a:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800721:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800724:	ff 75 0c             	pushl  0xc(%ebp)
  800727:	ff 75 08             	pushl  0x8(%ebp)
  80072a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800730:	50                   	push   %eax
  800731:	68 96 06 80 00       	push   $0x800696
  800736:	e8 5a 02 00 00       	call   800995 <vprintfmt>
  80073b:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  80073e:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  800744:	a0 40 30 80 00       	mov    0x803040,%al
  800749:	0f b6 c0             	movzbl %al,%eax
  80074c:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800752:	52                   	push   %edx
  800753:	50                   	push   %eax
  800754:	51                   	push   %ecx
  800755:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80075b:	83 c0 08             	add    $0x8,%eax
  80075e:	50                   	push   %eax
  80075f:	e8 4a 10 00 00       	call   8017ae <sys_cputs>
  800764:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800767:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  80076e:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800774:	c9                   	leave  
  800775:	c3                   	ret    

00800776 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800776:	55                   	push   %ebp
  800777:	89 e5                	mov    %esp,%ebp
  800779:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80077c:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  800783:	8d 45 0c             	lea    0xc(%ebp),%eax
  800786:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800789:	8b 45 08             	mov    0x8(%ebp),%eax
  80078c:	83 ec 08             	sub    $0x8,%esp
  80078f:	ff 75 f4             	pushl  -0xc(%ebp)
  800792:	50                   	push   %eax
  800793:	e8 6f ff ff ff       	call   800707 <vcprintf>
  800798:	83 c4 10             	add    $0x10,%esp
  80079b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80079e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8007a1:	c9                   	leave  
  8007a2:	c3                   	ret    

008007a3 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  8007a3:	55                   	push   %ebp
  8007a4:	89 e5                	mov    %esp,%ebp
  8007a6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8007a9:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  8007b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b3:	c1 e0 08             	shl    $0x8,%eax
  8007b6:	a3 2c 31 80 00       	mov    %eax,0x80312c
	va_start(ap, fmt);
  8007bb:	8d 45 0c             	lea    0xc(%ebp),%eax
  8007be:	83 c0 04             	add    $0x4,%eax
  8007c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8007c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007c7:	83 ec 08             	sub    $0x8,%esp
  8007ca:	ff 75 f4             	pushl  -0xc(%ebp)
  8007cd:	50                   	push   %eax
  8007ce:	e8 34 ff ff ff       	call   800707 <vcprintf>
  8007d3:	83 c4 10             	add    $0x10,%esp
  8007d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  8007d9:	c7 05 2c 31 80 00 00 	movl   $0x700,0x80312c
  8007e0:	07 00 00 

	return cnt;
  8007e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8007e6:	c9                   	leave  
  8007e7:	c3                   	ret    

008007e8 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  8007e8:	55                   	push   %ebp
  8007e9:	89 e5                	mov    %esp,%ebp
  8007eb:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  8007ee:	e8 ff 0f 00 00       	call   8017f2 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  8007f3:	8d 45 0c             	lea    0xc(%ebp),%eax
  8007f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  8007f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fc:	83 ec 08             	sub    $0x8,%esp
  8007ff:	ff 75 f4             	pushl  -0xc(%ebp)
  800802:	50                   	push   %eax
  800803:	e8 ff fe ff ff       	call   800707 <vcprintf>
  800808:	83 c4 10             	add    $0x10,%esp
  80080b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  80080e:	e8 f9 0f 00 00       	call   80180c <sys_unlock_cons>
	return cnt;
  800813:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800816:	c9                   	leave  
  800817:	c3                   	ret    

00800818 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800818:	55                   	push   %ebp
  800819:	89 e5                	mov    %esp,%ebp
  80081b:	53                   	push   %ebx
  80081c:	83 ec 14             	sub    $0x14,%esp
  80081f:	8b 45 10             	mov    0x10(%ebp),%eax
  800822:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800825:	8b 45 14             	mov    0x14(%ebp),%eax
  800828:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80082b:	8b 45 18             	mov    0x18(%ebp),%eax
  80082e:	ba 00 00 00 00       	mov    $0x0,%edx
  800833:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800836:	77 55                	ja     80088d <printnum+0x75>
  800838:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80083b:	72 05                	jb     800842 <printnum+0x2a>
  80083d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800840:	77 4b                	ja     80088d <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800842:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800845:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800848:	8b 45 18             	mov    0x18(%ebp),%eax
  80084b:	ba 00 00 00 00       	mov    $0x0,%edx
  800850:	52                   	push   %edx
  800851:	50                   	push   %eax
  800852:	ff 75 f4             	pushl  -0xc(%ebp)
  800855:	ff 75 f0             	pushl  -0x10(%ebp)
  800858:	e8 8b 15 00 00       	call   801de8 <__udivdi3>
  80085d:	83 c4 10             	add    $0x10,%esp
  800860:	83 ec 04             	sub    $0x4,%esp
  800863:	ff 75 20             	pushl  0x20(%ebp)
  800866:	53                   	push   %ebx
  800867:	ff 75 18             	pushl  0x18(%ebp)
  80086a:	52                   	push   %edx
  80086b:	50                   	push   %eax
  80086c:	ff 75 0c             	pushl  0xc(%ebp)
  80086f:	ff 75 08             	pushl  0x8(%ebp)
  800872:	e8 a1 ff ff ff       	call   800818 <printnum>
  800877:	83 c4 20             	add    $0x20,%esp
  80087a:	eb 1a                	jmp    800896 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80087c:	83 ec 08             	sub    $0x8,%esp
  80087f:	ff 75 0c             	pushl  0xc(%ebp)
  800882:	ff 75 20             	pushl  0x20(%ebp)
  800885:	8b 45 08             	mov    0x8(%ebp),%eax
  800888:	ff d0                	call   *%eax
  80088a:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80088d:	ff 4d 1c             	decl   0x1c(%ebp)
  800890:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800894:	7f e6                	jg     80087c <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800896:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800899:	bb 00 00 00 00       	mov    $0x0,%ebx
  80089e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008a1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008a4:	53                   	push   %ebx
  8008a5:	51                   	push   %ecx
  8008a6:	52                   	push   %edx
  8008a7:	50                   	push   %eax
  8008a8:	e8 4b 16 00 00       	call   801ef8 <__umoddi3>
  8008ad:	83 c4 10             	add    $0x10,%esp
  8008b0:	05 d4 26 80 00       	add    $0x8026d4,%eax
  8008b5:	8a 00                	mov    (%eax),%al
  8008b7:	0f be c0             	movsbl %al,%eax
  8008ba:	83 ec 08             	sub    $0x8,%esp
  8008bd:	ff 75 0c             	pushl  0xc(%ebp)
  8008c0:	50                   	push   %eax
  8008c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c4:	ff d0                	call   *%eax
  8008c6:	83 c4 10             	add    $0x10,%esp
}
  8008c9:	90                   	nop
  8008ca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8008cd:	c9                   	leave  
  8008ce:	c3                   	ret    

008008cf <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8008cf:	55                   	push   %ebp
  8008d0:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8008d2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8008d6:	7e 1c                	jle    8008f4 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8008d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8008db:	8b 00                	mov    (%eax),%eax
  8008dd:	8d 50 08             	lea    0x8(%eax),%edx
  8008e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e3:	89 10                	mov    %edx,(%eax)
  8008e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e8:	8b 00                	mov    (%eax),%eax
  8008ea:	83 e8 08             	sub    $0x8,%eax
  8008ed:	8b 50 04             	mov    0x4(%eax),%edx
  8008f0:	8b 00                	mov    (%eax),%eax
  8008f2:	eb 40                	jmp    800934 <getuint+0x65>
	else if (lflag)
  8008f4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008f8:	74 1e                	je     800918 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8008fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8008fd:	8b 00                	mov    (%eax),%eax
  8008ff:	8d 50 04             	lea    0x4(%eax),%edx
  800902:	8b 45 08             	mov    0x8(%ebp),%eax
  800905:	89 10                	mov    %edx,(%eax)
  800907:	8b 45 08             	mov    0x8(%ebp),%eax
  80090a:	8b 00                	mov    (%eax),%eax
  80090c:	83 e8 04             	sub    $0x4,%eax
  80090f:	8b 00                	mov    (%eax),%eax
  800911:	ba 00 00 00 00       	mov    $0x0,%edx
  800916:	eb 1c                	jmp    800934 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800918:	8b 45 08             	mov    0x8(%ebp),%eax
  80091b:	8b 00                	mov    (%eax),%eax
  80091d:	8d 50 04             	lea    0x4(%eax),%edx
  800920:	8b 45 08             	mov    0x8(%ebp),%eax
  800923:	89 10                	mov    %edx,(%eax)
  800925:	8b 45 08             	mov    0x8(%ebp),%eax
  800928:	8b 00                	mov    (%eax),%eax
  80092a:	83 e8 04             	sub    $0x4,%eax
  80092d:	8b 00                	mov    (%eax),%eax
  80092f:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800934:	5d                   	pop    %ebp
  800935:	c3                   	ret    

00800936 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800936:	55                   	push   %ebp
  800937:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800939:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80093d:	7e 1c                	jle    80095b <getint+0x25>
		return va_arg(*ap, long long);
  80093f:	8b 45 08             	mov    0x8(%ebp),%eax
  800942:	8b 00                	mov    (%eax),%eax
  800944:	8d 50 08             	lea    0x8(%eax),%edx
  800947:	8b 45 08             	mov    0x8(%ebp),%eax
  80094a:	89 10                	mov    %edx,(%eax)
  80094c:	8b 45 08             	mov    0x8(%ebp),%eax
  80094f:	8b 00                	mov    (%eax),%eax
  800951:	83 e8 08             	sub    $0x8,%eax
  800954:	8b 50 04             	mov    0x4(%eax),%edx
  800957:	8b 00                	mov    (%eax),%eax
  800959:	eb 38                	jmp    800993 <getint+0x5d>
	else if (lflag)
  80095b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80095f:	74 1a                	je     80097b <getint+0x45>
		return va_arg(*ap, long);
  800961:	8b 45 08             	mov    0x8(%ebp),%eax
  800964:	8b 00                	mov    (%eax),%eax
  800966:	8d 50 04             	lea    0x4(%eax),%edx
  800969:	8b 45 08             	mov    0x8(%ebp),%eax
  80096c:	89 10                	mov    %edx,(%eax)
  80096e:	8b 45 08             	mov    0x8(%ebp),%eax
  800971:	8b 00                	mov    (%eax),%eax
  800973:	83 e8 04             	sub    $0x4,%eax
  800976:	8b 00                	mov    (%eax),%eax
  800978:	99                   	cltd   
  800979:	eb 18                	jmp    800993 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80097b:	8b 45 08             	mov    0x8(%ebp),%eax
  80097e:	8b 00                	mov    (%eax),%eax
  800980:	8d 50 04             	lea    0x4(%eax),%edx
  800983:	8b 45 08             	mov    0x8(%ebp),%eax
  800986:	89 10                	mov    %edx,(%eax)
  800988:	8b 45 08             	mov    0x8(%ebp),%eax
  80098b:	8b 00                	mov    (%eax),%eax
  80098d:	83 e8 04             	sub    $0x4,%eax
  800990:	8b 00                	mov    (%eax),%eax
  800992:	99                   	cltd   
}
  800993:	5d                   	pop    %ebp
  800994:	c3                   	ret    

00800995 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800995:	55                   	push   %ebp
  800996:	89 e5                	mov    %esp,%ebp
  800998:	56                   	push   %esi
  800999:	53                   	push   %ebx
  80099a:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80099d:	eb 17                	jmp    8009b6 <vprintfmt+0x21>
			if (ch == '\0')
  80099f:	85 db                	test   %ebx,%ebx
  8009a1:	0f 84 c1 03 00 00    	je     800d68 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  8009a7:	83 ec 08             	sub    $0x8,%esp
  8009aa:	ff 75 0c             	pushl  0xc(%ebp)
  8009ad:	53                   	push   %ebx
  8009ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b1:	ff d0                	call   *%eax
  8009b3:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8009b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8009b9:	8d 50 01             	lea    0x1(%eax),%edx
  8009bc:	89 55 10             	mov    %edx,0x10(%ebp)
  8009bf:	8a 00                	mov    (%eax),%al
  8009c1:	0f b6 d8             	movzbl %al,%ebx
  8009c4:	83 fb 25             	cmp    $0x25,%ebx
  8009c7:	75 d6                	jne    80099f <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8009c9:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8009cd:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8009d4:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8009db:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8009e2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8009e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8009ec:	8d 50 01             	lea    0x1(%eax),%edx
  8009ef:	89 55 10             	mov    %edx,0x10(%ebp)
  8009f2:	8a 00                	mov    (%eax),%al
  8009f4:	0f b6 d8             	movzbl %al,%ebx
  8009f7:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8009fa:	83 f8 5b             	cmp    $0x5b,%eax
  8009fd:	0f 87 3d 03 00 00    	ja     800d40 <vprintfmt+0x3ab>
  800a03:	8b 04 85 f8 26 80 00 	mov    0x8026f8(,%eax,4),%eax
  800a0a:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800a0c:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800a10:	eb d7                	jmp    8009e9 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800a12:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800a16:	eb d1                	jmp    8009e9 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a18:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800a1f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a22:	89 d0                	mov    %edx,%eax
  800a24:	c1 e0 02             	shl    $0x2,%eax
  800a27:	01 d0                	add    %edx,%eax
  800a29:	01 c0                	add    %eax,%eax
  800a2b:	01 d8                	add    %ebx,%eax
  800a2d:	83 e8 30             	sub    $0x30,%eax
  800a30:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800a33:	8b 45 10             	mov    0x10(%ebp),%eax
  800a36:	8a 00                	mov    (%eax),%al
  800a38:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800a3b:	83 fb 2f             	cmp    $0x2f,%ebx
  800a3e:	7e 3e                	jle    800a7e <vprintfmt+0xe9>
  800a40:	83 fb 39             	cmp    $0x39,%ebx
  800a43:	7f 39                	jg     800a7e <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a45:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800a48:	eb d5                	jmp    800a1f <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800a4a:	8b 45 14             	mov    0x14(%ebp),%eax
  800a4d:	83 c0 04             	add    $0x4,%eax
  800a50:	89 45 14             	mov    %eax,0x14(%ebp)
  800a53:	8b 45 14             	mov    0x14(%ebp),%eax
  800a56:	83 e8 04             	sub    $0x4,%eax
  800a59:	8b 00                	mov    (%eax),%eax
  800a5b:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800a5e:	eb 1f                	jmp    800a7f <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800a60:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a64:	79 83                	jns    8009e9 <vprintfmt+0x54>
				width = 0;
  800a66:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800a6d:	e9 77 ff ff ff       	jmp    8009e9 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800a72:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800a79:	e9 6b ff ff ff       	jmp    8009e9 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800a7e:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800a7f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a83:	0f 89 60 ff ff ff    	jns    8009e9 <vprintfmt+0x54>
				width = precision, precision = -1;
  800a89:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a8c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800a8f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800a96:	e9 4e ff ff ff       	jmp    8009e9 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800a9b:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800a9e:	e9 46 ff ff ff       	jmp    8009e9 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800aa3:	8b 45 14             	mov    0x14(%ebp),%eax
  800aa6:	83 c0 04             	add    $0x4,%eax
  800aa9:	89 45 14             	mov    %eax,0x14(%ebp)
  800aac:	8b 45 14             	mov    0x14(%ebp),%eax
  800aaf:	83 e8 04             	sub    $0x4,%eax
  800ab2:	8b 00                	mov    (%eax),%eax
  800ab4:	83 ec 08             	sub    $0x8,%esp
  800ab7:	ff 75 0c             	pushl  0xc(%ebp)
  800aba:	50                   	push   %eax
  800abb:	8b 45 08             	mov    0x8(%ebp),%eax
  800abe:	ff d0                	call   *%eax
  800ac0:	83 c4 10             	add    $0x10,%esp
			break;
  800ac3:	e9 9b 02 00 00       	jmp    800d63 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800ac8:	8b 45 14             	mov    0x14(%ebp),%eax
  800acb:	83 c0 04             	add    $0x4,%eax
  800ace:	89 45 14             	mov    %eax,0x14(%ebp)
  800ad1:	8b 45 14             	mov    0x14(%ebp),%eax
  800ad4:	83 e8 04             	sub    $0x4,%eax
  800ad7:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800ad9:	85 db                	test   %ebx,%ebx
  800adb:	79 02                	jns    800adf <vprintfmt+0x14a>
				err = -err;
  800add:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800adf:	83 fb 64             	cmp    $0x64,%ebx
  800ae2:	7f 0b                	jg     800aef <vprintfmt+0x15a>
  800ae4:	8b 34 9d 40 25 80 00 	mov    0x802540(,%ebx,4),%esi
  800aeb:	85 f6                	test   %esi,%esi
  800aed:	75 19                	jne    800b08 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800aef:	53                   	push   %ebx
  800af0:	68 e5 26 80 00       	push   $0x8026e5
  800af5:	ff 75 0c             	pushl  0xc(%ebp)
  800af8:	ff 75 08             	pushl  0x8(%ebp)
  800afb:	e8 70 02 00 00       	call   800d70 <printfmt>
  800b00:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800b03:	e9 5b 02 00 00       	jmp    800d63 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800b08:	56                   	push   %esi
  800b09:	68 ee 26 80 00       	push   $0x8026ee
  800b0e:	ff 75 0c             	pushl  0xc(%ebp)
  800b11:	ff 75 08             	pushl  0x8(%ebp)
  800b14:	e8 57 02 00 00       	call   800d70 <printfmt>
  800b19:	83 c4 10             	add    $0x10,%esp
			break;
  800b1c:	e9 42 02 00 00       	jmp    800d63 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800b21:	8b 45 14             	mov    0x14(%ebp),%eax
  800b24:	83 c0 04             	add    $0x4,%eax
  800b27:	89 45 14             	mov    %eax,0x14(%ebp)
  800b2a:	8b 45 14             	mov    0x14(%ebp),%eax
  800b2d:	83 e8 04             	sub    $0x4,%eax
  800b30:	8b 30                	mov    (%eax),%esi
  800b32:	85 f6                	test   %esi,%esi
  800b34:	75 05                	jne    800b3b <vprintfmt+0x1a6>
				p = "(null)";
  800b36:	be f1 26 80 00       	mov    $0x8026f1,%esi
			if (width > 0 && padc != '-')
  800b3b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b3f:	7e 6d                	jle    800bae <vprintfmt+0x219>
  800b41:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800b45:	74 67                	je     800bae <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800b47:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b4a:	83 ec 08             	sub    $0x8,%esp
  800b4d:	50                   	push   %eax
  800b4e:	56                   	push   %esi
  800b4f:	e8 1e 03 00 00       	call   800e72 <strnlen>
  800b54:	83 c4 10             	add    $0x10,%esp
  800b57:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800b5a:	eb 16                	jmp    800b72 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800b5c:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800b60:	83 ec 08             	sub    $0x8,%esp
  800b63:	ff 75 0c             	pushl  0xc(%ebp)
  800b66:	50                   	push   %eax
  800b67:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6a:	ff d0                	call   *%eax
  800b6c:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800b6f:	ff 4d e4             	decl   -0x1c(%ebp)
  800b72:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b76:	7f e4                	jg     800b5c <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b78:	eb 34                	jmp    800bae <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800b7a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800b7e:	74 1c                	je     800b9c <vprintfmt+0x207>
  800b80:	83 fb 1f             	cmp    $0x1f,%ebx
  800b83:	7e 05                	jle    800b8a <vprintfmt+0x1f5>
  800b85:	83 fb 7e             	cmp    $0x7e,%ebx
  800b88:	7e 12                	jle    800b9c <vprintfmt+0x207>
					putch('?', putdat);
  800b8a:	83 ec 08             	sub    $0x8,%esp
  800b8d:	ff 75 0c             	pushl  0xc(%ebp)
  800b90:	6a 3f                	push   $0x3f
  800b92:	8b 45 08             	mov    0x8(%ebp),%eax
  800b95:	ff d0                	call   *%eax
  800b97:	83 c4 10             	add    $0x10,%esp
  800b9a:	eb 0f                	jmp    800bab <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800b9c:	83 ec 08             	sub    $0x8,%esp
  800b9f:	ff 75 0c             	pushl  0xc(%ebp)
  800ba2:	53                   	push   %ebx
  800ba3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba6:	ff d0                	call   *%eax
  800ba8:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800bab:	ff 4d e4             	decl   -0x1c(%ebp)
  800bae:	89 f0                	mov    %esi,%eax
  800bb0:	8d 70 01             	lea    0x1(%eax),%esi
  800bb3:	8a 00                	mov    (%eax),%al
  800bb5:	0f be d8             	movsbl %al,%ebx
  800bb8:	85 db                	test   %ebx,%ebx
  800bba:	74 24                	je     800be0 <vprintfmt+0x24b>
  800bbc:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800bc0:	78 b8                	js     800b7a <vprintfmt+0x1e5>
  800bc2:	ff 4d e0             	decl   -0x20(%ebp)
  800bc5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800bc9:	79 af                	jns    800b7a <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800bcb:	eb 13                	jmp    800be0 <vprintfmt+0x24b>
				putch(' ', putdat);
  800bcd:	83 ec 08             	sub    $0x8,%esp
  800bd0:	ff 75 0c             	pushl  0xc(%ebp)
  800bd3:	6a 20                	push   $0x20
  800bd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd8:	ff d0                	call   *%eax
  800bda:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800bdd:	ff 4d e4             	decl   -0x1c(%ebp)
  800be0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800be4:	7f e7                	jg     800bcd <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800be6:	e9 78 01 00 00       	jmp    800d63 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800beb:	83 ec 08             	sub    $0x8,%esp
  800bee:	ff 75 e8             	pushl  -0x18(%ebp)
  800bf1:	8d 45 14             	lea    0x14(%ebp),%eax
  800bf4:	50                   	push   %eax
  800bf5:	e8 3c fd ff ff       	call   800936 <getint>
  800bfa:	83 c4 10             	add    $0x10,%esp
  800bfd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c00:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800c03:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c06:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c09:	85 d2                	test   %edx,%edx
  800c0b:	79 23                	jns    800c30 <vprintfmt+0x29b>
				putch('-', putdat);
  800c0d:	83 ec 08             	sub    $0x8,%esp
  800c10:	ff 75 0c             	pushl  0xc(%ebp)
  800c13:	6a 2d                	push   $0x2d
  800c15:	8b 45 08             	mov    0x8(%ebp),%eax
  800c18:	ff d0                	call   *%eax
  800c1a:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800c1d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c20:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c23:	f7 d8                	neg    %eax
  800c25:	83 d2 00             	adc    $0x0,%edx
  800c28:	f7 da                	neg    %edx
  800c2a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c2d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800c30:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c37:	e9 bc 00 00 00       	jmp    800cf8 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800c3c:	83 ec 08             	sub    $0x8,%esp
  800c3f:	ff 75 e8             	pushl  -0x18(%ebp)
  800c42:	8d 45 14             	lea    0x14(%ebp),%eax
  800c45:	50                   	push   %eax
  800c46:	e8 84 fc ff ff       	call   8008cf <getuint>
  800c4b:	83 c4 10             	add    $0x10,%esp
  800c4e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c51:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800c54:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c5b:	e9 98 00 00 00       	jmp    800cf8 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800c60:	83 ec 08             	sub    $0x8,%esp
  800c63:	ff 75 0c             	pushl  0xc(%ebp)
  800c66:	6a 58                	push   $0x58
  800c68:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6b:	ff d0                	call   *%eax
  800c6d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c70:	83 ec 08             	sub    $0x8,%esp
  800c73:	ff 75 0c             	pushl  0xc(%ebp)
  800c76:	6a 58                	push   $0x58
  800c78:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7b:	ff d0                	call   *%eax
  800c7d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c80:	83 ec 08             	sub    $0x8,%esp
  800c83:	ff 75 0c             	pushl  0xc(%ebp)
  800c86:	6a 58                	push   $0x58
  800c88:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8b:	ff d0                	call   *%eax
  800c8d:	83 c4 10             	add    $0x10,%esp
			break;
  800c90:	e9 ce 00 00 00       	jmp    800d63 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800c95:	83 ec 08             	sub    $0x8,%esp
  800c98:	ff 75 0c             	pushl  0xc(%ebp)
  800c9b:	6a 30                	push   $0x30
  800c9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca0:	ff d0                	call   *%eax
  800ca2:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800ca5:	83 ec 08             	sub    $0x8,%esp
  800ca8:	ff 75 0c             	pushl  0xc(%ebp)
  800cab:	6a 78                	push   $0x78
  800cad:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb0:	ff d0                	call   *%eax
  800cb2:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800cb5:	8b 45 14             	mov    0x14(%ebp),%eax
  800cb8:	83 c0 04             	add    $0x4,%eax
  800cbb:	89 45 14             	mov    %eax,0x14(%ebp)
  800cbe:	8b 45 14             	mov    0x14(%ebp),%eax
  800cc1:	83 e8 04             	sub    $0x4,%eax
  800cc4:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800cc6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cc9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800cd0:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800cd7:	eb 1f                	jmp    800cf8 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800cd9:	83 ec 08             	sub    $0x8,%esp
  800cdc:	ff 75 e8             	pushl  -0x18(%ebp)
  800cdf:	8d 45 14             	lea    0x14(%ebp),%eax
  800ce2:	50                   	push   %eax
  800ce3:	e8 e7 fb ff ff       	call   8008cf <getuint>
  800ce8:	83 c4 10             	add    $0x10,%esp
  800ceb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cee:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800cf1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800cf8:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800cfc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800cff:	83 ec 04             	sub    $0x4,%esp
  800d02:	52                   	push   %edx
  800d03:	ff 75 e4             	pushl  -0x1c(%ebp)
  800d06:	50                   	push   %eax
  800d07:	ff 75 f4             	pushl  -0xc(%ebp)
  800d0a:	ff 75 f0             	pushl  -0x10(%ebp)
  800d0d:	ff 75 0c             	pushl  0xc(%ebp)
  800d10:	ff 75 08             	pushl  0x8(%ebp)
  800d13:	e8 00 fb ff ff       	call   800818 <printnum>
  800d18:	83 c4 20             	add    $0x20,%esp
			break;
  800d1b:	eb 46                	jmp    800d63 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800d1d:	83 ec 08             	sub    $0x8,%esp
  800d20:	ff 75 0c             	pushl  0xc(%ebp)
  800d23:	53                   	push   %ebx
  800d24:	8b 45 08             	mov    0x8(%ebp),%eax
  800d27:	ff d0                	call   *%eax
  800d29:	83 c4 10             	add    $0x10,%esp
			break;
  800d2c:	eb 35                	jmp    800d63 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800d2e:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  800d35:	eb 2c                	jmp    800d63 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800d37:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  800d3e:	eb 23                	jmp    800d63 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800d40:	83 ec 08             	sub    $0x8,%esp
  800d43:	ff 75 0c             	pushl  0xc(%ebp)
  800d46:	6a 25                	push   $0x25
  800d48:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4b:	ff d0                	call   *%eax
  800d4d:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800d50:	ff 4d 10             	decl   0x10(%ebp)
  800d53:	eb 03                	jmp    800d58 <vprintfmt+0x3c3>
  800d55:	ff 4d 10             	decl   0x10(%ebp)
  800d58:	8b 45 10             	mov    0x10(%ebp),%eax
  800d5b:	48                   	dec    %eax
  800d5c:	8a 00                	mov    (%eax),%al
  800d5e:	3c 25                	cmp    $0x25,%al
  800d60:	75 f3                	jne    800d55 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800d62:	90                   	nop
		}
	}
  800d63:	e9 35 fc ff ff       	jmp    80099d <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800d68:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800d69:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800d6c:	5b                   	pop    %ebx
  800d6d:	5e                   	pop    %esi
  800d6e:	5d                   	pop    %ebp
  800d6f:	c3                   	ret    

00800d70 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800d70:	55                   	push   %ebp
  800d71:	89 e5                	mov    %esp,%ebp
  800d73:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800d76:	8d 45 10             	lea    0x10(%ebp),%eax
  800d79:	83 c0 04             	add    $0x4,%eax
  800d7c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800d7f:	8b 45 10             	mov    0x10(%ebp),%eax
  800d82:	ff 75 f4             	pushl  -0xc(%ebp)
  800d85:	50                   	push   %eax
  800d86:	ff 75 0c             	pushl  0xc(%ebp)
  800d89:	ff 75 08             	pushl  0x8(%ebp)
  800d8c:	e8 04 fc ff ff       	call   800995 <vprintfmt>
  800d91:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800d94:	90                   	nop
  800d95:	c9                   	leave  
  800d96:	c3                   	ret    

00800d97 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800d97:	55                   	push   %ebp
  800d98:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800d9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d9d:	8b 40 08             	mov    0x8(%eax),%eax
  800da0:	8d 50 01             	lea    0x1(%eax),%edx
  800da3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da6:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800da9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dac:	8b 10                	mov    (%eax),%edx
  800dae:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db1:	8b 40 04             	mov    0x4(%eax),%eax
  800db4:	39 c2                	cmp    %eax,%edx
  800db6:	73 12                	jae    800dca <sprintputch+0x33>
		*b->buf++ = ch;
  800db8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dbb:	8b 00                	mov    (%eax),%eax
  800dbd:	8d 48 01             	lea    0x1(%eax),%ecx
  800dc0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dc3:	89 0a                	mov    %ecx,(%edx)
  800dc5:	8b 55 08             	mov    0x8(%ebp),%edx
  800dc8:	88 10                	mov    %dl,(%eax)
}
  800dca:	90                   	nop
  800dcb:	5d                   	pop    %ebp
  800dcc:	c3                   	ret    

00800dcd <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800dcd:	55                   	push   %ebp
  800dce:	89 e5                	mov    %esp,%ebp
  800dd0:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800dd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800dd9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ddc:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ddf:	8b 45 08             	mov    0x8(%ebp),%eax
  800de2:	01 d0                	add    %edx,%eax
  800de4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800de7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800dee:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800df2:	74 06                	je     800dfa <vsnprintf+0x2d>
  800df4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800df8:	7f 07                	jg     800e01 <vsnprintf+0x34>
		return -E_INVAL;
  800dfa:	b8 03 00 00 00       	mov    $0x3,%eax
  800dff:	eb 20                	jmp    800e21 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800e01:	ff 75 14             	pushl  0x14(%ebp)
  800e04:	ff 75 10             	pushl  0x10(%ebp)
  800e07:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800e0a:	50                   	push   %eax
  800e0b:	68 97 0d 80 00       	push   $0x800d97
  800e10:	e8 80 fb ff ff       	call   800995 <vprintfmt>
  800e15:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800e18:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e1b:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800e1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800e21:	c9                   	leave  
  800e22:	c3                   	ret    

00800e23 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800e23:	55                   	push   %ebp
  800e24:	89 e5                	mov    %esp,%ebp
  800e26:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800e29:	8d 45 10             	lea    0x10(%ebp),%eax
  800e2c:	83 c0 04             	add    $0x4,%eax
  800e2f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800e32:	8b 45 10             	mov    0x10(%ebp),%eax
  800e35:	ff 75 f4             	pushl  -0xc(%ebp)
  800e38:	50                   	push   %eax
  800e39:	ff 75 0c             	pushl  0xc(%ebp)
  800e3c:	ff 75 08             	pushl  0x8(%ebp)
  800e3f:	e8 89 ff ff ff       	call   800dcd <vsnprintf>
  800e44:	83 c4 10             	add    $0x10,%esp
  800e47:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800e4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800e4d:	c9                   	leave  
  800e4e:	c3                   	ret    

00800e4f <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800e4f:	55                   	push   %ebp
  800e50:	89 e5                	mov    %esp,%ebp
  800e52:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800e55:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e5c:	eb 06                	jmp    800e64 <strlen+0x15>
		n++;
  800e5e:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800e61:	ff 45 08             	incl   0x8(%ebp)
  800e64:	8b 45 08             	mov    0x8(%ebp),%eax
  800e67:	8a 00                	mov    (%eax),%al
  800e69:	84 c0                	test   %al,%al
  800e6b:	75 f1                	jne    800e5e <strlen+0xf>
		n++;
	return n;
  800e6d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e70:	c9                   	leave  
  800e71:	c3                   	ret    

00800e72 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800e72:	55                   	push   %ebp
  800e73:	89 e5                	mov    %esp,%ebp
  800e75:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e78:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e7f:	eb 09                	jmp    800e8a <strnlen+0x18>
		n++;
  800e81:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e84:	ff 45 08             	incl   0x8(%ebp)
  800e87:	ff 4d 0c             	decl   0xc(%ebp)
  800e8a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e8e:	74 09                	je     800e99 <strnlen+0x27>
  800e90:	8b 45 08             	mov    0x8(%ebp),%eax
  800e93:	8a 00                	mov    (%eax),%al
  800e95:	84 c0                	test   %al,%al
  800e97:	75 e8                	jne    800e81 <strnlen+0xf>
		n++;
	return n;
  800e99:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e9c:	c9                   	leave  
  800e9d:	c3                   	ret    

00800e9e <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800e9e:	55                   	push   %ebp
  800e9f:	89 e5                	mov    %esp,%ebp
  800ea1:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800ea4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800eaa:	90                   	nop
  800eab:	8b 45 08             	mov    0x8(%ebp),%eax
  800eae:	8d 50 01             	lea    0x1(%eax),%edx
  800eb1:	89 55 08             	mov    %edx,0x8(%ebp)
  800eb4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800eb7:	8d 4a 01             	lea    0x1(%edx),%ecx
  800eba:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ebd:	8a 12                	mov    (%edx),%dl
  800ebf:	88 10                	mov    %dl,(%eax)
  800ec1:	8a 00                	mov    (%eax),%al
  800ec3:	84 c0                	test   %al,%al
  800ec5:	75 e4                	jne    800eab <strcpy+0xd>
		/* do nothing */;
	return ret;
  800ec7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800eca:	c9                   	leave  
  800ecb:	c3                   	ret    

00800ecc <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800ecc:	55                   	push   %ebp
  800ecd:	89 e5                	mov    %esp,%ebp
  800ecf:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800ed2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800ed8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800edf:	eb 1f                	jmp    800f00 <strncpy+0x34>
		*dst++ = *src;
  800ee1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee4:	8d 50 01             	lea    0x1(%eax),%edx
  800ee7:	89 55 08             	mov    %edx,0x8(%ebp)
  800eea:	8b 55 0c             	mov    0xc(%ebp),%edx
  800eed:	8a 12                	mov    (%edx),%dl
  800eef:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800ef1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef4:	8a 00                	mov    (%eax),%al
  800ef6:	84 c0                	test   %al,%al
  800ef8:	74 03                	je     800efd <strncpy+0x31>
			src++;
  800efa:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800efd:	ff 45 fc             	incl   -0x4(%ebp)
  800f00:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f03:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f06:	72 d9                	jb     800ee1 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800f08:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f0b:	c9                   	leave  
  800f0c:	c3                   	ret    

00800f0d <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800f0d:	55                   	push   %ebp
  800f0e:	89 e5                	mov    %esp,%ebp
  800f10:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800f13:	8b 45 08             	mov    0x8(%ebp),%eax
  800f16:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800f19:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f1d:	74 30                	je     800f4f <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800f1f:	eb 16                	jmp    800f37 <strlcpy+0x2a>
			*dst++ = *src++;
  800f21:	8b 45 08             	mov    0x8(%ebp),%eax
  800f24:	8d 50 01             	lea    0x1(%eax),%edx
  800f27:	89 55 08             	mov    %edx,0x8(%ebp)
  800f2a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f2d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f30:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f33:	8a 12                	mov    (%edx),%dl
  800f35:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800f37:	ff 4d 10             	decl   0x10(%ebp)
  800f3a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f3e:	74 09                	je     800f49 <strlcpy+0x3c>
  800f40:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f43:	8a 00                	mov    (%eax),%al
  800f45:	84 c0                	test   %al,%al
  800f47:	75 d8                	jne    800f21 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800f49:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4c:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800f4f:	8b 55 08             	mov    0x8(%ebp),%edx
  800f52:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f55:	29 c2                	sub    %eax,%edx
  800f57:	89 d0                	mov    %edx,%eax
}
  800f59:	c9                   	leave  
  800f5a:	c3                   	ret    

00800f5b <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800f5b:	55                   	push   %ebp
  800f5c:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800f5e:	eb 06                	jmp    800f66 <strcmp+0xb>
		p++, q++;
  800f60:	ff 45 08             	incl   0x8(%ebp)
  800f63:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800f66:	8b 45 08             	mov    0x8(%ebp),%eax
  800f69:	8a 00                	mov    (%eax),%al
  800f6b:	84 c0                	test   %al,%al
  800f6d:	74 0e                	je     800f7d <strcmp+0x22>
  800f6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f72:	8a 10                	mov    (%eax),%dl
  800f74:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f77:	8a 00                	mov    (%eax),%al
  800f79:	38 c2                	cmp    %al,%dl
  800f7b:	74 e3                	je     800f60 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800f7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f80:	8a 00                	mov    (%eax),%al
  800f82:	0f b6 d0             	movzbl %al,%edx
  800f85:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f88:	8a 00                	mov    (%eax),%al
  800f8a:	0f b6 c0             	movzbl %al,%eax
  800f8d:	29 c2                	sub    %eax,%edx
  800f8f:	89 d0                	mov    %edx,%eax
}
  800f91:	5d                   	pop    %ebp
  800f92:	c3                   	ret    

00800f93 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800f93:	55                   	push   %ebp
  800f94:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800f96:	eb 09                	jmp    800fa1 <strncmp+0xe>
		n--, p++, q++;
  800f98:	ff 4d 10             	decl   0x10(%ebp)
  800f9b:	ff 45 08             	incl   0x8(%ebp)
  800f9e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800fa1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fa5:	74 17                	je     800fbe <strncmp+0x2b>
  800fa7:	8b 45 08             	mov    0x8(%ebp),%eax
  800faa:	8a 00                	mov    (%eax),%al
  800fac:	84 c0                	test   %al,%al
  800fae:	74 0e                	je     800fbe <strncmp+0x2b>
  800fb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb3:	8a 10                	mov    (%eax),%dl
  800fb5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb8:	8a 00                	mov    (%eax),%al
  800fba:	38 c2                	cmp    %al,%dl
  800fbc:	74 da                	je     800f98 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800fbe:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fc2:	75 07                	jne    800fcb <strncmp+0x38>
		return 0;
  800fc4:	b8 00 00 00 00       	mov    $0x0,%eax
  800fc9:	eb 14                	jmp    800fdf <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800fcb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fce:	8a 00                	mov    (%eax),%al
  800fd0:	0f b6 d0             	movzbl %al,%edx
  800fd3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd6:	8a 00                	mov    (%eax),%al
  800fd8:	0f b6 c0             	movzbl %al,%eax
  800fdb:	29 c2                	sub    %eax,%edx
  800fdd:	89 d0                	mov    %edx,%eax
}
  800fdf:	5d                   	pop    %ebp
  800fe0:	c3                   	ret    

00800fe1 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800fe1:	55                   	push   %ebp
  800fe2:	89 e5                	mov    %esp,%ebp
  800fe4:	83 ec 04             	sub    $0x4,%esp
  800fe7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fea:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800fed:	eb 12                	jmp    801001 <strchr+0x20>
		if (*s == c)
  800fef:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff2:	8a 00                	mov    (%eax),%al
  800ff4:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ff7:	75 05                	jne    800ffe <strchr+0x1d>
			return (char *) s;
  800ff9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffc:	eb 11                	jmp    80100f <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ffe:	ff 45 08             	incl   0x8(%ebp)
  801001:	8b 45 08             	mov    0x8(%ebp),%eax
  801004:	8a 00                	mov    (%eax),%al
  801006:	84 c0                	test   %al,%al
  801008:	75 e5                	jne    800fef <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80100a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80100f:	c9                   	leave  
  801010:	c3                   	ret    

00801011 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801011:	55                   	push   %ebp
  801012:	89 e5                	mov    %esp,%ebp
  801014:	83 ec 04             	sub    $0x4,%esp
  801017:	8b 45 0c             	mov    0xc(%ebp),%eax
  80101a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80101d:	eb 0d                	jmp    80102c <strfind+0x1b>
		if (*s == c)
  80101f:	8b 45 08             	mov    0x8(%ebp),%eax
  801022:	8a 00                	mov    (%eax),%al
  801024:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801027:	74 0e                	je     801037 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801029:	ff 45 08             	incl   0x8(%ebp)
  80102c:	8b 45 08             	mov    0x8(%ebp),%eax
  80102f:	8a 00                	mov    (%eax),%al
  801031:	84 c0                	test   %al,%al
  801033:	75 ea                	jne    80101f <strfind+0xe>
  801035:	eb 01                	jmp    801038 <strfind+0x27>
		if (*s == c)
			break;
  801037:	90                   	nop
	return (char *) s;
  801038:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80103b:	c9                   	leave  
  80103c:	c3                   	ret    

0080103d <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  80103d:	55                   	push   %ebp
  80103e:	89 e5                	mov    %esp,%ebp
  801040:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  801043:	8b 45 08             	mov    0x8(%ebp),%eax
  801046:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  801049:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80104d:	76 63                	jbe    8010b2 <memset+0x75>
		uint64 data_block = c;
  80104f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801052:	99                   	cltd   
  801053:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801056:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  801059:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80105c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80105f:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  801063:	c1 e0 08             	shl    $0x8,%eax
  801066:	09 45 f0             	or     %eax,-0x10(%ebp)
  801069:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  80106c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80106f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801072:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  801076:	c1 e0 10             	shl    $0x10,%eax
  801079:	09 45 f0             	or     %eax,-0x10(%ebp)
  80107c:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  80107f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801082:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801085:	89 c2                	mov    %eax,%edx
  801087:	b8 00 00 00 00       	mov    $0x0,%eax
  80108c:	09 45 f0             	or     %eax,-0x10(%ebp)
  80108f:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  801092:	eb 18                	jmp    8010ac <memset+0x6f>
			*p64++ = data_block, n -= 8;
  801094:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801097:	8d 41 08             	lea    0x8(%ecx),%eax
  80109a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  80109d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010a0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010a3:	89 01                	mov    %eax,(%ecx)
  8010a5:	89 51 04             	mov    %edx,0x4(%ecx)
  8010a8:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  8010ac:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8010b0:	77 e2                	ja     801094 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  8010b2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010b6:	74 23                	je     8010db <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  8010b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010bb:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  8010be:	eb 0e                	jmp    8010ce <memset+0x91>
			*p8++ = (uint8)c;
  8010c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010c3:	8d 50 01             	lea    0x1(%eax),%edx
  8010c6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010c9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010cc:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  8010ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d1:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010d4:	89 55 10             	mov    %edx,0x10(%ebp)
  8010d7:	85 c0                	test   %eax,%eax
  8010d9:	75 e5                	jne    8010c0 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  8010db:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010de:	c9                   	leave  
  8010df:	c3                   	ret    

008010e0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8010e0:	55                   	push   %ebp
  8010e1:	89 e5                	mov    %esp,%ebp
  8010e3:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  8010e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  8010ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ef:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  8010f2:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8010f6:	76 24                	jbe    80111c <memcpy+0x3c>
		while(n >= 8){
  8010f8:	eb 1c                	jmp    801116 <memcpy+0x36>
			*d64 = *s64;
  8010fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010fd:	8b 50 04             	mov    0x4(%eax),%edx
  801100:	8b 00                	mov    (%eax),%eax
  801102:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801105:	89 01                	mov    %eax,(%ecx)
  801107:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  80110a:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  80110e:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  801112:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  801116:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80111a:	77 de                	ja     8010fa <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  80111c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801120:	74 31                	je     801153 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  801122:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801125:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  801128:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80112b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  80112e:	eb 16                	jmp    801146 <memcpy+0x66>
			*d8++ = *s8++;
  801130:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801133:	8d 50 01             	lea    0x1(%eax),%edx
  801136:	89 55 f0             	mov    %edx,-0x10(%ebp)
  801139:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80113c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80113f:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  801142:	8a 12                	mov    (%edx),%dl
  801144:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  801146:	8b 45 10             	mov    0x10(%ebp),%eax
  801149:	8d 50 ff             	lea    -0x1(%eax),%edx
  80114c:	89 55 10             	mov    %edx,0x10(%ebp)
  80114f:	85 c0                	test   %eax,%eax
  801151:	75 dd                	jne    801130 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  801153:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801156:	c9                   	leave  
  801157:	c3                   	ret    

00801158 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801158:	55                   	push   %ebp
  801159:	89 e5                	mov    %esp,%ebp
  80115b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80115e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801161:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801164:	8b 45 08             	mov    0x8(%ebp),%eax
  801167:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80116a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80116d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801170:	73 50                	jae    8011c2 <memmove+0x6a>
  801172:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801175:	8b 45 10             	mov    0x10(%ebp),%eax
  801178:	01 d0                	add    %edx,%eax
  80117a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80117d:	76 43                	jbe    8011c2 <memmove+0x6a>
		s += n;
  80117f:	8b 45 10             	mov    0x10(%ebp),%eax
  801182:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801185:	8b 45 10             	mov    0x10(%ebp),%eax
  801188:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80118b:	eb 10                	jmp    80119d <memmove+0x45>
			*--d = *--s;
  80118d:	ff 4d f8             	decl   -0x8(%ebp)
  801190:	ff 4d fc             	decl   -0x4(%ebp)
  801193:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801196:	8a 10                	mov    (%eax),%dl
  801198:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80119b:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80119d:	8b 45 10             	mov    0x10(%ebp),%eax
  8011a0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011a3:	89 55 10             	mov    %edx,0x10(%ebp)
  8011a6:	85 c0                	test   %eax,%eax
  8011a8:	75 e3                	jne    80118d <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8011aa:	eb 23                	jmp    8011cf <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8011ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011af:	8d 50 01             	lea    0x1(%eax),%edx
  8011b2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8011b5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011b8:	8d 4a 01             	lea    0x1(%edx),%ecx
  8011bb:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8011be:	8a 12                	mov    (%edx),%dl
  8011c0:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8011c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c5:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011c8:	89 55 10             	mov    %edx,0x10(%ebp)
  8011cb:	85 c0                	test   %eax,%eax
  8011cd:	75 dd                	jne    8011ac <memmove+0x54>
			*d++ = *s++;

	return dst;
  8011cf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011d2:	c9                   	leave  
  8011d3:	c3                   	ret    

008011d4 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8011d4:	55                   	push   %ebp
  8011d5:	89 e5                	mov    %esp,%ebp
  8011d7:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8011da:	8b 45 08             	mov    0x8(%ebp),%eax
  8011dd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8011e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011e3:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8011e6:	eb 2a                	jmp    801212 <memcmp+0x3e>
		if (*s1 != *s2)
  8011e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011eb:	8a 10                	mov    (%eax),%dl
  8011ed:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011f0:	8a 00                	mov    (%eax),%al
  8011f2:	38 c2                	cmp    %al,%dl
  8011f4:	74 16                	je     80120c <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8011f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011f9:	8a 00                	mov    (%eax),%al
  8011fb:	0f b6 d0             	movzbl %al,%edx
  8011fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801201:	8a 00                	mov    (%eax),%al
  801203:	0f b6 c0             	movzbl %al,%eax
  801206:	29 c2                	sub    %eax,%edx
  801208:	89 d0                	mov    %edx,%eax
  80120a:	eb 18                	jmp    801224 <memcmp+0x50>
		s1++, s2++;
  80120c:	ff 45 fc             	incl   -0x4(%ebp)
  80120f:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801212:	8b 45 10             	mov    0x10(%ebp),%eax
  801215:	8d 50 ff             	lea    -0x1(%eax),%edx
  801218:	89 55 10             	mov    %edx,0x10(%ebp)
  80121b:	85 c0                	test   %eax,%eax
  80121d:	75 c9                	jne    8011e8 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80121f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801224:	c9                   	leave  
  801225:	c3                   	ret    

00801226 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801226:	55                   	push   %ebp
  801227:	89 e5                	mov    %esp,%ebp
  801229:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80122c:	8b 55 08             	mov    0x8(%ebp),%edx
  80122f:	8b 45 10             	mov    0x10(%ebp),%eax
  801232:	01 d0                	add    %edx,%eax
  801234:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801237:	eb 15                	jmp    80124e <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801239:	8b 45 08             	mov    0x8(%ebp),%eax
  80123c:	8a 00                	mov    (%eax),%al
  80123e:	0f b6 d0             	movzbl %al,%edx
  801241:	8b 45 0c             	mov    0xc(%ebp),%eax
  801244:	0f b6 c0             	movzbl %al,%eax
  801247:	39 c2                	cmp    %eax,%edx
  801249:	74 0d                	je     801258 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80124b:	ff 45 08             	incl   0x8(%ebp)
  80124e:	8b 45 08             	mov    0x8(%ebp),%eax
  801251:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801254:	72 e3                	jb     801239 <memfind+0x13>
  801256:	eb 01                	jmp    801259 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801258:	90                   	nop
	return (void *) s;
  801259:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80125c:	c9                   	leave  
  80125d:	c3                   	ret    

0080125e <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80125e:	55                   	push   %ebp
  80125f:	89 e5                	mov    %esp,%ebp
  801261:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801264:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80126b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801272:	eb 03                	jmp    801277 <strtol+0x19>
		s++;
  801274:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801277:	8b 45 08             	mov    0x8(%ebp),%eax
  80127a:	8a 00                	mov    (%eax),%al
  80127c:	3c 20                	cmp    $0x20,%al
  80127e:	74 f4                	je     801274 <strtol+0x16>
  801280:	8b 45 08             	mov    0x8(%ebp),%eax
  801283:	8a 00                	mov    (%eax),%al
  801285:	3c 09                	cmp    $0x9,%al
  801287:	74 eb                	je     801274 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801289:	8b 45 08             	mov    0x8(%ebp),%eax
  80128c:	8a 00                	mov    (%eax),%al
  80128e:	3c 2b                	cmp    $0x2b,%al
  801290:	75 05                	jne    801297 <strtol+0x39>
		s++;
  801292:	ff 45 08             	incl   0x8(%ebp)
  801295:	eb 13                	jmp    8012aa <strtol+0x4c>
	else if (*s == '-')
  801297:	8b 45 08             	mov    0x8(%ebp),%eax
  80129a:	8a 00                	mov    (%eax),%al
  80129c:	3c 2d                	cmp    $0x2d,%al
  80129e:	75 0a                	jne    8012aa <strtol+0x4c>
		s++, neg = 1;
  8012a0:	ff 45 08             	incl   0x8(%ebp)
  8012a3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8012aa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012ae:	74 06                	je     8012b6 <strtol+0x58>
  8012b0:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8012b4:	75 20                	jne    8012d6 <strtol+0x78>
  8012b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b9:	8a 00                	mov    (%eax),%al
  8012bb:	3c 30                	cmp    $0x30,%al
  8012bd:	75 17                	jne    8012d6 <strtol+0x78>
  8012bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c2:	40                   	inc    %eax
  8012c3:	8a 00                	mov    (%eax),%al
  8012c5:	3c 78                	cmp    $0x78,%al
  8012c7:	75 0d                	jne    8012d6 <strtol+0x78>
		s += 2, base = 16;
  8012c9:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8012cd:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8012d4:	eb 28                	jmp    8012fe <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8012d6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012da:	75 15                	jne    8012f1 <strtol+0x93>
  8012dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012df:	8a 00                	mov    (%eax),%al
  8012e1:	3c 30                	cmp    $0x30,%al
  8012e3:	75 0c                	jne    8012f1 <strtol+0x93>
		s++, base = 8;
  8012e5:	ff 45 08             	incl   0x8(%ebp)
  8012e8:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8012ef:	eb 0d                	jmp    8012fe <strtol+0xa0>
	else if (base == 0)
  8012f1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012f5:	75 07                	jne    8012fe <strtol+0xa0>
		base = 10;
  8012f7:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8012fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801301:	8a 00                	mov    (%eax),%al
  801303:	3c 2f                	cmp    $0x2f,%al
  801305:	7e 19                	jle    801320 <strtol+0xc2>
  801307:	8b 45 08             	mov    0x8(%ebp),%eax
  80130a:	8a 00                	mov    (%eax),%al
  80130c:	3c 39                	cmp    $0x39,%al
  80130e:	7f 10                	jg     801320 <strtol+0xc2>
			dig = *s - '0';
  801310:	8b 45 08             	mov    0x8(%ebp),%eax
  801313:	8a 00                	mov    (%eax),%al
  801315:	0f be c0             	movsbl %al,%eax
  801318:	83 e8 30             	sub    $0x30,%eax
  80131b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80131e:	eb 42                	jmp    801362 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801320:	8b 45 08             	mov    0x8(%ebp),%eax
  801323:	8a 00                	mov    (%eax),%al
  801325:	3c 60                	cmp    $0x60,%al
  801327:	7e 19                	jle    801342 <strtol+0xe4>
  801329:	8b 45 08             	mov    0x8(%ebp),%eax
  80132c:	8a 00                	mov    (%eax),%al
  80132e:	3c 7a                	cmp    $0x7a,%al
  801330:	7f 10                	jg     801342 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801332:	8b 45 08             	mov    0x8(%ebp),%eax
  801335:	8a 00                	mov    (%eax),%al
  801337:	0f be c0             	movsbl %al,%eax
  80133a:	83 e8 57             	sub    $0x57,%eax
  80133d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801340:	eb 20                	jmp    801362 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801342:	8b 45 08             	mov    0x8(%ebp),%eax
  801345:	8a 00                	mov    (%eax),%al
  801347:	3c 40                	cmp    $0x40,%al
  801349:	7e 39                	jle    801384 <strtol+0x126>
  80134b:	8b 45 08             	mov    0x8(%ebp),%eax
  80134e:	8a 00                	mov    (%eax),%al
  801350:	3c 5a                	cmp    $0x5a,%al
  801352:	7f 30                	jg     801384 <strtol+0x126>
			dig = *s - 'A' + 10;
  801354:	8b 45 08             	mov    0x8(%ebp),%eax
  801357:	8a 00                	mov    (%eax),%al
  801359:	0f be c0             	movsbl %al,%eax
  80135c:	83 e8 37             	sub    $0x37,%eax
  80135f:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801362:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801365:	3b 45 10             	cmp    0x10(%ebp),%eax
  801368:	7d 19                	jge    801383 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80136a:	ff 45 08             	incl   0x8(%ebp)
  80136d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801370:	0f af 45 10          	imul   0x10(%ebp),%eax
  801374:	89 c2                	mov    %eax,%edx
  801376:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801379:	01 d0                	add    %edx,%eax
  80137b:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80137e:	e9 7b ff ff ff       	jmp    8012fe <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801383:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801384:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801388:	74 08                	je     801392 <strtol+0x134>
		*endptr = (char *) s;
  80138a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80138d:	8b 55 08             	mov    0x8(%ebp),%edx
  801390:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801392:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801396:	74 07                	je     80139f <strtol+0x141>
  801398:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80139b:	f7 d8                	neg    %eax
  80139d:	eb 03                	jmp    8013a2 <strtol+0x144>
  80139f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013a2:	c9                   	leave  
  8013a3:	c3                   	ret    

008013a4 <ltostr>:

void
ltostr(long value, char *str)
{
  8013a4:	55                   	push   %ebp
  8013a5:	89 e5                	mov    %esp,%ebp
  8013a7:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8013aa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8013b1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8013b8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8013bc:	79 13                	jns    8013d1 <ltostr+0x2d>
	{
		neg = 1;
  8013be:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8013c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c8:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8013cb:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8013ce:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8013d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d4:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8013d9:	99                   	cltd   
  8013da:	f7 f9                	idiv   %ecx
  8013dc:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8013df:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013e2:	8d 50 01             	lea    0x1(%eax),%edx
  8013e5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8013e8:	89 c2                	mov    %eax,%edx
  8013ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ed:	01 d0                	add    %edx,%eax
  8013ef:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8013f2:	83 c2 30             	add    $0x30,%edx
  8013f5:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8013f7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8013fa:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8013ff:	f7 e9                	imul   %ecx
  801401:	c1 fa 02             	sar    $0x2,%edx
  801404:	89 c8                	mov    %ecx,%eax
  801406:	c1 f8 1f             	sar    $0x1f,%eax
  801409:	29 c2                	sub    %eax,%edx
  80140b:	89 d0                	mov    %edx,%eax
  80140d:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  801410:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801414:	75 bb                	jne    8013d1 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801416:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80141d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801420:	48                   	dec    %eax
  801421:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801424:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801428:	74 3d                	je     801467 <ltostr+0xc3>
		start = 1 ;
  80142a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801431:	eb 34                	jmp    801467 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  801433:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801436:	8b 45 0c             	mov    0xc(%ebp),%eax
  801439:	01 d0                	add    %edx,%eax
  80143b:	8a 00                	mov    (%eax),%al
  80143d:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801440:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801443:	8b 45 0c             	mov    0xc(%ebp),%eax
  801446:	01 c2                	add    %eax,%edx
  801448:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80144b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80144e:	01 c8                	add    %ecx,%eax
  801450:	8a 00                	mov    (%eax),%al
  801452:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801454:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801457:	8b 45 0c             	mov    0xc(%ebp),%eax
  80145a:	01 c2                	add    %eax,%edx
  80145c:	8a 45 eb             	mov    -0x15(%ebp),%al
  80145f:	88 02                	mov    %al,(%edx)
		start++ ;
  801461:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801464:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801467:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80146a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80146d:	7c c4                	jl     801433 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80146f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801472:	8b 45 0c             	mov    0xc(%ebp),%eax
  801475:	01 d0                	add    %edx,%eax
  801477:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80147a:	90                   	nop
  80147b:	c9                   	leave  
  80147c:	c3                   	ret    

0080147d <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80147d:	55                   	push   %ebp
  80147e:	89 e5                	mov    %esp,%ebp
  801480:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801483:	ff 75 08             	pushl  0x8(%ebp)
  801486:	e8 c4 f9 ff ff       	call   800e4f <strlen>
  80148b:	83 c4 04             	add    $0x4,%esp
  80148e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801491:	ff 75 0c             	pushl  0xc(%ebp)
  801494:	e8 b6 f9 ff ff       	call   800e4f <strlen>
  801499:	83 c4 04             	add    $0x4,%esp
  80149c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80149f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8014a6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014ad:	eb 17                	jmp    8014c6 <strcconcat+0x49>
		final[s] = str1[s] ;
  8014af:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8014b5:	01 c2                	add    %eax,%edx
  8014b7:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8014ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bd:	01 c8                	add    %ecx,%eax
  8014bf:	8a 00                	mov    (%eax),%al
  8014c1:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8014c3:	ff 45 fc             	incl   -0x4(%ebp)
  8014c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014c9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8014cc:	7c e1                	jl     8014af <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8014ce:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8014d5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8014dc:	eb 1f                	jmp    8014fd <strcconcat+0x80>
		final[s++] = str2[i] ;
  8014de:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014e1:	8d 50 01             	lea    0x1(%eax),%edx
  8014e4:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8014e7:	89 c2                	mov    %eax,%edx
  8014e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8014ec:	01 c2                	add    %eax,%edx
  8014ee:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8014f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014f4:	01 c8                	add    %ecx,%eax
  8014f6:	8a 00                	mov    (%eax),%al
  8014f8:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8014fa:	ff 45 f8             	incl   -0x8(%ebp)
  8014fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801500:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801503:	7c d9                	jl     8014de <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801505:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801508:	8b 45 10             	mov    0x10(%ebp),%eax
  80150b:	01 d0                	add    %edx,%eax
  80150d:	c6 00 00             	movb   $0x0,(%eax)
}
  801510:	90                   	nop
  801511:	c9                   	leave  
  801512:	c3                   	ret    

00801513 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801513:	55                   	push   %ebp
  801514:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801516:	8b 45 14             	mov    0x14(%ebp),%eax
  801519:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80151f:	8b 45 14             	mov    0x14(%ebp),%eax
  801522:	8b 00                	mov    (%eax),%eax
  801524:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80152b:	8b 45 10             	mov    0x10(%ebp),%eax
  80152e:	01 d0                	add    %edx,%eax
  801530:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801536:	eb 0c                	jmp    801544 <strsplit+0x31>
			*string++ = 0;
  801538:	8b 45 08             	mov    0x8(%ebp),%eax
  80153b:	8d 50 01             	lea    0x1(%eax),%edx
  80153e:	89 55 08             	mov    %edx,0x8(%ebp)
  801541:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801544:	8b 45 08             	mov    0x8(%ebp),%eax
  801547:	8a 00                	mov    (%eax),%al
  801549:	84 c0                	test   %al,%al
  80154b:	74 18                	je     801565 <strsplit+0x52>
  80154d:	8b 45 08             	mov    0x8(%ebp),%eax
  801550:	8a 00                	mov    (%eax),%al
  801552:	0f be c0             	movsbl %al,%eax
  801555:	50                   	push   %eax
  801556:	ff 75 0c             	pushl  0xc(%ebp)
  801559:	e8 83 fa ff ff       	call   800fe1 <strchr>
  80155e:	83 c4 08             	add    $0x8,%esp
  801561:	85 c0                	test   %eax,%eax
  801563:	75 d3                	jne    801538 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801565:	8b 45 08             	mov    0x8(%ebp),%eax
  801568:	8a 00                	mov    (%eax),%al
  80156a:	84 c0                	test   %al,%al
  80156c:	74 5a                	je     8015c8 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80156e:	8b 45 14             	mov    0x14(%ebp),%eax
  801571:	8b 00                	mov    (%eax),%eax
  801573:	83 f8 0f             	cmp    $0xf,%eax
  801576:	75 07                	jne    80157f <strsplit+0x6c>
		{
			return 0;
  801578:	b8 00 00 00 00       	mov    $0x0,%eax
  80157d:	eb 66                	jmp    8015e5 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80157f:	8b 45 14             	mov    0x14(%ebp),%eax
  801582:	8b 00                	mov    (%eax),%eax
  801584:	8d 48 01             	lea    0x1(%eax),%ecx
  801587:	8b 55 14             	mov    0x14(%ebp),%edx
  80158a:	89 0a                	mov    %ecx,(%edx)
  80158c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801593:	8b 45 10             	mov    0x10(%ebp),%eax
  801596:	01 c2                	add    %eax,%edx
  801598:	8b 45 08             	mov    0x8(%ebp),%eax
  80159b:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80159d:	eb 03                	jmp    8015a2 <strsplit+0x8f>
			string++;
  80159f:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8015a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a5:	8a 00                	mov    (%eax),%al
  8015a7:	84 c0                	test   %al,%al
  8015a9:	74 8b                	je     801536 <strsplit+0x23>
  8015ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ae:	8a 00                	mov    (%eax),%al
  8015b0:	0f be c0             	movsbl %al,%eax
  8015b3:	50                   	push   %eax
  8015b4:	ff 75 0c             	pushl  0xc(%ebp)
  8015b7:	e8 25 fa ff ff       	call   800fe1 <strchr>
  8015bc:	83 c4 08             	add    $0x8,%esp
  8015bf:	85 c0                	test   %eax,%eax
  8015c1:	74 dc                	je     80159f <strsplit+0x8c>
			string++;
	}
  8015c3:	e9 6e ff ff ff       	jmp    801536 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8015c8:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8015c9:	8b 45 14             	mov    0x14(%ebp),%eax
  8015cc:	8b 00                	mov    (%eax),%eax
  8015ce:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8015d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8015d8:	01 d0                	add    %edx,%eax
  8015da:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8015e0:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8015e5:	c9                   	leave  
  8015e6:	c3                   	ret    

008015e7 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  8015e7:	55                   	push   %ebp
  8015e8:	89 e5                	mov    %esp,%ebp
  8015ea:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  8015ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  8015f3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015fa:	eb 4a                	jmp    801646 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  8015fc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801602:	01 c2                	add    %eax,%edx
  801604:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801607:	8b 45 0c             	mov    0xc(%ebp),%eax
  80160a:	01 c8                	add    %ecx,%eax
  80160c:	8a 00                	mov    (%eax),%al
  80160e:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801610:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801613:	8b 45 0c             	mov    0xc(%ebp),%eax
  801616:	01 d0                	add    %edx,%eax
  801618:	8a 00                	mov    (%eax),%al
  80161a:	3c 40                	cmp    $0x40,%al
  80161c:	7e 25                	jle    801643 <str2lower+0x5c>
  80161e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801621:	8b 45 0c             	mov    0xc(%ebp),%eax
  801624:	01 d0                	add    %edx,%eax
  801626:	8a 00                	mov    (%eax),%al
  801628:	3c 5a                	cmp    $0x5a,%al
  80162a:	7f 17                	jg     801643 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  80162c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80162f:	8b 45 08             	mov    0x8(%ebp),%eax
  801632:	01 d0                	add    %edx,%eax
  801634:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801637:	8b 55 08             	mov    0x8(%ebp),%edx
  80163a:	01 ca                	add    %ecx,%edx
  80163c:	8a 12                	mov    (%edx),%dl
  80163e:	83 c2 20             	add    $0x20,%edx
  801641:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801643:	ff 45 fc             	incl   -0x4(%ebp)
  801646:	ff 75 0c             	pushl  0xc(%ebp)
  801649:	e8 01 f8 ff ff       	call   800e4f <strlen>
  80164e:	83 c4 04             	add    $0x4,%esp
  801651:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801654:	7f a6                	jg     8015fc <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801656:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801659:	c9                   	leave  
  80165a:	c3                   	ret    

0080165b <uheap_init>:
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.IM#2] USER HEAP - [0] GIVEN FUNCTION
int __firstTimeFlag = 1;
void uheap_init()
{
  80165b:	55                   	push   %ebp
  80165c:	89 e5                	mov    %esp,%ebp
  80165e:	83 ec 08             	sub    $0x8,%esp
	if(__firstTimeFlag)
  801661:	a1 08 30 80 00       	mov    0x803008,%eax
  801666:	85 c0                	test   %eax,%eax
  801668:	74 2d                	je     801697 <uheap_init+0x3c>
	{
		buddy_init();
  80166a:	e8 87 06 00 00       	call   801cf6 <buddy_init>
		uheapPlaceStrategy = sys_get_uheap_strategy();
  80166f:	e8 31 05 00 00       	call   801ba5 <sys_get_uheap_strategy>
  801674:	a3 48 30 80 00       	mov    %eax,0x803048
		uheapPageAllocStart = USER_HEAP_START;
  801679:	c7 05 20 31 80 00 00 	movl   $0x80000000,0x803120
  801680:	00 00 80 
		uheapPageAllocBreak = USER_HEAP_START;
  801683:	c7 05 4c 30 80 00 00 	movl   $0x80000000,0x80304c
  80168a:	00 00 80 
		__firstTimeFlag = 0;
  80168d:	c7 05 08 30 80 00 00 	movl   $0x0,0x803008
  801694:	00 00 00 
	}
}
  801697:	90                   	nop
  801698:	c9                   	leave  
  801699:	c3                   	ret    

0080169a <create_buddy_space>:
/**************************************************/
//=================================
// [1] CREATE NEW BUDDY SPACE:
//=================================
void* create_buddy_space()
{
  80169a:	55                   	push   %ebp
  80169b:	89 e5                	mov    %esp,%ebp
  80169d:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [1] create_buddy_space
	//Your code is here
	//Comment the following line
	panic("create_buddy_space() is not implemented yet...!!");
  8016a0:	83 ec 04             	sub    $0x4,%esp
  8016a3:	68 68 28 80 00       	push   $0x802868
  8016a8:	6a 25                	push   $0x25
  8016aa:	68 99 28 80 00       	push   $0x802899
  8016af:	e8 f4 ed ff ff       	call   8004a8 <_panic>

008016b4 <delete_buddy_space>:
}
//=================================
// [2] DELETE EXISTING BUDDY SPACE:
//=================================
void  delete_buddy_space(void *va)
{
  8016b4:	55                   	push   %ebp
  8016b5:	89 e5                	mov    %esp,%ebp
  8016b7:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [2] delete_buddy_space
	//Your code is here
	//Comment the following line
	panic("delete_buddy_space() is not implemented yet...!!");
  8016ba:	83 ec 04             	sub    $0x4,%esp
  8016bd:	68 a8 28 80 00       	push   $0x8028a8
  8016c2:	6a 2f                	push   $0x2f
  8016c4:	68 99 28 80 00       	push   $0x802899
  8016c9:	e8 da ed ff ff       	call   8004a8 <_panic>

008016ce <malloc>:
//=================================
// [3] ALLOCATE SPACE IN USER HEAP:
//=================================

void* malloc(uint32 size)
{
  8016ce:	55                   	push   %ebp
  8016cf:	89 e5                	mov    %esp,%ebp
  8016d1:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  8016d4:	e8 82 ff ff ff       	call   80165b <uheap_init>
	if (size == 0) return NULL ;
  8016d9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8016dd:	75 07                	jne    8016e6 <malloc+0x18>
  8016df:	b8 00 00 00 00       	mov    $0x0,%eax
  8016e4:	eb 14                	jmp    8016fa <malloc+0x2c>
	//==============================================================
	//TODO: [PROJECT'26.IM#2] USER HEAP - [3] malloc
	//Your code is here
	//Comment the following line
	panic("malloc() is not implemented yet...!!");
  8016e6:	83 ec 04             	sub    $0x4,%esp
  8016e9:	68 dc 28 80 00       	push   $0x8028dc
  8016ee:	6a 43                	push   $0x43
  8016f0:	68 99 28 80 00       	push   $0x802899
  8016f5:	e8 ae ed ff ff       	call   8004a8 <_panic>
}
  8016fa:	c9                   	leave  
  8016fb:	c3                   	ret    

008016fc <free>:

//=================================
// [4] FREE SPACE FROM USER HEAP:
//=================================
void free(void* virtual_address)
{
  8016fc:	55                   	push   %ebp
  8016fd:	89 e5                	mov    %esp,%ebp
  8016ff:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [5] free
	//Your code is here
	//Comment the following line
	panic("free() is not implemented yet...!!");
  801702:	83 ec 04             	sub    $0x4,%esp
  801705:	68 04 29 80 00       	push   $0x802904
  80170a:	6a 4e                	push   $0x4e
  80170c:	68 99 28 80 00       	push   $0x802899
  801711:	e8 92 ed ff ff       	call   8004a8 <_panic>

00801716 <smalloc>:

//=================================
// [5] ALLOCATE SHARED VARIABLE:
//=================================
void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801716:	55                   	push   %ebp
  801717:	89 e5                	mov    %esp,%ebp
  801719:	83 ec 18             	sub    $0x18,%esp
  80171c:	8b 45 10             	mov    0x10(%ebp),%eax
  80171f:	88 45 f4             	mov    %al,-0xc(%ebp)
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801722:	e8 34 ff ff ff       	call   80165b <uheap_init>
	if (size == 0) return NULL ;
  801727:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80172b:	75 07                	jne    801734 <smalloc+0x1e>
  80172d:	b8 00 00 00 00       	mov    $0x0,%eax
  801732:	eb 14                	jmp    801748 <smalloc+0x32>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [3] smalloc
	//Your code is here
	//Comment the following line
	panic("smalloc() is not implemented yet...!!");
  801734:	83 ec 04             	sub    $0x4,%esp
  801737:	68 28 29 80 00       	push   $0x802928
  80173c:	6a 5f                	push   $0x5f
  80173e:	68 99 28 80 00       	push   $0x802899
  801743:	e8 60 ed ff ff       	call   8004a8 <_panic>
}
  801748:	c9                   	leave  
  801749:	c3                   	ret    

0080174a <sget>:

//========================================
// [6] SHARE ON ALLOCATED SHARED VARIABLE:
//========================================
void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80174a:	55                   	push   %ebp
  80174b:	89 e5                	mov    %esp,%ebp
  80174d:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801750:	e8 06 ff ff ff       	call   80165b <uheap_init>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [5] sget
	//Your code is here
	//Comment the following line
	panic("sget() is not implemented yet...!!");
  801755:	83 ec 04             	sub    $0x4,%esp
  801758:	68 50 29 80 00       	push   $0x802950
  80175d:	6a 6f                	push   $0x6f
  80175f:	68 99 28 80 00       	push   $0x802899
  801764:	e8 3f ed ff ff       	call   8004a8 <_panic>

00801769 <sfree>:
//==================================================================================//
//=================================
// FREE SHARED VARIABLE:
//=================================
void sfree(void* virtual_address)
{
  801769:	55                   	push   %ebp
  80176a:	89 e5                	mov    %esp,%ebp
  80176c:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#4] EXIT #2 - [3] Free Shared Variables (sfree)
	//Your code is here
	//Comment the following line
	panic("sfree() is not implemented yet...!!");
  80176f:	83 ec 04             	sub    $0x4,%esp
  801772:	68 74 29 80 00       	push   $0x802974
  801777:	6a 7e                	push   $0x7e
  801779:	68 99 28 80 00       	push   $0x802899
  80177e:	e8 25 ed ff ff       	call   8004a8 <_panic>

00801783 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801783:	55                   	push   %ebp
  801784:	89 e5                	mov    %esp,%ebp
  801786:	57                   	push   %edi
  801787:	56                   	push   %esi
  801788:	53                   	push   %ebx
  801789:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80178c:	8b 45 08             	mov    0x8(%ebp),%eax
  80178f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801792:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801795:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801798:	8b 7d 18             	mov    0x18(%ebp),%edi
  80179b:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80179e:	cd 30                	int    $0x30
  8017a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8017a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8017a6:	83 c4 10             	add    $0x10,%esp
  8017a9:	5b                   	pop    %ebx
  8017aa:	5e                   	pop    %esi
  8017ab:	5f                   	pop    %edi
  8017ac:	5d                   	pop    %ebp
  8017ad:	c3                   	ret    

008017ae <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  8017ae:	55                   	push   %ebp
  8017af:	89 e5                	mov    %esp,%ebp
  8017b1:	83 ec 04             	sub    $0x4,%esp
  8017b4:	8b 45 10             	mov    0x10(%ebp),%eax
  8017b7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  8017ba:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8017bd:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8017c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c4:	6a 00                	push   $0x0
  8017c6:	51                   	push   %ecx
  8017c7:	52                   	push   %edx
  8017c8:	ff 75 0c             	pushl  0xc(%ebp)
  8017cb:	50                   	push   %eax
  8017cc:	6a 00                	push   $0x0
  8017ce:	e8 b0 ff ff ff       	call   801783 <syscall>
  8017d3:	83 c4 18             	add    $0x18,%esp
}
  8017d6:	90                   	nop
  8017d7:	c9                   	leave  
  8017d8:	c3                   	ret    

008017d9 <sys_cgetc>:

int
sys_cgetc(void)
{
  8017d9:	55                   	push   %ebp
  8017da:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8017dc:	6a 00                	push   $0x0
  8017de:	6a 00                	push   $0x0
  8017e0:	6a 00                	push   $0x0
  8017e2:	6a 00                	push   $0x0
  8017e4:	6a 00                	push   $0x0
  8017e6:	6a 02                	push   $0x2
  8017e8:	e8 96 ff ff ff       	call   801783 <syscall>
  8017ed:	83 c4 18             	add    $0x18,%esp
}
  8017f0:	c9                   	leave  
  8017f1:	c3                   	ret    

008017f2 <sys_lock_cons>:

void sys_lock_cons(void)
{
  8017f2:	55                   	push   %ebp
  8017f3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  8017f5:	6a 00                	push   $0x0
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 03                	push   $0x3
  801801:	e8 7d ff ff ff       	call   801783 <syscall>
  801806:	83 c4 18             	add    $0x18,%esp
}
  801809:	90                   	nop
  80180a:	c9                   	leave  
  80180b:	c3                   	ret    

0080180c <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  80180c:	55                   	push   %ebp
  80180d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  80180f:	6a 00                	push   $0x0
  801811:	6a 00                	push   $0x0
  801813:	6a 00                	push   $0x0
  801815:	6a 00                	push   $0x0
  801817:	6a 00                	push   $0x0
  801819:	6a 04                	push   $0x4
  80181b:	e8 63 ff ff ff       	call   801783 <syscall>
  801820:	83 c4 18             	add    $0x18,%esp
}
  801823:	90                   	nop
  801824:	c9                   	leave  
  801825:	c3                   	ret    

00801826 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801826:	55                   	push   %ebp
  801827:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801829:	8b 55 0c             	mov    0xc(%ebp),%edx
  80182c:	8b 45 08             	mov    0x8(%ebp),%eax
  80182f:	6a 00                	push   $0x0
  801831:	6a 00                	push   $0x0
  801833:	6a 00                	push   $0x0
  801835:	52                   	push   %edx
  801836:	50                   	push   %eax
  801837:	6a 08                	push   $0x8
  801839:	e8 45 ff ff ff       	call   801783 <syscall>
  80183e:	83 c4 18             	add    $0x18,%esp
}
  801841:	c9                   	leave  
  801842:	c3                   	ret    

00801843 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801843:	55                   	push   %ebp
  801844:	89 e5                	mov    %esp,%ebp
  801846:	56                   	push   %esi
  801847:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801848:	8b 75 18             	mov    0x18(%ebp),%esi
  80184b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80184e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801851:	8b 55 0c             	mov    0xc(%ebp),%edx
  801854:	8b 45 08             	mov    0x8(%ebp),%eax
  801857:	56                   	push   %esi
  801858:	53                   	push   %ebx
  801859:	51                   	push   %ecx
  80185a:	52                   	push   %edx
  80185b:	50                   	push   %eax
  80185c:	6a 09                	push   $0x9
  80185e:	e8 20 ff ff ff       	call   801783 <syscall>
  801863:	83 c4 18             	add    $0x18,%esp
}
  801866:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801869:	5b                   	pop    %ebx
  80186a:	5e                   	pop    %esi
  80186b:	5d                   	pop    %ebp
  80186c:	c3                   	ret    

0080186d <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  80186d:	55                   	push   %ebp
  80186e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  801870:	6a 00                	push   $0x0
  801872:	6a 00                	push   $0x0
  801874:	6a 00                	push   $0x0
  801876:	6a 00                	push   $0x0
  801878:	ff 75 08             	pushl  0x8(%ebp)
  80187b:	6a 0a                	push   $0xa
  80187d:	e8 01 ff ff ff       	call   801783 <syscall>
  801882:	83 c4 18             	add    $0x18,%esp
}
  801885:	c9                   	leave  
  801886:	c3                   	ret    

00801887 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801887:	55                   	push   %ebp
  801888:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80188a:	6a 00                	push   $0x0
  80188c:	6a 00                	push   $0x0
  80188e:	6a 00                	push   $0x0
  801890:	ff 75 0c             	pushl  0xc(%ebp)
  801893:	ff 75 08             	pushl  0x8(%ebp)
  801896:	6a 0b                	push   $0xb
  801898:	e8 e6 fe ff ff       	call   801783 <syscall>
  80189d:	83 c4 18             	add    $0x18,%esp
}
  8018a0:	c9                   	leave  
  8018a1:	c3                   	ret    

008018a2 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8018a2:	55                   	push   %ebp
  8018a3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8018a5:	6a 00                	push   $0x0
  8018a7:	6a 00                	push   $0x0
  8018a9:	6a 00                	push   $0x0
  8018ab:	6a 00                	push   $0x0
  8018ad:	6a 00                	push   $0x0
  8018af:	6a 0c                	push   $0xc
  8018b1:	e8 cd fe ff ff       	call   801783 <syscall>
  8018b6:	83 c4 18             	add    $0x18,%esp
}
  8018b9:	c9                   	leave  
  8018ba:	c3                   	ret    

008018bb <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8018bb:	55                   	push   %ebp
  8018bc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8018be:	6a 00                	push   $0x0
  8018c0:	6a 00                	push   $0x0
  8018c2:	6a 00                	push   $0x0
  8018c4:	6a 00                	push   $0x0
  8018c6:	6a 00                	push   $0x0
  8018c8:	6a 0d                	push   $0xd
  8018ca:	e8 b4 fe ff ff       	call   801783 <syscall>
  8018cf:	83 c4 18             	add    $0x18,%esp
}
  8018d2:	c9                   	leave  
  8018d3:	c3                   	ret    

008018d4 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8018d4:	55                   	push   %ebp
  8018d5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8018d7:	6a 00                	push   $0x0
  8018d9:	6a 00                	push   $0x0
  8018db:	6a 00                	push   $0x0
  8018dd:	6a 00                	push   $0x0
  8018df:	6a 00                	push   $0x0
  8018e1:	6a 0e                	push   $0xe
  8018e3:	e8 9b fe ff ff       	call   801783 <syscall>
  8018e8:	83 c4 18             	add    $0x18,%esp
}
  8018eb:	c9                   	leave  
  8018ec:	c3                   	ret    

008018ed <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8018ed:	55                   	push   %ebp
  8018ee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8018f0:	6a 00                	push   $0x0
  8018f2:	6a 00                	push   $0x0
  8018f4:	6a 00                	push   $0x0
  8018f6:	6a 00                	push   $0x0
  8018f8:	6a 00                	push   $0x0
  8018fa:	6a 0f                	push   $0xf
  8018fc:	e8 82 fe ff ff       	call   801783 <syscall>
  801901:	83 c4 18             	add    $0x18,%esp
}
  801904:	c9                   	leave  
  801905:	c3                   	ret    

00801906 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801906:	55                   	push   %ebp
  801907:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801909:	6a 00                	push   $0x0
  80190b:	6a 00                	push   $0x0
  80190d:	6a 00                	push   $0x0
  80190f:	6a 00                	push   $0x0
  801911:	ff 75 08             	pushl  0x8(%ebp)
  801914:	6a 10                	push   $0x10
  801916:	e8 68 fe ff ff       	call   801783 <syscall>
  80191b:	83 c4 18             	add    $0x18,%esp
}
  80191e:	c9                   	leave  
  80191f:	c3                   	ret    

00801920 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801920:	55                   	push   %ebp
  801921:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801923:	6a 00                	push   $0x0
  801925:	6a 00                	push   $0x0
  801927:	6a 00                	push   $0x0
  801929:	6a 00                	push   $0x0
  80192b:	6a 00                	push   $0x0
  80192d:	6a 11                	push   $0x11
  80192f:	e8 4f fe ff ff       	call   801783 <syscall>
  801934:	83 c4 18             	add    $0x18,%esp
}
  801937:	90                   	nop
  801938:	c9                   	leave  
  801939:	c3                   	ret    

0080193a <sys_cputc>:

void
sys_cputc(const char c)
{
  80193a:	55                   	push   %ebp
  80193b:	89 e5                	mov    %esp,%ebp
  80193d:	83 ec 04             	sub    $0x4,%esp
  801940:	8b 45 08             	mov    0x8(%ebp),%eax
  801943:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801946:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80194a:	6a 00                	push   $0x0
  80194c:	6a 00                	push   $0x0
  80194e:	6a 00                	push   $0x0
  801950:	6a 00                	push   $0x0
  801952:	50                   	push   %eax
  801953:	6a 01                	push   $0x1
  801955:	e8 29 fe ff ff       	call   801783 <syscall>
  80195a:	83 c4 18             	add    $0x18,%esp
}
  80195d:	90                   	nop
  80195e:	c9                   	leave  
  80195f:	c3                   	ret    

00801960 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801960:	55                   	push   %ebp
  801961:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801963:	6a 00                	push   $0x0
  801965:	6a 00                	push   $0x0
  801967:	6a 00                	push   $0x0
  801969:	6a 00                	push   $0x0
  80196b:	6a 00                	push   $0x0
  80196d:	6a 14                	push   $0x14
  80196f:	e8 0f fe ff ff       	call   801783 <syscall>
  801974:	83 c4 18             	add    $0x18,%esp
}
  801977:	90                   	nop
  801978:	c9                   	leave  
  801979:	c3                   	ret    

0080197a <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  80197a:	55                   	push   %ebp
  80197b:	89 e5                	mov    %esp,%ebp
  80197d:	83 ec 04             	sub    $0x4,%esp
  801980:	8b 45 10             	mov    0x10(%ebp),%eax
  801983:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  801986:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801989:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80198d:	8b 45 08             	mov    0x8(%ebp),%eax
  801990:	6a 00                	push   $0x0
  801992:	51                   	push   %ecx
  801993:	52                   	push   %edx
  801994:	ff 75 0c             	pushl  0xc(%ebp)
  801997:	50                   	push   %eax
  801998:	6a 15                	push   $0x15
  80199a:	e8 e4 fd ff ff       	call   801783 <syscall>
  80199f:	83 c4 18             	add    $0x18,%esp
}
  8019a2:	c9                   	leave  
  8019a3:	c3                   	ret    

008019a4 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  8019a4:	55                   	push   %ebp
  8019a5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  8019a7:	8b 55 10             	mov    0x10(%ebp),%edx
  8019aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019ad:	6a 00                	push   $0x0
  8019af:	6a 00                	push   $0x0
  8019b1:	52                   	push   %edx
  8019b2:	50                   	push   %eax
  8019b3:	ff 75 08             	pushl  0x8(%ebp)
  8019b6:	6a 16                	push   $0x16
  8019b8:	e8 c6 fd ff ff       	call   801783 <syscall>
  8019bd:	83 c4 18             	add    $0x18,%esp
}
  8019c0:	c9                   	leave  
  8019c1:	c3                   	ret    

008019c2 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  8019c2:	55                   	push   %ebp
  8019c3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8019c5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019cb:	6a 00                	push   $0x0
  8019cd:	6a 00                	push   $0x0
  8019cf:	6a 00                	push   $0x0
  8019d1:	52                   	push   %edx
  8019d2:	50                   	push   %eax
  8019d3:	6a 17                	push   $0x17
  8019d5:	e8 a9 fd ff ff       	call   801783 <syscall>
  8019da:	83 c4 18             	add    $0x18,%esp
}
  8019dd:	c9                   	leave  
  8019de:	c3                   	ret    

008019df <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  8019df:	55                   	push   %ebp
  8019e0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8019e2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e8:	6a 00                	push   $0x0
  8019ea:	6a 00                	push   $0x0
  8019ec:	6a 00                	push   $0x0
  8019ee:	52                   	push   %edx
  8019ef:	50                   	push   %eax
  8019f0:	6a 18                	push   $0x18
  8019f2:	e8 8c fd ff ff       	call   801783 <syscall>
  8019f7:	83 c4 18             	add    $0x18,%esp
}
  8019fa:	c9                   	leave  
  8019fb:	c3                   	ret    

008019fc <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8019fc:	55                   	push   %ebp
  8019fd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8019ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801a02:	6a 00                	push   $0x0
  801a04:	ff 75 14             	pushl  0x14(%ebp)
  801a07:	ff 75 10             	pushl  0x10(%ebp)
  801a0a:	ff 75 0c             	pushl  0xc(%ebp)
  801a0d:	50                   	push   %eax
  801a0e:	6a 19                	push   $0x19
  801a10:	e8 6e fd ff ff       	call   801783 <syscall>
  801a15:	83 c4 18             	add    $0x18,%esp
}
  801a18:	c9                   	leave  
  801a19:	c3                   	ret    

00801a1a <sys_run_env>:

void sys_run_env(int32 envId)
{
  801a1a:	55                   	push   %ebp
  801a1b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801a1d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a20:	6a 00                	push   $0x0
  801a22:	6a 00                	push   $0x0
  801a24:	6a 00                	push   $0x0
  801a26:	6a 00                	push   $0x0
  801a28:	50                   	push   %eax
  801a29:	6a 1a                	push   $0x1a
  801a2b:	e8 53 fd ff ff       	call   801783 <syscall>
  801a30:	83 c4 18             	add    $0x18,%esp
}
  801a33:	90                   	nop
  801a34:	c9                   	leave  
  801a35:	c3                   	ret    

00801a36 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801a36:	55                   	push   %ebp
  801a37:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  801a39:	8b 45 08             	mov    0x8(%ebp),%eax
  801a3c:	6a 00                	push   $0x0
  801a3e:	6a 00                	push   $0x0
  801a40:	6a 00                	push   $0x0
  801a42:	6a 00                	push   $0x0
  801a44:	50                   	push   %eax
  801a45:	6a 1b                	push   $0x1b
  801a47:	e8 37 fd ff ff       	call   801783 <syscall>
  801a4c:	83 c4 18             	add    $0x18,%esp
}
  801a4f:	c9                   	leave  
  801a50:	c3                   	ret    

00801a51 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801a51:	55                   	push   %ebp
  801a52:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801a54:	6a 00                	push   $0x0
  801a56:	6a 00                	push   $0x0
  801a58:	6a 00                	push   $0x0
  801a5a:	6a 00                	push   $0x0
  801a5c:	6a 00                	push   $0x0
  801a5e:	6a 05                	push   $0x5
  801a60:	e8 1e fd ff ff       	call   801783 <syscall>
  801a65:	83 c4 18             	add    $0x18,%esp
}
  801a68:	c9                   	leave  
  801a69:	c3                   	ret    

00801a6a <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801a6a:	55                   	push   %ebp
  801a6b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801a6d:	6a 00                	push   $0x0
  801a6f:	6a 00                	push   $0x0
  801a71:	6a 00                	push   $0x0
  801a73:	6a 00                	push   $0x0
  801a75:	6a 00                	push   $0x0
  801a77:	6a 06                	push   $0x6
  801a79:	e8 05 fd ff ff       	call   801783 <syscall>
  801a7e:	83 c4 18             	add    $0x18,%esp
}
  801a81:	c9                   	leave  
  801a82:	c3                   	ret    

00801a83 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801a83:	55                   	push   %ebp
  801a84:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801a86:	6a 00                	push   $0x0
  801a88:	6a 00                	push   $0x0
  801a8a:	6a 00                	push   $0x0
  801a8c:	6a 00                	push   $0x0
  801a8e:	6a 00                	push   $0x0
  801a90:	6a 07                	push   $0x7
  801a92:	e8 ec fc ff ff       	call   801783 <syscall>
  801a97:	83 c4 18             	add    $0x18,%esp
}
  801a9a:	c9                   	leave  
  801a9b:	c3                   	ret    

00801a9c <sys_exit_env>:


void sys_exit_env(void)
{
  801a9c:	55                   	push   %ebp
  801a9d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  801a9f:	6a 00                	push   $0x0
  801aa1:	6a 00                	push   $0x0
  801aa3:	6a 00                	push   $0x0
  801aa5:	6a 00                	push   $0x0
  801aa7:	6a 00                	push   $0x0
  801aa9:	6a 1c                	push   $0x1c
  801aab:	e8 d3 fc ff ff       	call   801783 <syscall>
  801ab0:	83 c4 18             	add    $0x18,%esp
}
  801ab3:	90                   	nop
  801ab4:	c9                   	leave  
  801ab5:	c3                   	ret    

00801ab6 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801ab6:	55                   	push   %ebp
  801ab7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801ab9:	6a 00                	push   $0x0
  801abb:	6a 00                	push   $0x0
  801abd:	ff 75 10             	pushl  0x10(%ebp)
  801ac0:	ff 75 0c             	pushl  0xc(%ebp)
  801ac3:	ff 75 08             	pushl  0x8(%ebp)
  801ac6:	6a 13                	push   $0x13
  801ac8:	e8 b6 fc ff ff       	call   801783 <syscall>
  801acd:	83 c4 18             	add    $0x18,%esp
	return ;
  801ad0:	90                   	nop
}
  801ad1:	c9                   	leave  
  801ad2:	c3                   	ret    

00801ad3 <sys_rcr2>:
uint32 sys_rcr2()
{
  801ad3:	55                   	push   %ebp
  801ad4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801ad6:	6a 00                	push   $0x0
  801ad8:	6a 00                	push   $0x0
  801ada:	6a 00                	push   $0x0
  801adc:	6a 00                	push   $0x0
  801ade:	6a 00                	push   $0x0
  801ae0:	6a 1e                	push   $0x1e
  801ae2:	e8 9c fc ff ff       	call   801783 <syscall>
  801ae7:	83 c4 18             	add    $0x18,%esp
}
  801aea:	c9                   	leave  
  801aeb:	c3                   	ret    

00801aec <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801aec:	55                   	push   %ebp
  801aed:	89 e5                	mov    %esp,%ebp
  801aef:	83 ec 04             	sub    $0x4,%esp
  801af2:	8b 45 08             	mov    0x8(%ebp),%eax
  801af5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801af8:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801afc:	6a 00                	push   $0x0
  801afe:	6a 00                	push   $0x0
  801b00:	6a 00                	push   $0x0
  801b02:	6a 00                	push   $0x0
  801b04:	50                   	push   %eax
  801b05:	6a 1f                	push   $0x1f
  801b07:	e8 77 fc ff ff       	call   801783 <syscall>
  801b0c:	83 c4 18             	add    $0x18,%esp
	return ;
  801b0f:	90                   	nop
}
  801b10:	c9                   	leave  
  801b11:	c3                   	ret    

00801b12 <rsttst>:
void rsttst()
{
  801b12:	55                   	push   %ebp
  801b13:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801b15:	6a 00                	push   $0x0
  801b17:	6a 00                	push   $0x0
  801b19:	6a 00                	push   $0x0
  801b1b:	6a 00                	push   $0x0
  801b1d:	6a 00                	push   $0x0
  801b1f:	6a 21                	push   $0x21
  801b21:	e8 5d fc ff ff       	call   801783 <syscall>
  801b26:	83 c4 18             	add    $0x18,%esp
	return ;
  801b29:	90                   	nop
}
  801b2a:	c9                   	leave  
  801b2b:	c3                   	ret    

00801b2c <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801b2c:	55                   	push   %ebp
  801b2d:	89 e5                	mov    %esp,%ebp
  801b2f:	83 ec 04             	sub    $0x4,%esp
  801b32:	8b 45 14             	mov    0x14(%ebp),%eax
  801b35:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801b38:	8b 55 18             	mov    0x18(%ebp),%edx
  801b3b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801b3f:	52                   	push   %edx
  801b40:	50                   	push   %eax
  801b41:	ff 75 10             	pushl  0x10(%ebp)
  801b44:	ff 75 0c             	pushl  0xc(%ebp)
  801b47:	ff 75 08             	pushl  0x8(%ebp)
  801b4a:	6a 20                	push   $0x20
  801b4c:	e8 32 fc ff ff       	call   801783 <syscall>
  801b51:	83 c4 18             	add    $0x18,%esp
	return ;
  801b54:	90                   	nop
}
  801b55:	c9                   	leave  
  801b56:	c3                   	ret    

00801b57 <chktst>:
void chktst(uint32 n)
{
  801b57:	55                   	push   %ebp
  801b58:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801b5a:	6a 00                	push   $0x0
  801b5c:	6a 00                	push   $0x0
  801b5e:	6a 00                	push   $0x0
  801b60:	6a 00                	push   $0x0
  801b62:	ff 75 08             	pushl  0x8(%ebp)
  801b65:	6a 22                	push   $0x22
  801b67:	e8 17 fc ff ff       	call   801783 <syscall>
  801b6c:	83 c4 18             	add    $0x18,%esp
	return ;
  801b6f:	90                   	nop
}
  801b70:	c9                   	leave  
  801b71:	c3                   	ret    

00801b72 <inctst>:

void inctst()
{
  801b72:	55                   	push   %ebp
  801b73:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801b75:	6a 00                	push   $0x0
  801b77:	6a 00                	push   $0x0
  801b79:	6a 00                	push   $0x0
  801b7b:	6a 00                	push   $0x0
  801b7d:	6a 00                	push   $0x0
  801b7f:	6a 23                	push   $0x23
  801b81:	e8 fd fb ff ff       	call   801783 <syscall>
  801b86:	83 c4 18             	add    $0x18,%esp
	return ;
  801b89:	90                   	nop
}
  801b8a:	c9                   	leave  
  801b8b:	c3                   	ret    

00801b8c <gettst>:
uint32 gettst()
{
  801b8c:	55                   	push   %ebp
  801b8d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801b8f:	6a 00                	push   $0x0
  801b91:	6a 00                	push   $0x0
  801b93:	6a 00                	push   $0x0
  801b95:	6a 00                	push   $0x0
  801b97:	6a 00                	push   $0x0
  801b99:	6a 24                	push   $0x24
  801b9b:	e8 e3 fb ff ff       	call   801783 <syscall>
  801ba0:	83 c4 18             	add    $0x18,%esp
}
  801ba3:	c9                   	leave  
  801ba4:	c3                   	ret    

00801ba5 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801ba5:	55                   	push   %ebp
  801ba6:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ba8:	6a 00                	push   $0x0
  801baa:	6a 00                	push   $0x0
  801bac:	6a 00                	push   $0x0
  801bae:	6a 00                	push   $0x0
  801bb0:	6a 00                	push   $0x0
  801bb2:	6a 25                	push   $0x25
  801bb4:	e8 ca fb ff ff       	call   801783 <syscall>
  801bb9:	83 c4 18             	add    $0x18,%esp
  801bbc:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  801bc1:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801bc6:	c9                   	leave  
  801bc7:	c3                   	ret    

00801bc8 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801bc8:	55                   	push   %ebp
  801bc9:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801bcb:	8b 45 08             	mov    0x8(%ebp),%eax
  801bce:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801bd3:	6a 00                	push   $0x0
  801bd5:	6a 00                	push   $0x0
  801bd7:	6a 00                	push   $0x0
  801bd9:	6a 00                	push   $0x0
  801bdb:	ff 75 08             	pushl  0x8(%ebp)
  801bde:	6a 26                	push   $0x26
  801be0:	e8 9e fb ff ff       	call   801783 <syscall>
  801be5:	83 c4 18             	add    $0x18,%esp
	return ;
  801be8:	90                   	nop
}
  801be9:	c9                   	leave  
  801bea:	c3                   	ret    

00801beb <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801beb:	55                   	push   %ebp
  801bec:	89 e5                	mov    %esp,%ebp
  801bee:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801bef:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801bf2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bf5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bf8:	8b 45 08             	mov    0x8(%ebp),%eax
  801bfb:	6a 00                	push   $0x0
  801bfd:	53                   	push   %ebx
  801bfe:	51                   	push   %ecx
  801bff:	52                   	push   %edx
  801c00:	50                   	push   %eax
  801c01:	6a 27                	push   $0x27
  801c03:	e8 7b fb ff ff       	call   801783 <syscall>
  801c08:	83 c4 18             	add    $0x18,%esp
}
  801c0b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801c0e:	c9                   	leave  
  801c0f:	c3                   	ret    

00801c10 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801c10:	55                   	push   %ebp
  801c11:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801c13:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c16:	8b 45 08             	mov    0x8(%ebp),%eax
  801c19:	6a 00                	push   $0x0
  801c1b:	6a 00                	push   $0x0
  801c1d:	6a 00                	push   $0x0
  801c1f:	52                   	push   %edx
  801c20:	50                   	push   %eax
  801c21:	6a 28                	push   $0x28
  801c23:	e8 5b fb ff ff       	call   801783 <syscall>
  801c28:	83 c4 18             	add    $0x18,%esp
}
  801c2b:	c9                   	leave  
  801c2c:	c3                   	ret    

00801c2d <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801c2d:	55                   	push   %ebp
  801c2e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801c30:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801c33:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c36:	8b 45 08             	mov    0x8(%ebp),%eax
  801c39:	6a 00                	push   $0x0
  801c3b:	51                   	push   %ecx
  801c3c:	ff 75 10             	pushl  0x10(%ebp)
  801c3f:	52                   	push   %edx
  801c40:	50                   	push   %eax
  801c41:	6a 29                	push   $0x29
  801c43:	e8 3b fb ff ff       	call   801783 <syscall>
  801c48:	83 c4 18             	add    $0x18,%esp
}
  801c4b:	c9                   	leave  
  801c4c:	c3                   	ret    

00801c4d <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801c4d:	55                   	push   %ebp
  801c4e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801c50:	6a 00                	push   $0x0
  801c52:	6a 00                	push   $0x0
  801c54:	ff 75 10             	pushl  0x10(%ebp)
  801c57:	ff 75 0c             	pushl  0xc(%ebp)
  801c5a:	ff 75 08             	pushl  0x8(%ebp)
  801c5d:	6a 12                	push   $0x12
  801c5f:	e8 1f fb ff ff       	call   801783 <syscall>
  801c64:	83 c4 18             	add    $0x18,%esp
	return ;
  801c67:	90                   	nop
}
  801c68:	c9                   	leave  
  801c69:	c3                   	ret    

00801c6a <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801c6a:	55                   	push   %ebp
  801c6b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801c6d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c70:	8b 45 08             	mov    0x8(%ebp),%eax
  801c73:	6a 00                	push   $0x0
  801c75:	6a 00                	push   $0x0
  801c77:	6a 00                	push   $0x0
  801c79:	52                   	push   %edx
  801c7a:	50                   	push   %eax
  801c7b:	6a 2a                	push   $0x2a
  801c7d:	e8 01 fb ff ff       	call   801783 <syscall>
  801c82:	83 c4 18             	add    $0x18,%esp
	return;
  801c85:	90                   	nop
}
  801c86:	c9                   	leave  
  801c87:	c3                   	ret    

00801c88 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801c88:	55                   	push   %ebp
  801c89:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801c8b:	6a 00                	push   $0x0
  801c8d:	6a 00                	push   $0x0
  801c8f:	6a 00                	push   $0x0
  801c91:	6a 00                	push   $0x0
  801c93:	6a 00                	push   $0x0
  801c95:	6a 2b                	push   $0x2b
  801c97:	e8 e7 fa ff ff       	call   801783 <syscall>
  801c9c:	83 c4 18             	add    $0x18,%esp
}
  801c9f:	c9                   	leave  
  801ca0:	c3                   	ret    

00801ca1 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801ca1:	55                   	push   %ebp
  801ca2:	89 e5                	mov    %esp,%ebp
  801ca4:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801ca7:	83 ec 04             	sub    $0x4,%esp
  801caa:	68 98 29 80 00       	push   $0x802998
  801caf:	68 0a 01 00 00       	push   $0x10a
  801cb4:	68 a8 29 80 00       	push   $0x8029a8
  801cb9:	e8 ea e7 ff ff       	call   8004a8 <_panic>

00801cbe <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801cbe:	55                   	push   %ebp
  801cbf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801cc1:	6a 00                	push   $0x0
  801cc3:	6a 00                	push   $0x0
  801cc5:	6a 00                	push   $0x0
  801cc7:	ff 75 0c             	pushl  0xc(%ebp)
  801cca:	ff 75 08             	pushl  0x8(%ebp)
  801ccd:	6a 33                	push   $0x33
  801ccf:	e8 af fa ff ff       	call   801783 <syscall>
  801cd4:	83 c4 18             	add    $0x18,%esp
	return;
  801cd7:	90                   	nop
}
  801cd8:	c9                   	leave  
  801cd9:	c3                   	ret    

00801cda <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801cda:	55                   	push   %ebp
  801cdb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801cdd:	6a 00                	push   $0x0
  801cdf:	6a 00                	push   $0x0
  801ce1:	6a 00                	push   $0x0
  801ce3:	ff 75 0c             	pushl  0xc(%ebp)
  801ce6:	ff 75 08             	pushl  0x8(%ebp)
  801ce9:	6a 34                	push   $0x34
  801ceb:	e8 93 fa ff ff       	call   801783 <syscall>
  801cf0:	83 c4 18             	add    $0x18,%esp
	return ;
  801cf3:	90                   	nop
}
  801cf4:	c9                   	leave  
  801cf5:	c3                   	ret    

00801cf6 <buddy_init>:
//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [0] GIVEN FUNCTIONS
//==================================
// [1] INITIALIZE BUDDY FREE LISTS:
//==================================
void buddy_init()
{
  801cf6:	55                   	push   %ebp
  801cf7:	89 e5                	mov    %esp,%ebp
  801cf9:	83 ec 10             	sub    $0x10,%esp
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  801cfc:	c7 45 fc 04 00 00 00 	movl   $0x4,-0x4(%ebp)
  801d03:	eb 36                	jmp    801d3b <buddy_init+0x45>
	{
		LIST_INIT(&(freeBlockLists[l]));
  801d05:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801d08:	c1 e0 04             	shl    $0x4,%eax
  801d0b:	05 60 30 80 00       	add    $0x803060,%eax
  801d10:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  801d16:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801d19:	c1 e0 04             	shl    $0x4,%eax
  801d1c:	05 64 30 80 00       	add    $0x803064,%eax
  801d21:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  801d27:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801d2a:	c1 e0 04             	shl    $0x4,%eax
  801d2d:	05 6c 30 80 00       	add    $0x80306c,%eax
  801d32:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
//==================================
void buddy_init()
{
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  801d38:	ff 45 fc             	incl   -0x4(%ebp)
  801d3b:	83 7d fc 0b          	cmpl   $0xb,-0x4(%ebp)
  801d3f:	7e c4                	jle    801d05 <buddy_init+0xf>
	{
		LIST_INIT(&(freeBlockLists[l]));
	}
}
  801d41:	90                   	nop
  801d42:	c9                   	leave  
  801d43:	c3                   	ret    

00801d44 <PrintFreeBlockLists>:
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
  801d44:	55                   	push   %ebp
  801d45:	89 e5                	mov    %esp,%ebp
  801d47:	83 ec 18             	sub    $0x18,%esp
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  801d4a:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
  801d51:	eb 24                	jmp    801d77 <PrintFreeBlockLists+0x33>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
  801d53:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d56:	c1 e0 04             	shl    $0x4,%eax
  801d59:	05 6c 30 80 00       	add    $0x80306c,%eax
  801d5e:	8b 00                	mov    (%eax),%eax
  801d60:	83 ec 04             	sub    $0x4,%esp
  801d63:	50                   	push   %eax
  801d64:	ff 75 f4             	pushl  -0xc(%ebp)
  801d67:	68 b8 29 80 00       	push   $0x8029b8
  801d6c:	e8 05 ea ff ff       	call   800776 <cprintf>
  801d71:	83 c4 10             	add    $0x10,%esp
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  801d74:	ff 45 f4             	incl   -0xc(%ebp)
  801d77:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
  801d7b:	7e d6                	jle    801d53 <PrintFreeBlockLists+0xf>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
	}
}
  801d7d:	90                   	nop
  801d7e:	c9                   	leave  
  801d7f:	c3                   	ret    

00801d80 <get_block_size>:
//==================================================================================//
//===========================
// [1] GET BLOCK SIZE:
//===========================
__inline__ uint32 get_block_size(void *va)
{
  801d80:	55                   	push   %ebp
  801d81:	89 e5                	mov    %esp,%ebp
  801d83:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [1] get_block_size
	//Your code is here
	//Comment the following line
	panic("get_block_size() not implemented");
  801d86:	83 ec 04             	sub    $0x4,%esp
  801d89:	68 c8 29 80 00       	push   $0x8029c8
  801d8e:	6a 33                	push   $0x33
  801d90:	68 e9 29 80 00       	push   $0x8029e9
  801d95:	e8 0e e7 ff ff       	call   8004a8 <_panic>

00801d9a <alloc_block>:
}
//===========================
// [2] ALLOCATE BLOCK:
//===========================
void *alloc_block(uint32 requiredSize)
{
  801d9a:	55                   	push   %ebp
  801d9b:	89 e5                	mov    %esp,%ebp
  801d9d:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [2] alloc_block
	//Your code is here
	//Comment the following line
	panic("alloc_block() not implemented");
  801da0:	83 ec 04             	sub    $0x4,%esp
  801da3:	68 01 2a 80 00       	push   $0x802a01
  801da8:	6a 3e                	push   $0x3e
  801daa:	68 e9 29 80 00       	push   $0x8029e9
  801daf:	e8 f4 e6 ff ff       	call   8004a8 <_panic>

00801db4 <free_block>:

//===================================================
// [3] FREE BLOCK WITH COALESCING:
//===================================================
void free_block(void *va)
{
  801db4:	55                   	push   %ebp
  801db5:	89 e5                	mov    %esp,%ebp
  801db7:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [3] free_block
	//Your code is here
	//Comment the following line
	panic("free_block() not implemented");
  801dba:	83 ec 04             	sub    $0x4,%esp
  801dbd:	68 1f 2a 80 00       	push   $0x802a1f
  801dc2:	6a 49                	push   $0x49
  801dc4:	68 e9 29 80 00       	push   $0x8029e9
  801dc9:	e8 da e6 ff ff       	call   8004a8 <_panic>

00801dce <realloc_block>:

//===========================
// [1] REALLOCATE BLOCK:
//===========================
void *realloc_block(void* va, uint32 newSize)
{
  801dce:	55                   	push   %ebp
  801dcf:	89 e5                	mov    %esp,%ebp
  801dd1:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#1] KERNEL REALLOC - realloc_block
	//Your code is here
	//Comment the following line
	panic("realloc_block() Not implemented yet");
  801dd4:	83 ec 04             	sub    $0x4,%esp
  801dd7:	68 3c 2a 80 00       	push   $0x802a3c
  801ddc:	6a 58                	push   $0x58
  801dde:	68 e9 29 80 00       	push   $0x8029e9
  801de3:	e8 c0 e6 ff ff       	call   8004a8 <_panic>

00801de8 <__udivdi3>:
  801de8:	55                   	push   %ebp
  801de9:	57                   	push   %edi
  801dea:	56                   	push   %esi
  801deb:	53                   	push   %ebx
  801dec:	83 ec 1c             	sub    $0x1c,%esp
  801def:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801df3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801df7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801dfb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801dff:	89 ca                	mov    %ecx,%edx
  801e01:	89 f8                	mov    %edi,%eax
  801e03:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801e07:	85 f6                	test   %esi,%esi
  801e09:	75 2d                	jne    801e38 <__udivdi3+0x50>
  801e0b:	39 cf                	cmp    %ecx,%edi
  801e0d:	77 65                	ja     801e74 <__udivdi3+0x8c>
  801e0f:	89 fd                	mov    %edi,%ebp
  801e11:	85 ff                	test   %edi,%edi
  801e13:	75 0b                	jne    801e20 <__udivdi3+0x38>
  801e15:	b8 01 00 00 00       	mov    $0x1,%eax
  801e1a:	31 d2                	xor    %edx,%edx
  801e1c:	f7 f7                	div    %edi
  801e1e:	89 c5                	mov    %eax,%ebp
  801e20:	31 d2                	xor    %edx,%edx
  801e22:	89 c8                	mov    %ecx,%eax
  801e24:	f7 f5                	div    %ebp
  801e26:	89 c1                	mov    %eax,%ecx
  801e28:	89 d8                	mov    %ebx,%eax
  801e2a:	f7 f5                	div    %ebp
  801e2c:	89 cf                	mov    %ecx,%edi
  801e2e:	89 fa                	mov    %edi,%edx
  801e30:	83 c4 1c             	add    $0x1c,%esp
  801e33:	5b                   	pop    %ebx
  801e34:	5e                   	pop    %esi
  801e35:	5f                   	pop    %edi
  801e36:	5d                   	pop    %ebp
  801e37:	c3                   	ret    
  801e38:	39 ce                	cmp    %ecx,%esi
  801e3a:	77 28                	ja     801e64 <__udivdi3+0x7c>
  801e3c:	0f bd fe             	bsr    %esi,%edi
  801e3f:	83 f7 1f             	xor    $0x1f,%edi
  801e42:	75 40                	jne    801e84 <__udivdi3+0x9c>
  801e44:	39 ce                	cmp    %ecx,%esi
  801e46:	72 0a                	jb     801e52 <__udivdi3+0x6a>
  801e48:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801e4c:	0f 87 9e 00 00 00    	ja     801ef0 <__udivdi3+0x108>
  801e52:	b8 01 00 00 00       	mov    $0x1,%eax
  801e57:	89 fa                	mov    %edi,%edx
  801e59:	83 c4 1c             	add    $0x1c,%esp
  801e5c:	5b                   	pop    %ebx
  801e5d:	5e                   	pop    %esi
  801e5e:	5f                   	pop    %edi
  801e5f:	5d                   	pop    %ebp
  801e60:	c3                   	ret    
  801e61:	8d 76 00             	lea    0x0(%esi),%esi
  801e64:	31 ff                	xor    %edi,%edi
  801e66:	31 c0                	xor    %eax,%eax
  801e68:	89 fa                	mov    %edi,%edx
  801e6a:	83 c4 1c             	add    $0x1c,%esp
  801e6d:	5b                   	pop    %ebx
  801e6e:	5e                   	pop    %esi
  801e6f:	5f                   	pop    %edi
  801e70:	5d                   	pop    %ebp
  801e71:	c3                   	ret    
  801e72:	66 90                	xchg   %ax,%ax
  801e74:	89 d8                	mov    %ebx,%eax
  801e76:	f7 f7                	div    %edi
  801e78:	31 ff                	xor    %edi,%edi
  801e7a:	89 fa                	mov    %edi,%edx
  801e7c:	83 c4 1c             	add    $0x1c,%esp
  801e7f:	5b                   	pop    %ebx
  801e80:	5e                   	pop    %esi
  801e81:	5f                   	pop    %edi
  801e82:	5d                   	pop    %ebp
  801e83:	c3                   	ret    
  801e84:	bd 20 00 00 00       	mov    $0x20,%ebp
  801e89:	89 eb                	mov    %ebp,%ebx
  801e8b:	29 fb                	sub    %edi,%ebx
  801e8d:	89 f9                	mov    %edi,%ecx
  801e8f:	d3 e6                	shl    %cl,%esi
  801e91:	89 c5                	mov    %eax,%ebp
  801e93:	88 d9                	mov    %bl,%cl
  801e95:	d3 ed                	shr    %cl,%ebp
  801e97:	89 e9                	mov    %ebp,%ecx
  801e99:	09 f1                	or     %esi,%ecx
  801e9b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801e9f:	89 f9                	mov    %edi,%ecx
  801ea1:	d3 e0                	shl    %cl,%eax
  801ea3:	89 c5                	mov    %eax,%ebp
  801ea5:	89 d6                	mov    %edx,%esi
  801ea7:	88 d9                	mov    %bl,%cl
  801ea9:	d3 ee                	shr    %cl,%esi
  801eab:	89 f9                	mov    %edi,%ecx
  801ead:	d3 e2                	shl    %cl,%edx
  801eaf:	8b 44 24 08          	mov    0x8(%esp),%eax
  801eb3:	88 d9                	mov    %bl,%cl
  801eb5:	d3 e8                	shr    %cl,%eax
  801eb7:	09 c2                	or     %eax,%edx
  801eb9:	89 d0                	mov    %edx,%eax
  801ebb:	89 f2                	mov    %esi,%edx
  801ebd:	f7 74 24 0c          	divl   0xc(%esp)
  801ec1:	89 d6                	mov    %edx,%esi
  801ec3:	89 c3                	mov    %eax,%ebx
  801ec5:	f7 e5                	mul    %ebp
  801ec7:	39 d6                	cmp    %edx,%esi
  801ec9:	72 19                	jb     801ee4 <__udivdi3+0xfc>
  801ecb:	74 0b                	je     801ed8 <__udivdi3+0xf0>
  801ecd:	89 d8                	mov    %ebx,%eax
  801ecf:	31 ff                	xor    %edi,%edi
  801ed1:	e9 58 ff ff ff       	jmp    801e2e <__udivdi3+0x46>
  801ed6:	66 90                	xchg   %ax,%ax
  801ed8:	8b 54 24 08          	mov    0x8(%esp),%edx
  801edc:	89 f9                	mov    %edi,%ecx
  801ede:	d3 e2                	shl    %cl,%edx
  801ee0:	39 c2                	cmp    %eax,%edx
  801ee2:	73 e9                	jae    801ecd <__udivdi3+0xe5>
  801ee4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801ee7:	31 ff                	xor    %edi,%edi
  801ee9:	e9 40 ff ff ff       	jmp    801e2e <__udivdi3+0x46>
  801eee:	66 90                	xchg   %ax,%ax
  801ef0:	31 c0                	xor    %eax,%eax
  801ef2:	e9 37 ff ff ff       	jmp    801e2e <__udivdi3+0x46>
  801ef7:	90                   	nop

00801ef8 <__umoddi3>:
  801ef8:	55                   	push   %ebp
  801ef9:	57                   	push   %edi
  801efa:	56                   	push   %esi
  801efb:	53                   	push   %ebx
  801efc:	83 ec 1c             	sub    $0x1c,%esp
  801eff:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801f03:	8b 74 24 34          	mov    0x34(%esp),%esi
  801f07:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f0b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801f0f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801f13:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801f17:	89 f3                	mov    %esi,%ebx
  801f19:	89 fa                	mov    %edi,%edx
  801f1b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f1f:	89 34 24             	mov    %esi,(%esp)
  801f22:	85 c0                	test   %eax,%eax
  801f24:	75 1a                	jne    801f40 <__umoddi3+0x48>
  801f26:	39 f7                	cmp    %esi,%edi
  801f28:	0f 86 a2 00 00 00    	jbe    801fd0 <__umoddi3+0xd8>
  801f2e:	89 c8                	mov    %ecx,%eax
  801f30:	89 f2                	mov    %esi,%edx
  801f32:	f7 f7                	div    %edi
  801f34:	89 d0                	mov    %edx,%eax
  801f36:	31 d2                	xor    %edx,%edx
  801f38:	83 c4 1c             	add    $0x1c,%esp
  801f3b:	5b                   	pop    %ebx
  801f3c:	5e                   	pop    %esi
  801f3d:	5f                   	pop    %edi
  801f3e:	5d                   	pop    %ebp
  801f3f:	c3                   	ret    
  801f40:	39 f0                	cmp    %esi,%eax
  801f42:	0f 87 ac 00 00 00    	ja     801ff4 <__umoddi3+0xfc>
  801f48:	0f bd e8             	bsr    %eax,%ebp
  801f4b:	83 f5 1f             	xor    $0x1f,%ebp
  801f4e:	0f 84 ac 00 00 00    	je     802000 <__umoddi3+0x108>
  801f54:	bf 20 00 00 00       	mov    $0x20,%edi
  801f59:	29 ef                	sub    %ebp,%edi
  801f5b:	89 fe                	mov    %edi,%esi
  801f5d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801f61:	89 e9                	mov    %ebp,%ecx
  801f63:	d3 e0                	shl    %cl,%eax
  801f65:	89 d7                	mov    %edx,%edi
  801f67:	89 f1                	mov    %esi,%ecx
  801f69:	d3 ef                	shr    %cl,%edi
  801f6b:	09 c7                	or     %eax,%edi
  801f6d:	89 e9                	mov    %ebp,%ecx
  801f6f:	d3 e2                	shl    %cl,%edx
  801f71:	89 14 24             	mov    %edx,(%esp)
  801f74:	89 d8                	mov    %ebx,%eax
  801f76:	d3 e0                	shl    %cl,%eax
  801f78:	89 c2                	mov    %eax,%edx
  801f7a:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f7e:	d3 e0                	shl    %cl,%eax
  801f80:	89 44 24 04          	mov    %eax,0x4(%esp)
  801f84:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f88:	89 f1                	mov    %esi,%ecx
  801f8a:	d3 e8                	shr    %cl,%eax
  801f8c:	09 d0                	or     %edx,%eax
  801f8e:	d3 eb                	shr    %cl,%ebx
  801f90:	89 da                	mov    %ebx,%edx
  801f92:	f7 f7                	div    %edi
  801f94:	89 d3                	mov    %edx,%ebx
  801f96:	f7 24 24             	mull   (%esp)
  801f99:	89 c6                	mov    %eax,%esi
  801f9b:	89 d1                	mov    %edx,%ecx
  801f9d:	39 d3                	cmp    %edx,%ebx
  801f9f:	0f 82 87 00 00 00    	jb     80202c <__umoddi3+0x134>
  801fa5:	0f 84 91 00 00 00    	je     80203c <__umoddi3+0x144>
  801fab:	8b 54 24 04          	mov    0x4(%esp),%edx
  801faf:	29 f2                	sub    %esi,%edx
  801fb1:	19 cb                	sbb    %ecx,%ebx
  801fb3:	89 d8                	mov    %ebx,%eax
  801fb5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801fb9:	d3 e0                	shl    %cl,%eax
  801fbb:	89 e9                	mov    %ebp,%ecx
  801fbd:	d3 ea                	shr    %cl,%edx
  801fbf:	09 d0                	or     %edx,%eax
  801fc1:	89 e9                	mov    %ebp,%ecx
  801fc3:	d3 eb                	shr    %cl,%ebx
  801fc5:	89 da                	mov    %ebx,%edx
  801fc7:	83 c4 1c             	add    $0x1c,%esp
  801fca:	5b                   	pop    %ebx
  801fcb:	5e                   	pop    %esi
  801fcc:	5f                   	pop    %edi
  801fcd:	5d                   	pop    %ebp
  801fce:	c3                   	ret    
  801fcf:	90                   	nop
  801fd0:	89 fd                	mov    %edi,%ebp
  801fd2:	85 ff                	test   %edi,%edi
  801fd4:	75 0b                	jne    801fe1 <__umoddi3+0xe9>
  801fd6:	b8 01 00 00 00       	mov    $0x1,%eax
  801fdb:	31 d2                	xor    %edx,%edx
  801fdd:	f7 f7                	div    %edi
  801fdf:	89 c5                	mov    %eax,%ebp
  801fe1:	89 f0                	mov    %esi,%eax
  801fe3:	31 d2                	xor    %edx,%edx
  801fe5:	f7 f5                	div    %ebp
  801fe7:	89 c8                	mov    %ecx,%eax
  801fe9:	f7 f5                	div    %ebp
  801feb:	89 d0                	mov    %edx,%eax
  801fed:	e9 44 ff ff ff       	jmp    801f36 <__umoddi3+0x3e>
  801ff2:	66 90                	xchg   %ax,%ax
  801ff4:	89 c8                	mov    %ecx,%eax
  801ff6:	89 f2                	mov    %esi,%edx
  801ff8:	83 c4 1c             	add    $0x1c,%esp
  801ffb:	5b                   	pop    %ebx
  801ffc:	5e                   	pop    %esi
  801ffd:	5f                   	pop    %edi
  801ffe:	5d                   	pop    %ebp
  801fff:	c3                   	ret    
  802000:	3b 04 24             	cmp    (%esp),%eax
  802003:	72 06                	jb     80200b <__umoddi3+0x113>
  802005:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802009:	77 0f                	ja     80201a <__umoddi3+0x122>
  80200b:	89 f2                	mov    %esi,%edx
  80200d:	29 f9                	sub    %edi,%ecx
  80200f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802013:	89 14 24             	mov    %edx,(%esp)
  802016:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80201a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80201e:	8b 14 24             	mov    (%esp),%edx
  802021:	83 c4 1c             	add    $0x1c,%esp
  802024:	5b                   	pop    %ebx
  802025:	5e                   	pop    %esi
  802026:	5f                   	pop    %edi
  802027:	5d                   	pop    %ebp
  802028:	c3                   	ret    
  802029:	8d 76 00             	lea    0x0(%esi),%esi
  80202c:	2b 04 24             	sub    (%esp),%eax
  80202f:	19 fa                	sbb    %edi,%edx
  802031:	89 d1                	mov    %edx,%ecx
  802033:	89 c6                	mov    %eax,%esi
  802035:	e9 71 ff ff ff       	jmp    801fab <__umoddi3+0xb3>
  80203a:	66 90                	xchg   %ax,%ax
  80203c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802040:	72 ea                	jb     80202c <__umoddi3+0x134>
  802042:	89 d9                	mov    %ebx,%ecx
  802044:	e9 62 ff ff ff       	jmp    801fab <__umoddi3+0xb3>
