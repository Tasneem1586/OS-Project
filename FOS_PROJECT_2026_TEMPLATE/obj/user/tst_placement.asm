
obj/user/tst_placement:     file format elf32-i386


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
  800031:	e8 d5 05 00 00       	call   80060b <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
		0xeebfd000, 0xedbfd000 /*will be created during the call of sys_check_WS_list*/,	//Stack
		0x81b000 /*for the text color variable*/} ;


void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec 84 00 00 01    	sub    $0x1000084,%esp
#if USE_KHEAP
	//	cprintf_colored(TEXT_cyan,"envID = %d\n",envID);

	char arr[PAGE_SIZE*1024*4];
	bool found ;
	cprintf_colored(TEXT_cyan,"STEP 0: checking Initial WS entries ...\n");
  800042:	83 ec 08             	sub    $0x8,%esp
  800045:	68 00 22 80 00       	push   $0x802200
  80004a:	6a 03                	push   $0x3
  80004c:	e8 15 0b 00 00       	call   800b66 <cprintf_colored>
  800051:	83 c4 10             	add    $0x10,%esp
	{
		found = sys_check_WS_list(expectedInitialVAs, 15, 0, 1);
  800054:	6a 01                	push   $0x1
  800056:	6a 00                	push   $0x0
  800058:	6a 0f                	push   $0xf
  80005a:	68 00 30 80 00       	push   $0x803000
  80005f:	e8 64 1e 00 00       	call   801ec8 <sys_check_WS_list>
  800064:	83 c4 10             	add    $0x10,%esp
  800067:	89 45 e8             	mov    %eax,-0x18(%ebp)
		if (found != 1) panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80006a:	83 7d e8 01          	cmpl   $0x1,-0x18(%ebp)
  80006e:	74 14                	je     800084 <_main+0x4c>
  800070:	83 ec 04             	sub    $0x4,%esp
  800073:	68 2c 22 80 00       	push   $0x80222c
  800078:	6a 17                	push   $0x17
  80007a:	68 7e 22 80 00       	push   $0x80227e
  80007f:	e8 e7 07 00 00       	call   80086b <_panic>

		/*NO NEED FOR THIS IF REPL IS "LRU"*/
		if( myEnv->page_last_WS_element !=  NULL)
  800084:	a1 60 30 80 00       	mov    0x803060,%eax
  800089:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
  80008f:	85 c0                	test   %eax,%eax
  800091:	74 14                	je     8000a7 <_main+0x6f>
			panic("INITIAL PAGE last WS checking failed! Review size of the WS..!!");
  800093:	83 ec 04             	sub    $0x4,%esp
  800096:	68 94 22 80 00       	push   $0x802294
  80009b:	6a 1b                	push   $0x1b
  80009d:	68 7e 22 80 00       	push   $0x80227e
  8000a2:	e8 c4 07 00 00       	call   80086b <_panic>
		/*====================================*/
	}
	int eval = 0;
  8000a7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	bool is_correct = 1;
  8000ae:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)

	cprintf_colored(TEXT_cyan,"\nSTEP 1: checking USER KERNEL STACK... [20%]\n");
  8000b5:	83 ec 08             	sub    $0x8,%esp
  8000b8:	68 d4 22 80 00       	push   $0x8022d4
  8000bd:	6a 03                	push   $0x3
  8000bf:	e8 a2 0a 00 00       	call   800b66 <cprintf_colored>
  8000c4:	83 c4 10             	add    $0x10,%esp
	{
		uint32 stackIsCorrect;
		sys_utilities("__CheckUserKernStack__", (uint32)(&stackIsCorrect));
  8000c7:	8d 85 d8 ff ff fe    	lea    -0x1000028(%ebp),%eax
  8000cd:	83 ec 08             	sub    $0x8,%esp
  8000d0:	50                   	push   %eax
  8000d1:	68 02 23 80 00       	push   $0x802302
  8000d6:	e8 2a 1e 00 00       	call   801f05 <sys_utilities>
  8000db:	83 c4 10             	add    $0x10,%esp
		if (!stackIsCorrect)
  8000de:	8b 85 d8 ff ff fe    	mov    -0x1000028(%ebp),%eax
  8000e4:	85 c0                	test   %eax,%eax
  8000e6:	75 19                	jne    800101 <_main+0xc9>
		{
			is_correct = 0;
  8000e8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			cprintf_colored(TEXT_TESTERR_CLR,"User Kernel Stack is not set correctly\n");
  8000ef:	83 ec 08             	sub    $0x8,%esp
  8000f2:	68 1c 23 80 00       	push   $0x80231c
  8000f7:	6a 0c                	push   $0xc
  8000f9:	e8 68 0a 00 00       	call   800b66 <cprintf_colored>
  8000fe:	83 c4 10             	add    $0x10,%esp
		}
	}
	if (is_correct) eval += 20;
  800101:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800105:	74 04                	je     80010b <_main+0xd3>
  800107:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)

	cprintf_colored(TEXT_cyan,"\nSTEP 2: checking PLACEMENT...\n");
  80010b:	83 ec 08             	sub    $0x8,%esp
  80010e:	68 44 23 80 00       	push   $0x802344
  800113:	6a 03                	push   $0x3
  800115:	e8 4c 0a 00 00       	call   800b66 <cprintf_colored>
  80011a:	83 c4 10             	add    $0x10,%esp
	{
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80011d:	e8 66 1a 00 00       	call   801b88 <sys_pf_calculate_allocated_pages>
  800122:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int freePages = sys_calculate_free_frames();
  800125:	e8 13 1a 00 00       	call   801b3d <sys_calculate_free_frames>
  80012a:	89 45 e0             	mov    %eax,-0x20(%ebp)
		//2 stack pages & page table
		int i=PAGE_SIZE*1024;
  80012d:	c7 45 ec 00 00 40 00 	movl   $0x400000,-0x14(%ebp)
		for(;i<=(PAGE_SIZE*1024 + PAGE_SIZE);i++)
  800134:	eb 11                	jmp    800147 <_main+0x10f>
		{
			arr[i] = 1;
  800136:	8d 95 dc ff ff fe    	lea    -0x1000024(%ebp),%edx
  80013c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80013f:	01 d0                	add    %edx,%eax
  800141:	c6 00 01             	movb   $0x1,(%eax)
	{
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
		int freePages = sys_calculate_free_frames();
		//2 stack pages & page table
		int i=PAGE_SIZE*1024;
		for(;i<=(PAGE_SIZE*1024 + PAGE_SIZE);i++)
  800144:	ff 45 ec             	incl   -0x14(%ebp)
  800147:	81 7d ec 00 10 40 00 	cmpl   $0x401000,-0x14(%ebp)
  80014e:	7e e6                	jle    800136 <_main+0xfe>
		{
			arr[i] = 1;
		}

		//2 stack pages & page table
		i=PAGE_SIZE*1024*2;
  800150:	c7 45 ec 00 00 80 00 	movl   $0x800000,-0x14(%ebp)
		for(;i<=(PAGE_SIZE*1024*2 + PAGE_SIZE);i++)
  800157:	eb 11                	jmp    80016a <_main+0x132>
		{
			arr[i] = 2;
  800159:	8d 95 dc ff ff fe    	lea    -0x1000024(%ebp),%edx
  80015f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800162:	01 d0                	add    %edx,%eax
  800164:	c6 00 02             	movb   $0x2,(%eax)
			arr[i] = 1;
		}

		//2 stack pages & page table
		i=PAGE_SIZE*1024*2;
		for(;i<=(PAGE_SIZE*1024*2 + PAGE_SIZE);i++)
  800167:	ff 45 ec             	incl   -0x14(%ebp)
  80016a:	81 7d ec 00 10 80 00 	cmpl   $0x801000,-0x14(%ebp)
  800171:	7e e6                	jle    800159 <_main+0x121>
		{
			arr[i] = 2;
		}

		//2 stack pages & page table
		i=PAGE_SIZE*1024*3;
  800173:	c7 45 ec 00 00 c0 00 	movl   $0xc00000,-0x14(%ebp)
		for(;i<=(PAGE_SIZE*1024*3 + PAGE_SIZE);i++)
  80017a:	eb 11                	jmp    80018d <_main+0x155>
		{
			arr[i] = 3;
  80017c:	8d 95 dc ff ff fe    	lea    -0x1000024(%ebp),%edx
  800182:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800185:	01 d0                	add    %edx,%eax
  800187:	c6 00 03             	movb   $0x3,(%eax)
			arr[i] = 2;
		}

		//2 stack pages & page table
		i=PAGE_SIZE*1024*3;
		for(;i<=(PAGE_SIZE*1024*3 + PAGE_SIZE);i++)
  80018a:	ff 45 ec             	incl   -0x14(%ebp)
  80018d:	81 7d ec 00 10 c0 00 	cmpl   $0xc01000,-0x14(%ebp)
  800194:	7e e6                	jle    80017c <_main+0x144>
		{
			arr[i] = 3;
		}

		is_correct = 1;
  800196:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
		cprintf_colored(TEXT_cyan,"	STEP A: checking PLACEMENT fault handling... [30%] \n");
  80019d:	83 ec 08             	sub    $0x8,%esp
  8001a0:	68 64 23 80 00       	push   $0x802364
  8001a5:	6a 03                	push   $0x3
  8001a7:	e8 ba 09 00 00       	call   800b66 <cprintf_colored>
  8001ac:	83 c4 10             	add    $0x10,%esp
		{
			if( arr[PAGE_SIZE*1024] !=  1)  { is_correct = 0; cprintf_colored(TEXT_TESTERR_CLR,"PLACEMENT of stack page failed\n");}
  8001af:	8a 85 dc ff 3f ff    	mov    -0xc00024(%ebp),%al
  8001b5:	3c 01                	cmp    $0x1,%al
  8001b7:	74 19                	je     8001d2 <_main+0x19a>
  8001b9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8001c0:	83 ec 08             	sub    $0x8,%esp
  8001c3:	68 9c 23 80 00       	push   $0x80239c
  8001c8:	6a 0c                	push   $0xc
  8001ca:	e8 97 09 00 00       	call   800b66 <cprintf_colored>
  8001cf:	83 c4 10             	add    $0x10,%esp
			if( arr[PAGE_SIZE*1025] !=  1)  { is_correct = 0; cprintf_colored(TEXT_TESTERR_CLR,"PLACEMENT of stack page failed\n");}
  8001d2:	8a 85 dc 0f 40 ff    	mov    -0xbff024(%ebp),%al
  8001d8:	3c 01                	cmp    $0x1,%al
  8001da:	74 19                	je     8001f5 <_main+0x1bd>
  8001dc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8001e3:	83 ec 08             	sub    $0x8,%esp
  8001e6:	68 9c 23 80 00       	push   $0x80239c
  8001eb:	6a 0c                	push   $0xc
  8001ed:	e8 74 09 00 00       	call   800b66 <cprintf_colored>
  8001f2:	83 c4 10             	add    $0x10,%esp

			if( arr[PAGE_SIZE*1024*2] !=  2)  { is_correct = 0; cprintf_colored(TEXT_TESTERR_CLR,"PLACEMENT of stack page failed\n");}
  8001f5:	8a 85 dc ff 7f ff    	mov    -0x800024(%ebp),%al
  8001fb:	3c 02                	cmp    $0x2,%al
  8001fd:	74 19                	je     800218 <_main+0x1e0>
  8001ff:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800206:	83 ec 08             	sub    $0x8,%esp
  800209:	68 9c 23 80 00       	push   $0x80239c
  80020e:	6a 0c                	push   $0xc
  800210:	e8 51 09 00 00       	call   800b66 <cprintf_colored>
  800215:	83 c4 10             	add    $0x10,%esp
			if( arr[PAGE_SIZE*1024*2 + PAGE_SIZE] !=  2)  { is_correct = 0; cprintf_colored(TEXT_TESTERR_CLR,"PLACEMENT of stack page failed\n");}
  800218:	8a 85 dc 0f 80 ff    	mov    -0x7ff024(%ebp),%al
  80021e:	3c 02                	cmp    $0x2,%al
  800220:	74 19                	je     80023b <_main+0x203>
  800222:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800229:	83 ec 08             	sub    $0x8,%esp
  80022c:	68 9c 23 80 00       	push   $0x80239c
  800231:	6a 0c                	push   $0xc
  800233:	e8 2e 09 00 00       	call   800b66 <cprintf_colored>
  800238:	83 c4 10             	add    $0x10,%esp

			if( arr[PAGE_SIZE*1024*3] !=  3)  { is_correct = 0; cprintf_colored(TEXT_TESTERR_CLR,"PLACEMENT of stack page failed\n");}
  80023b:	8a 85 dc ff bf ff    	mov    -0x400024(%ebp),%al
  800241:	3c 03                	cmp    $0x3,%al
  800243:	74 19                	je     80025e <_main+0x226>
  800245:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80024c:	83 ec 08             	sub    $0x8,%esp
  80024f:	68 9c 23 80 00       	push   $0x80239c
  800254:	6a 0c                	push   $0xc
  800256:	e8 0b 09 00 00       	call   800b66 <cprintf_colored>
  80025b:	83 c4 10             	add    $0x10,%esp
			if( arr[PAGE_SIZE*1024*3 + PAGE_SIZE] !=  3)  { is_correct = 0; cprintf_colored(TEXT_TESTERR_CLR,"PLACEMENT of stack page failed\n");}
  80025e:	8a 85 dc 0f c0 ff    	mov    -0x3ff024(%ebp),%al
  800264:	3c 03                	cmp    $0x3,%al
  800266:	74 19                	je     800281 <_main+0x249>
  800268:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80026f:	83 ec 08             	sub    $0x8,%esp
  800272:	68 9c 23 80 00       	push   $0x80239c
  800277:	6a 0c                	push   $0xc
  800279:	e8 e8 08 00 00       	call   800b66 <cprintf_colored>
  80027e:	83 c4 10             	add    $0x10,%esp

			if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) { is_correct = 0; cprintf_colored(TEXT_cyan,"new stack pages should NOT be written to Page File until evicted as victim\n");}
  800281:	e8 02 19 00 00       	call   801b88 <sys_pf_calculate_allocated_pages>
  800286:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800289:	74 19                	je     8002a4 <_main+0x26c>
  80028b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800292:	83 ec 08             	sub    $0x8,%esp
  800295:	68 bc 23 80 00       	push   $0x8023bc
  80029a:	6a 03                	push   $0x3
  80029c:	e8 c5 08 00 00       	call   800b66 <cprintf_colored>
  8002a1:	83 c4 10             	add    $0x10,%esp

			int expected = 6 /*pages*/ + 3 /*tables*/;
  8002a4:	c7 45 dc 09 00 00 00 	movl   $0x9,-0x24(%ebp)
			if( (freePages - sys_calculate_free_frames() ) != expected )
  8002ab:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  8002ae:	e8 8a 18 00 00       	call   801b3d <sys_calculate_free_frames>
  8002b3:	29 c3                	sub    %eax,%ebx
  8002b5:	89 da                	mov    %ebx,%edx
  8002b7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8002ba:	39 c2                	cmp    %eax,%edx
  8002bc:	74 26                	je     8002e4 <_main+0x2ac>
			{ is_correct = 0; cprintf_colored(TEXT_TESTERR_CLR,"allocated memory size incorrect. Expected Difference = %d, Actual = %d\n", expected, (freePages - sys_calculate_free_frames() ));}
  8002be:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8002c5:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  8002c8:	e8 70 18 00 00       	call   801b3d <sys_calculate_free_frames>
  8002cd:	29 c3                	sub    %eax,%ebx
  8002cf:	89 d8                	mov    %ebx,%eax
  8002d1:	50                   	push   %eax
  8002d2:	ff 75 dc             	pushl  -0x24(%ebp)
  8002d5:	68 08 24 80 00       	push   $0x802408
  8002da:	6a 0c                	push   $0xc
  8002dc:	e8 85 08 00 00       	call   800b66 <cprintf_colored>
  8002e1:	83 c4 10             	add    $0x10,%esp
		}
		cprintf_colored(TEXT_cyan,"	STEP A finished: PLACEMENT fault handling !\n\n\n");
  8002e4:	83 ec 08             	sub    $0x8,%esp
  8002e7:	68 50 24 80 00       	push   $0x802450
  8002ec:	6a 03                	push   $0x3
  8002ee:	e8 73 08 00 00       	call   800b66 <cprintf_colored>
  8002f3:	83 c4 10             	add    $0x10,%esp

		if (is_correct)
  8002f6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8002fa:	74 04                	je     800300 <_main+0x2c8>
		{
			eval += 30;
  8002fc:	83 45 f4 1e          	addl   $0x1e,-0xc(%ebp)
		}
		is_correct = 1;
  800300:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)

		cprintf_colored(TEXT_cyan,"	STEP B: checking WS entries... [30%]\n");
  800307:	83 ec 08             	sub    $0x8,%esp
  80030a:	68 80 24 80 00       	push   $0x802480
  80030f:	6a 03                	push   $0x3
  800311:	e8 50 08 00 00       	call   800b66 <cprintf_colored>
  800316:	83 c4 10             	add    $0x10,%esp
		{
			uint32 expectedPages[21] ;
			{
				expectedPages[0] = 0x800000 ;
  800319:	c7 85 80 ff ff fe 00 	movl   $0x800000,-0x1000080(%ebp)
  800320:	00 80 00 
				expectedPages[1] = 0x801000 ;
  800323:	c7 85 84 ff ff fe 00 	movl   $0x801000,-0x100007c(%ebp)
  80032a:	10 80 00 
				expectedPages[2] = 0x802000 ;
  80032d:	c7 85 88 ff ff fe 00 	movl   $0x802000,-0x1000078(%ebp)
  800334:	20 80 00 
				expectedPages[3] = 0x803000 ;
  800337:	c7 85 8c ff ff fe 00 	movl   $0x803000,-0x1000074(%ebp)
  80033e:	30 80 00 
				expectedPages[4] = 0x804000 ;
  800341:	c7 85 90 ff ff fe 00 	movl   $0x804000,-0x1000070(%ebp)
  800348:	40 80 00 
				expectedPages[5] = 0x805000 ;
  80034b:	c7 85 94 ff ff fe 00 	movl   $0x805000,-0x100006c(%ebp)
  800352:	50 80 00 
				expectedPages[6] = 0x806000 ;
  800355:	c7 85 98 ff ff fe 00 	movl   $0x806000,-0x1000068(%ebp)
  80035c:	60 80 00 
				expectedPages[7] = 0x807000 ;
  80035f:	c7 85 9c ff ff fe 00 	movl   $0x807000,-0x1000064(%ebp)
  800366:	70 80 00 
				expectedPages[8] = 0x808000 ;
  800369:	c7 85 a0 ff ff fe 00 	movl   $0x808000,-0x1000060(%ebp)
  800370:	80 80 00 
				expectedPages[9] = 0x809000 ;
  800373:	c7 85 a4 ff ff fe 00 	movl   $0x809000,-0x100005c(%ebp)
  80037a:	90 80 00 
				expectedPages[10] = 0x80a000 ;
  80037d:	c7 85 a8 ff ff fe 00 	movl   $0x80a000,-0x1000058(%ebp)
  800384:	a0 80 00 
				expectedPages[11] = 0x80b000 ;
  800387:	c7 85 ac ff ff fe 00 	movl   $0x80b000,-0x1000054(%ebp)
  80038e:	b0 80 00 
				expectedPages[12] = 0xeebfd000 ;
  800391:	c7 85 b0 ff ff fe 00 	movl   $0xeebfd000,-0x1000050(%ebp)
  800398:	d0 bf ee 
				expectedPages[13] = 0xedbfd000 ;
  80039b:	c7 85 b4 ff ff fe 00 	movl   $0xedbfd000,-0x100004c(%ebp)
  8003a2:	d0 bf ed 
				expectedPages[14] = 0x81b000 ;
  8003a5:	c7 85 b8 ff ff fe 00 	movl   $0x81b000,-0x1000048(%ebp)
  8003ac:	b0 81 00 
				expectedPages[15] = 0xedffd000 ;
  8003af:	c7 85 bc ff ff fe 00 	movl   $0xedffd000,-0x1000044(%ebp)
  8003b6:	d0 ff ed 
				expectedPages[16] = 0xedffe000 ;
  8003b9:	c7 85 c0 ff ff fe 00 	movl   $0xedffe000,-0x1000040(%ebp)
  8003c0:	e0 ff ed 
				expectedPages[17] = 0xee3fd000 ;
  8003c3:	c7 85 c4 ff ff fe 00 	movl   $0xee3fd000,-0x100003c(%ebp)
  8003ca:	d0 3f ee 
				expectedPages[18] = 0xee3fe000 ;
  8003cd:	c7 85 c8 ff ff fe 00 	movl   $0xee3fe000,-0x1000038(%ebp)
  8003d4:	e0 3f ee 
				expectedPages[19] = 0xee7fd000 ;
  8003d7:	c7 85 cc ff ff fe 00 	movl   $0xee7fd000,-0x1000034(%ebp)
  8003de:	d0 7f ee 
				expectedPages[20] = 0xee7fe000 ;
  8003e1:	c7 85 d0 ff ff fe 00 	movl   $0xee7fe000,-0x1000030(%ebp)
  8003e8:	e0 7f ee 
			}
			found = sys_check_WS_list(expectedPages, 21, 0, 1);
  8003eb:	6a 01                	push   $0x1
  8003ed:	6a 00                	push   $0x0
  8003ef:	6a 15                	push   $0x15
  8003f1:	8d 85 80 ff ff fe    	lea    -0x1000080(%ebp),%eax
  8003f7:	50                   	push   %eax
  8003f8:	e8 cb 1a 00 00       	call   801ec8 <sys_check_WS_list>
  8003fd:	83 c4 10             	add    $0x10,%esp
  800400:	89 45 e8             	mov    %eax,-0x18(%ebp)
			if (found != 1)
  800403:	83 7d e8 01          	cmpl   $0x1,-0x18(%ebp)
  800407:	74 19                	je     800422 <_main+0x3ea>
			{ is_correct = 0; cprintf_colored(TEXT_TESTERR_CLR,"PAGE WS entry checking failed... trace it by printing page WS before & after fault\n");}
  800409:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800410:	83 ec 08             	sub    $0x8,%esp
  800413:	68 a8 24 80 00       	push   $0x8024a8
  800418:	6a 0c                	push   $0xc
  80041a:	e8 47 07 00 00       	call   800b66 <cprintf_colored>
  80041f:	83 c4 10             	add    $0x10,%esp
		}
		cprintf_colored(TEXT_cyan,"	STEP B finished: WS entries test \n\n\n");
  800422:	83 ec 08             	sub    $0x8,%esp
  800425:	68 fc 24 80 00       	push   $0x8024fc
  80042a:	6a 03                	push   $0x3
  80042c:	e8 35 07 00 00       	call   800b66 <cprintf_colored>
  800431:	83 c4 10             	add    $0x10,%esp
		if (is_correct)
  800434:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800438:	74 04                	je     80043e <_main+0x406>
		{
			eval += 30;
  80043a:	83 45 f4 1e          	addl   $0x1e,-0xc(%ebp)
		}
		is_correct = 1;
  80043e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
		cprintf_colored(TEXT_cyan,"	STEP C: checking working sets WHEN BECOMES FULL... [20%]\n");
  800445:	83 ec 08             	sub    $0x8,%esp
  800448:	68 24 25 80 00       	push   $0x802524
  80044d:	6a 03                	push   $0x3
  80044f:	e8 12 07 00 00       	call   800b66 <cprintf_colored>
  800454:	83 c4 10             	add    $0x10,%esp
		{
			/*NO NEED FOR THIS IF REPL IS "LRU"*/
			if(myEnv->page_last_WS_element != NULL)
  800457:	a1 60 30 80 00       	mov    0x803060,%eax
  80045c:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
  800462:	85 c0                	test   %eax,%eax
  800464:	74 19                	je     80047f <_main+0x447>
			{ is_correct = 0; cprintf_colored(TEXT_TESTERR_CLR,"wrong PAGE WS pointer location... trace it by printing page WS before & after fault\n");}
  800466:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80046d:	83 ec 08             	sub    $0x8,%esp
  800470:	68 60 25 80 00       	push   $0x802560
  800475:	6a 0c                	push   $0xc
  800477:	e8 ea 06 00 00       	call   800b66 <cprintf_colored>
  80047c:	83 c4 10             	add    $0x10,%esp

			//1 stack page
			i=PAGE_SIZE*1024*3 + 2*PAGE_SIZE;
  80047f:	c7 45 ec 00 20 c0 00 	movl   $0xc02000,-0x14(%ebp)
			arr[i] = 4;
  800486:	8d 95 dc ff ff fe    	lea    -0x1000024(%ebp),%edx
  80048c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80048f:	01 d0                	add    %edx,%eax
  800491:	c6 00 04             	movb   $0x4,(%eax)

			if( arr[i] != 4)  { is_correct = 0; cprintf_colored(TEXT_TESTERR_CLR,"PLACEMENT of stack page failed\n");}
  800494:	8d 95 dc ff ff fe    	lea    -0x1000024(%ebp),%edx
  80049a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80049d:	01 d0                	add    %edx,%eax
  80049f:	8a 00                	mov    (%eax),%al
  8004a1:	3c 04                	cmp    $0x4,%al
  8004a3:	74 19                	je     8004be <_main+0x486>
  8004a5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8004ac:	83 ec 08             	sub    $0x8,%esp
  8004af:	68 9c 23 80 00       	push   $0x80239c
  8004b4:	6a 0c                	push   $0xc
  8004b6:	e8 ab 06 00 00       	call   800b66 <cprintf_colored>
  8004bb:	83 c4 10             	add    $0x10,%esp
			//				0x200000,0x201000,0x202000,0x203000,0x204000,0x205000,0x206000,0x207000,
			//				0x800000,0x801000,0x802000,0x803000,
			//				0xeebfd000,0xedbfd000,0xedbfe000,0xedffd000,0xedffe000,0xee3fd000,0xee3fe000,0xee7fd000};
			uint32 expectedPages[22] ;
			{
				expectedPages[0] = 0x800000 ;
  8004be:	c7 85 80 ff ff fe 00 	movl   $0x800000,-0x1000080(%ebp)
  8004c5:	00 80 00 
				expectedPages[1] = 0x801000 ;
  8004c8:	c7 85 84 ff ff fe 00 	movl   $0x801000,-0x100007c(%ebp)
  8004cf:	10 80 00 
				expectedPages[2] = 0x802000 ;
  8004d2:	c7 85 88 ff ff fe 00 	movl   $0x802000,-0x1000078(%ebp)
  8004d9:	20 80 00 
				expectedPages[3] = 0x803000 ;
  8004dc:	c7 85 8c ff ff fe 00 	movl   $0x803000,-0x1000074(%ebp)
  8004e3:	30 80 00 
				expectedPages[4] = 0x804000 ;
  8004e6:	c7 85 90 ff ff fe 00 	movl   $0x804000,-0x1000070(%ebp)
  8004ed:	40 80 00 
				expectedPages[5] = 0x805000 ;
  8004f0:	c7 85 94 ff ff fe 00 	movl   $0x805000,-0x100006c(%ebp)
  8004f7:	50 80 00 
				expectedPages[6] = 0x806000 ;
  8004fa:	c7 85 98 ff ff fe 00 	movl   $0x806000,-0x1000068(%ebp)
  800501:	60 80 00 
				expectedPages[7] = 0x807000 ;
  800504:	c7 85 9c ff ff fe 00 	movl   $0x807000,-0x1000064(%ebp)
  80050b:	70 80 00 
				expectedPages[8] = 0x808000 ;
  80050e:	c7 85 a0 ff ff fe 00 	movl   $0x808000,-0x1000060(%ebp)
  800515:	80 80 00 
				expectedPages[9] = 0x809000 ;
  800518:	c7 85 a4 ff ff fe 00 	movl   $0x809000,-0x100005c(%ebp)
  80051f:	90 80 00 
				expectedPages[10] = 0x80a000 ;
  800522:	c7 85 a8 ff ff fe 00 	movl   $0x80a000,-0x1000058(%ebp)
  800529:	a0 80 00 
				expectedPages[11] = 0x80b000 ;
  80052c:	c7 85 ac ff ff fe 00 	movl   $0x80b000,-0x1000054(%ebp)
  800533:	b0 80 00 
				expectedPages[12] = 0xeebfd000 ;
  800536:	c7 85 b0 ff ff fe 00 	movl   $0xeebfd000,-0x1000050(%ebp)
  80053d:	d0 bf ee 
				expectedPages[13] = 0xedbfd000 ;
  800540:	c7 85 b4 ff ff fe 00 	movl   $0xedbfd000,-0x100004c(%ebp)
  800547:	d0 bf ed 
				expectedPages[14] = 0x81b000 ;
  80054a:	c7 85 b8 ff ff fe 00 	movl   $0x81b000,-0x1000048(%ebp)
  800551:	b0 81 00 
				expectedPages[15] = 0xedffd000 ;
  800554:	c7 85 bc ff ff fe 00 	movl   $0xedffd000,-0x1000044(%ebp)
  80055b:	d0 ff ed 
				expectedPages[16] = 0xedffe000 ;
  80055e:	c7 85 c0 ff ff fe 00 	movl   $0xedffe000,-0x1000040(%ebp)
  800565:	e0 ff ed 
				expectedPages[17] = 0xee3fd000 ;
  800568:	c7 85 c4 ff ff fe 00 	movl   $0xee3fd000,-0x100003c(%ebp)
  80056f:	d0 3f ee 
				expectedPages[18] = 0xee3fe000 ;
  800572:	c7 85 c8 ff ff fe 00 	movl   $0xee3fe000,-0x1000038(%ebp)
  800579:	e0 3f ee 
				expectedPages[19] = 0xee7fd000 ;
  80057c:	c7 85 cc ff ff fe 00 	movl   $0xee7fd000,-0x1000034(%ebp)
  800583:	d0 7f ee 
				expectedPages[20] = 0xee7fe000 ;
  800586:	c7 85 d0 ff ff fe 00 	movl   $0xee7fe000,-0x1000030(%ebp)
  80058d:	e0 7f ee 
				expectedPages[21] = 0xee7ff000 ;
  800590:	c7 85 d4 ff ff fe 00 	movl   $0xee7ff000,-0x100002c(%ebp)
  800597:	f0 7f ee 
			}
			found = sys_check_WS_list(expectedPages, 22, 0x800000, 1);
  80059a:	6a 01                	push   $0x1
  80059c:	68 00 00 80 00       	push   $0x800000
  8005a1:	6a 16                	push   $0x16
  8005a3:	8d 85 80 ff ff fe    	lea    -0x1000080(%ebp),%eax
  8005a9:	50                   	push   %eax
  8005aa:	e8 19 19 00 00       	call   801ec8 <sys_check_WS_list>
  8005af:	83 c4 10             	add    $0x10,%esp
  8005b2:	89 45 e8             	mov    %eax,-0x18(%ebp)
			if (found != 1)
  8005b5:	83 7d e8 01          	cmpl   $0x1,-0x18(%ebp)
  8005b9:	74 19                	je     8005d4 <_main+0x59c>
			{ is_correct = 0; cprintf_colored(TEXT_TESTERR_CLR,"PAGE WS entry checking failed... trace it by printing page WS before & after fault\n");}
  8005bb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8005c2:	83 ec 08             	sub    $0x8,%esp
  8005c5:	68 a8 24 80 00       	push   $0x8024a8
  8005ca:	6a 0c                	push   $0xc
  8005cc:	e8 95 05 00 00       	call   800b66 <cprintf_colored>
  8005d1:	83 c4 10             	add    $0x10,%esp
		}
		cprintf_colored(TEXT_cyan, "	STEP C finished: WS is FULL now\n\n\n");
  8005d4:	83 ec 08             	sub    $0x8,%esp
  8005d7:	68 b8 25 80 00       	push   $0x8025b8
  8005dc:	6a 03                	push   $0x3
  8005de:	e8 83 05 00 00       	call   800b66 <cprintf_colored>
  8005e3:	83 c4 10             	add    $0x10,%esp
		if (is_correct)
  8005e6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8005ea:	74 04                	je     8005f0 <_main+0x5b8>
		{
			eval += 20;
  8005ec:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
		}
	}
	cprintf_colored(TEXT_light_green, "%~\nTest of KERNEL STACK & PAGE PLACEMENT completed. Eval = %d%\n\n", eval);
  8005f0:	83 ec 04             	sub    $0x4,%esp
  8005f3:	ff 75 f4             	pushl  -0xc(%ebp)
  8005f6:	68 dc 25 80 00       	push   $0x8025dc
  8005fb:	6a 0a                	push   $0xa
  8005fd:	e8 64 05 00 00       	call   800b66 <cprintf_colored>
  800602:	83 c4 10             	add    $0x10,%esp

	return;
  800605:	90                   	nop
#endif
}
  800606:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800609:	c9                   	leave  
  80060a:	c3                   	ret    

0080060b <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  80060b:	55                   	push   %ebp
  80060c:	89 e5                	mov    %esp,%ebp
  80060e:	57                   	push   %edi
  80060f:	56                   	push   %esi
  800610:	53                   	push   %ebx
  800611:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  800617:	e8 e9 16 00 00       	call   801d05 <sys_getenvindex>
  80061c:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  80061f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800622:	89 d0                	mov    %edx,%eax
  800624:	c1 e0 03             	shl    $0x3,%eax
  800627:	01 d0                	add    %edx,%eax
  800629:	c1 e0 06             	shl    $0x6,%eax
  80062c:	01 d0                	add    %edx,%eax
  80062e:	c1 e0 03             	shl    $0x3,%eax
  800631:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800636:	a3 60 30 80 00       	mov    %eax,0x803060

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80063b:	a1 60 30 80 00       	mov    0x803060,%eax
  800640:	8a 40 10             	mov    0x10(%eax),%al
  800643:	84 c0                	test   %al,%al
  800645:	74 0d                	je     800654 <libmain+0x49>
		binaryname = myEnv->prog_name;
  800647:	a1 60 30 80 00       	mov    0x803060,%eax
  80064c:	83 c0 10             	add    $0x10,%eax
  80064f:	a3 40 30 80 00       	mov    %eax,0x803040

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800654:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800658:	7e 0a                	jle    800664 <libmain+0x59>
		binaryname = argv[0];
  80065a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80065d:	8b 00                	mov    (%eax),%eax
  80065f:	a3 40 30 80 00       	mov    %eax,0x803040

	// call user main routine
	_main(argc, argv);
  800664:	83 ec 08             	sub    $0x8,%esp
  800667:	ff 75 0c             	pushl  0xc(%ebp)
  80066a:	ff 75 08             	pushl  0x8(%ebp)
  80066d:	e8 c6 f9 ff ff       	call   800038 <_main>
  800672:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  800675:	a1 3c 30 80 00       	mov    0x80303c,%eax
  80067a:	85 c0                	test   %eax,%eax
  80067c:	0f 84 b7 01 00 00    	je     800839 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  800682:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800688:	bb 5c 27 80 00       	mov    $0x80275c,%ebx
  80068d:	ba 0e 00 00 00       	mov    $0xe,%edx
  800692:	89 c7                	mov    %eax,%edi
  800694:	89 de                	mov    %ebx,%esi
  800696:	89 d1                	mov    %edx,%ecx
  800698:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80069a:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  8006a0:	b9 56 00 00 00       	mov    $0x56,%ecx
  8006a5:	b0 00                	mov    $0x0,%al
  8006a7:	89 d7                	mov    %edx,%edi
  8006a9:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  8006ab:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  8006b2:	8d 45 d8             	lea    -0x28(%ebp),%eax
  8006b5:	83 ec 08             	sub    $0x8,%esp
  8006b8:	50                   	push   %eax
  8006b9:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8006bf:	50                   	push   %eax
  8006c0:	e8 40 18 00 00       	call   801f05 <sys_utilities>
  8006c5:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8006c8:	e8 c0 13 00 00       	call   801a8d <sys_lock_cons>
		{
			cprintf("**************************************\n");
  8006cd:	83 ec 0c             	sub    $0xc,%esp
  8006d0:	68 38 26 80 00       	push   $0x802638
  8006d5:	e8 5f 04 00 00       	call   800b39 <cprintf>
  8006da:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  8006dd:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006e0:	85 c0                	test   %eax,%eax
  8006e2:	74 58                	je     80073c <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  8006e4:	e8 3a 18 00 00       	call   801f23 <sys_get_optimal_num_faults>
  8006e9:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  8006ec:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8006f2:	bb c0 27 80 00       	mov    $0x8027c0,%ebx
  8006f7:	ba 11 00 00 00       	mov    $0x11,%edx
  8006fc:	89 c7                	mov    %eax,%edi
  8006fe:	89 de                	mov    %ebx,%esi
  800700:	89 d1                	mov    %edx,%ecx
  800702:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800704:	8d 55 85             	lea    -0x7b(%ebp),%edx
  800707:	b9 53 00 00 00       	mov    $0x53,%ecx
  80070c:	b0 00                	mov    $0x0,%al
  80070e:	89 d7                	mov    %edx,%edi
  800710:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  800712:	83 ec 08             	sub    $0x8,%esp
  800715:	ff 75 dc             	pushl  -0x24(%ebp)
  800718:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  80071e:	50                   	push   %eax
  80071f:	e8 e1 17 00 00       	call   801f05 <sys_utilities>
  800724:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  800727:	83 ec 08             	sub    $0x8,%esp
  80072a:	ff 75 dc             	pushl  -0x24(%ebp)
  80072d:	68 60 26 80 00       	push   $0x802660
  800732:	e8 02 04 00 00       	call   800b39 <cprintf>
  800737:	83 c4 10             	add    $0x10,%esp
  80073a:	eb 59                	jmp    800795 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80073c:	a1 60 30 80 00       	mov    0x803060,%eax
  800741:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  800747:	a1 60 30 80 00       	mov    0x803060,%eax
  80074c:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  800752:	83 ec 04             	sub    $0x4,%esp
  800755:	52                   	push   %edx
  800756:	50                   	push   %eax
  800757:	68 84 26 80 00       	push   $0x802684
  80075c:	e8 d8 03 00 00       	call   800b39 <cprintf>
  800761:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  800764:	a1 60 30 80 00       	mov    0x803060,%eax
  800769:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  80076f:	a1 60 30 80 00       	mov    0x803060,%eax
  800774:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  80077a:	a1 60 30 80 00       	mov    0x803060,%eax
  80077f:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  800785:	51                   	push   %ecx
  800786:	52                   	push   %edx
  800787:	50                   	push   %eax
  800788:	68 ac 26 80 00       	push   $0x8026ac
  80078d:	e8 a7 03 00 00       	call   800b39 <cprintf>
  800792:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800795:	a1 60 30 80 00       	mov    0x803060,%eax
  80079a:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  8007a0:	83 ec 08             	sub    $0x8,%esp
  8007a3:	50                   	push   %eax
  8007a4:	68 04 27 80 00       	push   $0x802704
  8007a9:	e8 8b 03 00 00       	call   800b39 <cprintf>
  8007ae:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  8007b1:	83 ec 0c             	sub    $0xc,%esp
  8007b4:	68 18 27 80 00       	push   $0x802718
  8007b9:	e8 7b 03 00 00       	call   800b39 <cprintf>
  8007be:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  8007c1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8007c8:	eb 28                	jmp    8007f2 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  8007ca:	a1 60 30 80 00       	mov    0x803060,%eax
  8007cf:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8007d2:	81 c2 74 04 00 00    	add    $0x474,%edx
  8007d8:	8b 04 90             	mov    (%eax,%edx,4),%eax
  8007db:	83 ec 04             	sub    $0x4,%esp
  8007de:	50                   	push   %eax
  8007df:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007e2:	68 2f 27 80 00       	push   $0x80272f
  8007e7:	e8 4d 03 00 00       	call   800b39 <cprintf>
  8007ec:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  8007ef:	ff 45 e4             	incl   -0x1c(%ebp)
  8007f2:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8007f6:	7e d2                	jle    8007ca <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  8007f8:	83 ec 0c             	sub    $0xc,%esp
  8007fb:	68 3e 27 80 00       	push   $0x80273e
  800800:	e8 34 03 00 00       	call   800b39 <cprintf>
  800805:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  800808:	a1 60 30 80 00       	mov    0x803060,%eax
  80080d:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  800813:	83 ec 08             	sub    $0x8,%esp
  800816:	50                   	push   %eax
  800817:	68 42 27 80 00       	push   $0x802742
  80081c:	e8 18 03 00 00       	call   800b39 <cprintf>
  800821:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  800824:	83 ec 0c             	sub    $0xc,%esp
  800827:	68 38 26 80 00       	push   $0x802638
  80082c:	e8 08 03 00 00       	call   800b39 <cprintf>
  800831:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  800834:	e8 6e 12 00 00       	call   801aa7 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  800839:	e8 1f 00 00 00       	call   80085d <exit>
}
  80083e:	90                   	nop
  80083f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800842:	5b                   	pop    %ebx
  800843:	5e                   	pop    %esi
  800844:	5f                   	pop    %edi
  800845:	5d                   	pop    %ebp
  800846:	c3                   	ret    

00800847 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800847:	55                   	push   %ebp
  800848:	89 e5                	mov    %esp,%ebp
  80084a:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  80084d:	83 ec 0c             	sub    $0xc,%esp
  800850:	6a 00                	push   $0x0
  800852:	e8 7a 14 00 00       	call   801cd1 <sys_destroy_env>
  800857:	83 c4 10             	add    $0x10,%esp
}
  80085a:	90                   	nop
  80085b:	c9                   	leave  
  80085c:	c3                   	ret    

0080085d <exit>:

void
exit(void)
{
  80085d:	55                   	push   %ebp
  80085e:	89 e5                	mov    %esp,%ebp
  800860:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  800863:	e8 cf 14 00 00       	call   801d37 <sys_exit_env>
}
  800868:	90                   	nop
  800869:	c9                   	leave  
  80086a:	c3                   	ret    

0080086b <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80086b:	55                   	push   %ebp
  80086c:	89 e5                	mov    %esp,%ebp
  80086e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800871:	8d 45 10             	lea    0x10(%ebp),%eax
  800874:	83 c0 04             	add    $0x4,%eax
  800877:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80087a:	a1 68 31 80 00       	mov    0x803168,%eax
  80087f:	85 c0                	test   %eax,%eax
  800881:	74 16                	je     800899 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800883:	a1 68 31 80 00       	mov    0x803168,%eax
  800888:	83 ec 08             	sub    $0x8,%esp
  80088b:	50                   	push   %eax
  80088c:	68 24 28 80 00       	push   $0x802824
  800891:	e8 a3 02 00 00       	call   800b39 <cprintf>
  800896:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  800899:	a1 40 30 80 00       	mov    0x803040,%eax
  80089e:	83 ec 0c             	sub    $0xc,%esp
  8008a1:	ff 75 0c             	pushl  0xc(%ebp)
  8008a4:	ff 75 08             	pushl  0x8(%ebp)
  8008a7:	50                   	push   %eax
  8008a8:	68 2c 28 80 00       	push   $0x80282c
  8008ad:	6a 74                	push   $0x74
  8008af:	e8 b2 02 00 00       	call   800b66 <cprintf_colored>
  8008b4:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  8008b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8008ba:	83 ec 08             	sub    $0x8,%esp
  8008bd:	ff 75 f4             	pushl  -0xc(%ebp)
  8008c0:	50                   	push   %eax
  8008c1:	e8 04 02 00 00       	call   800aca <vcprintf>
  8008c6:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8008c9:	83 ec 08             	sub    $0x8,%esp
  8008cc:	6a 00                	push   $0x0
  8008ce:	68 54 28 80 00       	push   $0x802854
  8008d3:	e8 f2 01 00 00       	call   800aca <vcprintf>
  8008d8:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8008db:	e8 7d ff ff ff       	call   80085d <exit>

	// should not return here
	while (1) ;
  8008e0:	eb fe                	jmp    8008e0 <_panic+0x75>

008008e2 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8008e2:	55                   	push   %ebp
  8008e3:	89 e5                	mov    %esp,%ebp
  8008e5:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8008e8:	a1 60 30 80 00       	mov    0x803060,%eax
  8008ed:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8008f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008f6:	39 c2                	cmp    %eax,%edx
  8008f8:	74 14                	je     80090e <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8008fa:	83 ec 04             	sub    $0x4,%esp
  8008fd:	68 58 28 80 00       	push   $0x802858
  800902:	6a 26                	push   $0x26
  800904:	68 a4 28 80 00       	push   $0x8028a4
  800909:	e8 5d ff ff ff       	call   80086b <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80090e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800915:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80091c:	e9 c5 00 00 00       	jmp    8009e6 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  800921:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800924:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80092b:	8b 45 08             	mov    0x8(%ebp),%eax
  80092e:	01 d0                	add    %edx,%eax
  800930:	8b 00                	mov    (%eax),%eax
  800932:	85 c0                	test   %eax,%eax
  800934:	75 08                	jne    80093e <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  800936:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800939:	e9 a5 00 00 00       	jmp    8009e3 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  80093e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800945:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80094c:	eb 69                	jmp    8009b7 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80094e:	a1 60 30 80 00       	mov    0x803060,%eax
  800953:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800959:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80095c:	89 d0                	mov    %edx,%eax
  80095e:	01 c0                	add    %eax,%eax
  800960:	01 d0                	add    %edx,%eax
  800962:	c1 e0 03             	shl    $0x3,%eax
  800965:	01 c8                	add    %ecx,%eax
  800967:	8a 40 04             	mov    0x4(%eax),%al
  80096a:	84 c0                	test   %al,%al
  80096c:	75 46                	jne    8009b4 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80096e:	a1 60 30 80 00       	mov    0x803060,%eax
  800973:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800979:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80097c:	89 d0                	mov    %edx,%eax
  80097e:	01 c0                	add    %eax,%eax
  800980:	01 d0                	add    %edx,%eax
  800982:	c1 e0 03             	shl    $0x3,%eax
  800985:	01 c8                	add    %ecx,%eax
  800987:	8b 00                	mov    (%eax),%eax
  800989:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80098c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80098f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800994:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800996:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800999:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8009a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a3:	01 c8                	add    %ecx,%eax
  8009a5:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009a7:	39 c2                	cmp    %eax,%edx
  8009a9:	75 09                	jne    8009b4 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  8009ab:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8009b2:	eb 15                	jmp    8009c9 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009b4:	ff 45 e8             	incl   -0x18(%ebp)
  8009b7:	a1 60 30 80 00       	mov    0x803060,%eax
  8009bc:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8009c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8009c5:	39 c2                	cmp    %eax,%edx
  8009c7:	77 85                	ja     80094e <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8009c9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8009cd:	75 14                	jne    8009e3 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  8009cf:	83 ec 04             	sub    $0x4,%esp
  8009d2:	68 b0 28 80 00       	push   $0x8028b0
  8009d7:	6a 3a                	push   $0x3a
  8009d9:	68 a4 28 80 00       	push   $0x8028a4
  8009de:	e8 88 fe ff ff       	call   80086b <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8009e3:	ff 45 f0             	incl   -0x10(%ebp)
  8009e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009e9:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8009ec:	0f 8c 2f ff ff ff    	jl     800921 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8009f2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009f9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800a00:	eb 26                	jmp    800a28 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800a02:	a1 60 30 80 00       	mov    0x803060,%eax
  800a07:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800a0d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a10:	89 d0                	mov    %edx,%eax
  800a12:	01 c0                	add    %eax,%eax
  800a14:	01 d0                	add    %edx,%eax
  800a16:	c1 e0 03             	shl    $0x3,%eax
  800a19:	01 c8                	add    %ecx,%eax
  800a1b:	8a 40 04             	mov    0x4(%eax),%al
  800a1e:	3c 01                	cmp    $0x1,%al
  800a20:	75 03                	jne    800a25 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  800a22:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a25:	ff 45 e0             	incl   -0x20(%ebp)
  800a28:	a1 60 30 80 00       	mov    0x803060,%eax
  800a2d:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800a33:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a36:	39 c2                	cmp    %eax,%edx
  800a38:	77 c8                	ja     800a02 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800a3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a3d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800a40:	74 14                	je     800a56 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  800a42:	83 ec 04             	sub    $0x4,%esp
  800a45:	68 04 29 80 00       	push   $0x802904
  800a4a:	6a 44                	push   $0x44
  800a4c:	68 a4 28 80 00       	push   $0x8028a4
  800a51:	e8 15 fe ff ff       	call   80086b <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800a56:	90                   	nop
  800a57:	c9                   	leave  
  800a58:	c3                   	ret    

00800a59 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800a59:	55                   	push   %ebp
  800a5a:	89 e5                	mov    %esp,%ebp
  800a5c:	53                   	push   %ebx
  800a5d:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800a60:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a63:	8b 00                	mov    (%eax),%eax
  800a65:	8d 48 01             	lea    0x1(%eax),%ecx
  800a68:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a6b:	89 0a                	mov    %ecx,(%edx)
  800a6d:	8b 55 08             	mov    0x8(%ebp),%edx
  800a70:	88 d1                	mov    %dl,%cl
  800a72:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a75:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800a79:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a7c:	8b 00                	mov    (%eax),%eax
  800a7e:	3d ff 00 00 00       	cmp    $0xff,%eax
  800a83:	75 30                	jne    800ab5 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800a85:	8b 15 6c 31 80 00    	mov    0x80316c,%edx
  800a8b:	a0 80 30 80 00       	mov    0x803080,%al
  800a90:	0f b6 c0             	movzbl %al,%eax
  800a93:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800a96:	8b 09                	mov    (%ecx),%ecx
  800a98:	89 cb                	mov    %ecx,%ebx
  800a9a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800a9d:	83 c1 08             	add    $0x8,%ecx
  800aa0:	52                   	push   %edx
  800aa1:	50                   	push   %eax
  800aa2:	53                   	push   %ebx
  800aa3:	51                   	push   %ecx
  800aa4:	e8 a0 0f 00 00       	call   801a49 <sys_cputs>
  800aa9:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800aac:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aaf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800ab5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab8:	8b 40 04             	mov    0x4(%eax),%eax
  800abb:	8d 50 01             	lea    0x1(%eax),%edx
  800abe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac1:	89 50 04             	mov    %edx,0x4(%eax)
}
  800ac4:	90                   	nop
  800ac5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ac8:	c9                   	leave  
  800ac9:	c3                   	ret    

00800aca <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800aca:	55                   	push   %ebp
  800acb:	89 e5                	mov    %esp,%ebp
  800acd:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800ad3:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800ada:	00 00 00 
	b.cnt = 0;
  800add:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800ae4:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800ae7:	ff 75 0c             	pushl  0xc(%ebp)
  800aea:	ff 75 08             	pushl  0x8(%ebp)
  800aed:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800af3:	50                   	push   %eax
  800af4:	68 59 0a 80 00       	push   $0x800a59
  800af9:	e8 5a 02 00 00       	call   800d58 <vprintfmt>
  800afe:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800b01:	8b 15 6c 31 80 00    	mov    0x80316c,%edx
  800b07:	a0 80 30 80 00       	mov    0x803080,%al
  800b0c:	0f b6 c0             	movzbl %al,%eax
  800b0f:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800b15:	52                   	push   %edx
  800b16:	50                   	push   %eax
  800b17:	51                   	push   %ecx
  800b18:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b1e:	83 c0 08             	add    $0x8,%eax
  800b21:	50                   	push   %eax
  800b22:	e8 22 0f 00 00       	call   801a49 <sys_cputs>
  800b27:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800b2a:	c6 05 80 30 80 00 00 	movb   $0x0,0x803080
	return b.cnt;
  800b31:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800b37:	c9                   	leave  
  800b38:	c3                   	ret    

00800b39 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800b39:	55                   	push   %ebp
  800b3a:	89 e5                	mov    %esp,%ebp
  800b3c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b3f:	c6 05 80 30 80 00 01 	movb   $0x1,0x803080
	va_start(ap, fmt);
  800b46:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b49:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4f:	83 ec 08             	sub    $0x8,%esp
  800b52:	ff 75 f4             	pushl  -0xc(%ebp)
  800b55:	50                   	push   %eax
  800b56:	e8 6f ff ff ff       	call   800aca <vcprintf>
  800b5b:	83 c4 10             	add    $0x10,%esp
  800b5e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800b61:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b64:	c9                   	leave  
  800b65:	c3                   	ret    

00800b66 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800b66:	55                   	push   %ebp
  800b67:	89 e5                	mov    %esp,%ebp
  800b69:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b6c:	c6 05 80 30 80 00 01 	movb   $0x1,0x803080
	curTextClr = (textClr << 8) ; //set text color by the given value
  800b73:	8b 45 08             	mov    0x8(%ebp),%eax
  800b76:	c1 e0 08             	shl    $0x8,%eax
  800b79:	a3 6c 31 80 00       	mov    %eax,0x80316c
	va_start(ap, fmt);
  800b7e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b81:	83 c0 04             	add    $0x4,%eax
  800b84:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b87:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b8a:	83 ec 08             	sub    $0x8,%esp
  800b8d:	ff 75 f4             	pushl  -0xc(%ebp)
  800b90:	50                   	push   %eax
  800b91:	e8 34 ff ff ff       	call   800aca <vcprintf>
  800b96:	83 c4 10             	add    $0x10,%esp
  800b99:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800b9c:	c7 05 6c 31 80 00 00 	movl   $0x700,0x80316c
  800ba3:	07 00 00 

	return cnt;
  800ba6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ba9:	c9                   	leave  
  800baa:	c3                   	ret    

00800bab <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800bab:	55                   	push   %ebp
  800bac:	89 e5                	mov    %esp,%ebp
  800bae:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800bb1:	e8 d7 0e 00 00       	call   801a8d <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800bb6:	8d 45 0c             	lea    0xc(%ebp),%eax
  800bb9:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800bbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbf:	83 ec 08             	sub    $0x8,%esp
  800bc2:	ff 75 f4             	pushl  -0xc(%ebp)
  800bc5:	50                   	push   %eax
  800bc6:	e8 ff fe ff ff       	call   800aca <vcprintf>
  800bcb:	83 c4 10             	add    $0x10,%esp
  800bce:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800bd1:	e8 d1 0e 00 00       	call   801aa7 <sys_unlock_cons>
	return cnt;
  800bd6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bd9:	c9                   	leave  
  800bda:	c3                   	ret    

00800bdb <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800bdb:	55                   	push   %ebp
  800bdc:	89 e5                	mov    %esp,%ebp
  800bde:	53                   	push   %ebx
  800bdf:	83 ec 14             	sub    $0x14,%esp
  800be2:	8b 45 10             	mov    0x10(%ebp),%eax
  800be5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800be8:	8b 45 14             	mov    0x14(%ebp),%eax
  800beb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800bee:	8b 45 18             	mov    0x18(%ebp),%eax
  800bf1:	ba 00 00 00 00       	mov    $0x0,%edx
  800bf6:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800bf9:	77 55                	ja     800c50 <printnum+0x75>
  800bfb:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800bfe:	72 05                	jb     800c05 <printnum+0x2a>
  800c00:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800c03:	77 4b                	ja     800c50 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800c05:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800c08:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800c0b:	8b 45 18             	mov    0x18(%ebp),%eax
  800c0e:	ba 00 00 00 00       	mov    $0x0,%edx
  800c13:	52                   	push   %edx
  800c14:	50                   	push   %eax
  800c15:	ff 75 f4             	pushl  -0xc(%ebp)
  800c18:	ff 75 f0             	pushl  -0x10(%ebp)
  800c1b:	e8 74 13 00 00       	call   801f94 <__udivdi3>
  800c20:	83 c4 10             	add    $0x10,%esp
  800c23:	83 ec 04             	sub    $0x4,%esp
  800c26:	ff 75 20             	pushl  0x20(%ebp)
  800c29:	53                   	push   %ebx
  800c2a:	ff 75 18             	pushl  0x18(%ebp)
  800c2d:	52                   	push   %edx
  800c2e:	50                   	push   %eax
  800c2f:	ff 75 0c             	pushl  0xc(%ebp)
  800c32:	ff 75 08             	pushl  0x8(%ebp)
  800c35:	e8 a1 ff ff ff       	call   800bdb <printnum>
  800c3a:	83 c4 20             	add    $0x20,%esp
  800c3d:	eb 1a                	jmp    800c59 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800c3f:	83 ec 08             	sub    $0x8,%esp
  800c42:	ff 75 0c             	pushl  0xc(%ebp)
  800c45:	ff 75 20             	pushl  0x20(%ebp)
  800c48:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4b:	ff d0                	call   *%eax
  800c4d:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c50:	ff 4d 1c             	decl   0x1c(%ebp)
  800c53:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c57:	7f e6                	jg     800c3f <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800c59:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c5c:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c61:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c64:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c67:	53                   	push   %ebx
  800c68:	51                   	push   %ecx
  800c69:	52                   	push   %edx
  800c6a:	50                   	push   %eax
  800c6b:	e8 34 14 00 00       	call   8020a4 <__umoddi3>
  800c70:	83 c4 10             	add    $0x10,%esp
  800c73:	05 74 2b 80 00       	add    $0x802b74,%eax
  800c78:	8a 00                	mov    (%eax),%al
  800c7a:	0f be c0             	movsbl %al,%eax
  800c7d:	83 ec 08             	sub    $0x8,%esp
  800c80:	ff 75 0c             	pushl  0xc(%ebp)
  800c83:	50                   	push   %eax
  800c84:	8b 45 08             	mov    0x8(%ebp),%eax
  800c87:	ff d0                	call   *%eax
  800c89:	83 c4 10             	add    $0x10,%esp
}
  800c8c:	90                   	nop
  800c8d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800c90:	c9                   	leave  
  800c91:	c3                   	ret    

00800c92 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800c92:	55                   	push   %ebp
  800c93:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c95:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c99:	7e 1c                	jle    800cb7 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800c9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9e:	8b 00                	mov    (%eax),%eax
  800ca0:	8d 50 08             	lea    0x8(%eax),%edx
  800ca3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca6:	89 10                	mov    %edx,(%eax)
  800ca8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cab:	8b 00                	mov    (%eax),%eax
  800cad:	83 e8 08             	sub    $0x8,%eax
  800cb0:	8b 50 04             	mov    0x4(%eax),%edx
  800cb3:	8b 00                	mov    (%eax),%eax
  800cb5:	eb 40                	jmp    800cf7 <getuint+0x65>
	else if (lflag)
  800cb7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cbb:	74 1e                	je     800cdb <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800cbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc0:	8b 00                	mov    (%eax),%eax
  800cc2:	8d 50 04             	lea    0x4(%eax),%edx
  800cc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc8:	89 10                	mov    %edx,(%eax)
  800cca:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccd:	8b 00                	mov    (%eax),%eax
  800ccf:	83 e8 04             	sub    $0x4,%eax
  800cd2:	8b 00                	mov    (%eax),%eax
  800cd4:	ba 00 00 00 00       	mov    $0x0,%edx
  800cd9:	eb 1c                	jmp    800cf7 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800cdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cde:	8b 00                	mov    (%eax),%eax
  800ce0:	8d 50 04             	lea    0x4(%eax),%edx
  800ce3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce6:	89 10                	mov    %edx,(%eax)
  800ce8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ceb:	8b 00                	mov    (%eax),%eax
  800ced:	83 e8 04             	sub    $0x4,%eax
  800cf0:	8b 00                	mov    (%eax),%eax
  800cf2:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800cf7:	5d                   	pop    %ebp
  800cf8:	c3                   	ret    

00800cf9 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800cf9:	55                   	push   %ebp
  800cfa:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800cfc:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d00:	7e 1c                	jle    800d1e <getint+0x25>
		return va_arg(*ap, long long);
  800d02:	8b 45 08             	mov    0x8(%ebp),%eax
  800d05:	8b 00                	mov    (%eax),%eax
  800d07:	8d 50 08             	lea    0x8(%eax),%edx
  800d0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0d:	89 10                	mov    %edx,(%eax)
  800d0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d12:	8b 00                	mov    (%eax),%eax
  800d14:	83 e8 08             	sub    $0x8,%eax
  800d17:	8b 50 04             	mov    0x4(%eax),%edx
  800d1a:	8b 00                	mov    (%eax),%eax
  800d1c:	eb 38                	jmp    800d56 <getint+0x5d>
	else if (lflag)
  800d1e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d22:	74 1a                	je     800d3e <getint+0x45>
		return va_arg(*ap, long);
  800d24:	8b 45 08             	mov    0x8(%ebp),%eax
  800d27:	8b 00                	mov    (%eax),%eax
  800d29:	8d 50 04             	lea    0x4(%eax),%edx
  800d2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2f:	89 10                	mov    %edx,(%eax)
  800d31:	8b 45 08             	mov    0x8(%ebp),%eax
  800d34:	8b 00                	mov    (%eax),%eax
  800d36:	83 e8 04             	sub    $0x4,%eax
  800d39:	8b 00                	mov    (%eax),%eax
  800d3b:	99                   	cltd   
  800d3c:	eb 18                	jmp    800d56 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800d3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d41:	8b 00                	mov    (%eax),%eax
  800d43:	8d 50 04             	lea    0x4(%eax),%edx
  800d46:	8b 45 08             	mov    0x8(%ebp),%eax
  800d49:	89 10                	mov    %edx,(%eax)
  800d4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4e:	8b 00                	mov    (%eax),%eax
  800d50:	83 e8 04             	sub    $0x4,%eax
  800d53:	8b 00                	mov    (%eax),%eax
  800d55:	99                   	cltd   
}
  800d56:	5d                   	pop    %ebp
  800d57:	c3                   	ret    

00800d58 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d58:	55                   	push   %ebp
  800d59:	89 e5                	mov    %esp,%ebp
  800d5b:	56                   	push   %esi
  800d5c:	53                   	push   %ebx
  800d5d:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d60:	eb 17                	jmp    800d79 <vprintfmt+0x21>
			if (ch == '\0')
  800d62:	85 db                	test   %ebx,%ebx
  800d64:	0f 84 c1 03 00 00    	je     80112b <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  800d6a:	83 ec 08             	sub    $0x8,%esp
  800d6d:	ff 75 0c             	pushl  0xc(%ebp)
  800d70:	53                   	push   %ebx
  800d71:	8b 45 08             	mov    0x8(%ebp),%eax
  800d74:	ff d0                	call   *%eax
  800d76:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d79:	8b 45 10             	mov    0x10(%ebp),%eax
  800d7c:	8d 50 01             	lea    0x1(%eax),%edx
  800d7f:	89 55 10             	mov    %edx,0x10(%ebp)
  800d82:	8a 00                	mov    (%eax),%al
  800d84:	0f b6 d8             	movzbl %al,%ebx
  800d87:	83 fb 25             	cmp    $0x25,%ebx
  800d8a:	75 d6                	jne    800d62 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800d8c:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800d90:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800d97:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800d9e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800da5:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800dac:	8b 45 10             	mov    0x10(%ebp),%eax
  800daf:	8d 50 01             	lea    0x1(%eax),%edx
  800db2:	89 55 10             	mov    %edx,0x10(%ebp)
  800db5:	8a 00                	mov    (%eax),%al
  800db7:	0f b6 d8             	movzbl %al,%ebx
  800dba:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800dbd:	83 f8 5b             	cmp    $0x5b,%eax
  800dc0:	0f 87 3d 03 00 00    	ja     801103 <vprintfmt+0x3ab>
  800dc6:	8b 04 85 98 2b 80 00 	mov    0x802b98(,%eax,4),%eax
  800dcd:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800dcf:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800dd3:	eb d7                	jmp    800dac <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800dd5:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800dd9:	eb d1                	jmp    800dac <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ddb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800de2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800de5:	89 d0                	mov    %edx,%eax
  800de7:	c1 e0 02             	shl    $0x2,%eax
  800dea:	01 d0                	add    %edx,%eax
  800dec:	01 c0                	add    %eax,%eax
  800dee:	01 d8                	add    %ebx,%eax
  800df0:	83 e8 30             	sub    $0x30,%eax
  800df3:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800df6:	8b 45 10             	mov    0x10(%ebp),%eax
  800df9:	8a 00                	mov    (%eax),%al
  800dfb:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800dfe:	83 fb 2f             	cmp    $0x2f,%ebx
  800e01:	7e 3e                	jle    800e41 <vprintfmt+0xe9>
  800e03:	83 fb 39             	cmp    $0x39,%ebx
  800e06:	7f 39                	jg     800e41 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e08:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800e0b:	eb d5                	jmp    800de2 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800e0d:	8b 45 14             	mov    0x14(%ebp),%eax
  800e10:	83 c0 04             	add    $0x4,%eax
  800e13:	89 45 14             	mov    %eax,0x14(%ebp)
  800e16:	8b 45 14             	mov    0x14(%ebp),%eax
  800e19:	83 e8 04             	sub    $0x4,%eax
  800e1c:	8b 00                	mov    (%eax),%eax
  800e1e:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800e21:	eb 1f                	jmp    800e42 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800e23:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e27:	79 83                	jns    800dac <vprintfmt+0x54>
				width = 0;
  800e29:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800e30:	e9 77 ff ff ff       	jmp    800dac <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800e35:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800e3c:	e9 6b ff ff ff       	jmp    800dac <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e41:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e42:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e46:	0f 89 60 ff ff ff    	jns    800dac <vprintfmt+0x54>
				width = precision, precision = -1;
  800e4c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e4f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e52:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800e59:	e9 4e ff ff ff       	jmp    800dac <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e5e:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e61:	e9 46 ff ff ff       	jmp    800dac <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e66:	8b 45 14             	mov    0x14(%ebp),%eax
  800e69:	83 c0 04             	add    $0x4,%eax
  800e6c:	89 45 14             	mov    %eax,0x14(%ebp)
  800e6f:	8b 45 14             	mov    0x14(%ebp),%eax
  800e72:	83 e8 04             	sub    $0x4,%eax
  800e75:	8b 00                	mov    (%eax),%eax
  800e77:	83 ec 08             	sub    $0x8,%esp
  800e7a:	ff 75 0c             	pushl  0xc(%ebp)
  800e7d:	50                   	push   %eax
  800e7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e81:	ff d0                	call   *%eax
  800e83:	83 c4 10             	add    $0x10,%esp
			break;
  800e86:	e9 9b 02 00 00       	jmp    801126 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800e8b:	8b 45 14             	mov    0x14(%ebp),%eax
  800e8e:	83 c0 04             	add    $0x4,%eax
  800e91:	89 45 14             	mov    %eax,0x14(%ebp)
  800e94:	8b 45 14             	mov    0x14(%ebp),%eax
  800e97:	83 e8 04             	sub    $0x4,%eax
  800e9a:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800e9c:	85 db                	test   %ebx,%ebx
  800e9e:	79 02                	jns    800ea2 <vprintfmt+0x14a>
				err = -err;
  800ea0:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800ea2:	83 fb 64             	cmp    $0x64,%ebx
  800ea5:	7f 0b                	jg     800eb2 <vprintfmt+0x15a>
  800ea7:	8b 34 9d e0 29 80 00 	mov    0x8029e0(,%ebx,4),%esi
  800eae:	85 f6                	test   %esi,%esi
  800eb0:	75 19                	jne    800ecb <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800eb2:	53                   	push   %ebx
  800eb3:	68 85 2b 80 00       	push   $0x802b85
  800eb8:	ff 75 0c             	pushl  0xc(%ebp)
  800ebb:	ff 75 08             	pushl  0x8(%ebp)
  800ebe:	e8 70 02 00 00       	call   801133 <printfmt>
  800ec3:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ec6:	e9 5b 02 00 00       	jmp    801126 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ecb:	56                   	push   %esi
  800ecc:	68 8e 2b 80 00       	push   $0x802b8e
  800ed1:	ff 75 0c             	pushl  0xc(%ebp)
  800ed4:	ff 75 08             	pushl  0x8(%ebp)
  800ed7:	e8 57 02 00 00       	call   801133 <printfmt>
  800edc:	83 c4 10             	add    $0x10,%esp
			break;
  800edf:	e9 42 02 00 00       	jmp    801126 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800ee4:	8b 45 14             	mov    0x14(%ebp),%eax
  800ee7:	83 c0 04             	add    $0x4,%eax
  800eea:	89 45 14             	mov    %eax,0x14(%ebp)
  800eed:	8b 45 14             	mov    0x14(%ebp),%eax
  800ef0:	83 e8 04             	sub    $0x4,%eax
  800ef3:	8b 30                	mov    (%eax),%esi
  800ef5:	85 f6                	test   %esi,%esi
  800ef7:	75 05                	jne    800efe <vprintfmt+0x1a6>
				p = "(null)";
  800ef9:	be 91 2b 80 00       	mov    $0x802b91,%esi
			if (width > 0 && padc != '-')
  800efe:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f02:	7e 6d                	jle    800f71 <vprintfmt+0x219>
  800f04:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800f08:	74 67                	je     800f71 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800f0a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f0d:	83 ec 08             	sub    $0x8,%esp
  800f10:	50                   	push   %eax
  800f11:	56                   	push   %esi
  800f12:	e8 1e 03 00 00       	call   801235 <strnlen>
  800f17:	83 c4 10             	add    $0x10,%esp
  800f1a:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800f1d:	eb 16                	jmp    800f35 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800f1f:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800f23:	83 ec 08             	sub    $0x8,%esp
  800f26:	ff 75 0c             	pushl  0xc(%ebp)
  800f29:	50                   	push   %eax
  800f2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2d:	ff d0                	call   *%eax
  800f2f:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800f32:	ff 4d e4             	decl   -0x1c(%ebp)
  800f35:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f39:	7f e4                	jg     800f1f <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f3b:	eb 34                	jmp    800f71 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800f3d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f41:	74 1c                	je     800f5f <vprintfmt+0x207>
  800f43:	83 fb 1f             	cmp    $0x1f,%ebx
  800f46:	7e 05                	jle    800f4d <vprintfmt+0x1f5>
  800f48:	83 fb 7e             	cmp    $0x7e,%ebx
  800f4b:	7e 12                	jle    800f5f <vprintfmt+0x207>
					putch('?', putdat);
  800f4d:	83 ec 08             	sub    $0x8,%esp
  800f50:	ff 75 0c             	pushl  0xc(%ebp)
  800f53:	6a 3f                	push   $0x3f
  800f55:	8b 45 08             	mov    0x8(%ebp),%eax
  800f58:	ff d0                	call   *%eax
  800f5a:	83 c4 10             	add    $0x10,%esp
  800f5d:	eb 0f                	jmp    800f6e <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f5f:	83 ec 08             	sub    $0x8,%esp
  800f62:	ff 75 0c             	pushl  0xc(%ebp)
  800f65:	53                   	push   %ebx
  800f66:	8b 45 08             	mov    0x8(%ebp),%eax
  800f69:	ff d0                	call   *%eax
  800f6b:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f6e:	ff 4d e4             	decl   -0x1c(%ebp)
  800f71:	89 f0                	mov    %esi,%eax
  800f73:	8d 70 01             	lea    0x1(%eax),%esi
  800f76:	8a 00                	mov    (%eax),%al
  800f78:	0f be d8             	movsbl %al,%ebx
  800f7b:	85 db                	test   %ebx,%ebx
  800f7d:	74 24                	je     800fa3 <vprintfmt+0x24b>
  800f7f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f83:	78 b8                	js     800f3d <vprintfmt+0x1e5>
  800f85:	ff 4d e0             	decl   -0x20(%ebp)
  800f88:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f8c:	79 af                	jns    800f3d <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f8e:	eb 13                	jmp    800fa3 <vprintfmt+0x24b>
				putch(' ', putdat);
  800f90:	83 ec 08             	sub    $0x8,%esp
  800f93:	ff 75 0c             	pushl  0xc(%ebp)
  800f96:	6a 20                	push   $0x20
  800f98:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9b:	ff d0                	call   *%eax
  800f9d:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800fa0:	ff 4d e4             	decl   -0x1c(%ebp)
  800fa3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fa7:	7f e7                	jg     800f90 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800fa9:	e9 78 01 00 00       	jmp    801126 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800fae:	83 ec 08             	sub    $0x8,%esp
  800fb1:	ff 75 e8             	pushl  -0x18(%ebp)
  800fb4:	8d 45 14             	lea    0x14(%ebp),%eax
  800fb7:	50                   	push   %eax
  800fb8:	e8 3c fd ff ff       	call   800cf9 <getint>
  800fbd:	83 c4 10             	add    $0x10,%esp
  800fc0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fc3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800fc6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fc9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fcc:	85 d2                	test   %edx,%edx
  800fce:	79 23                	jns    800ff3 <vprintfmt+0x29b>
				putch('-', putdat);
  800fd0:	83 ec 08             	sub    $0x8,%esp
  800fd3:	ff 75 0c             	pushl  0xc(%ebp)
  800fd6:	6a 2d                	push   $0x2d
  800fd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdb:	ff d0                	call   *%eax
  800fdd:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800fe0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fe3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fe6:	f7 d8                	neg    %eax
  800fe8:	83 d2 00             	adc    $0x0,%edx
  800feb:	f7 da                	neg    %edx
  800fed:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ff0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ff3:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ffa:	e9 bc 00 00 00       	jmp    8010bb <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800fff:	83 ec 08             	sub    $0x8,%esp
  801002:	ff 75 e8             	pushl  -0x18(%ebp)
  801005:	8d 45 14             	lea    0x14(%ebp),%eax
  801008:	50                   	push   %eax
  801009:	e8 84 fc ff ff       	call   800c92 <getuint>
  80100e:	83 c4 10             	add    $0x10,%esp
  801011:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801014:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801017:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80101e:	e9 98 00 00 00       	jmp    8010bb <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801023:	83 ec 08             	sub    $0x8,%esp
  801026:	ff 75 0c             	pushl  0xc(%ebp)
  801029:	6a 58                	push   $0x58
  80102b:	8b 45 08             	mov    0x8(%ebp),%eax
  80102e:	ff d0                	call   *%eax
  801030:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801033:	83 ec 08             	sub    $0x8,%esp
  801036:	ff 75 0c             	pushl  0xc(%ebp)
  801039:	6a 58                	push   $0x58
  80103b:	8b 45 08             	mov    0x8(%ebp),%eax
  80103e:	ff d0                	call   *%eax
  801040:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801043:	83 ec 08             	sub    $0x8,%esp
  801046:	ff 75 0c             	pushl  0xc(%ebp)
  801049:	6a 58                	push   $0x58
  80104b:	8b 45 08             	mov    0x8(%ebp),%eax
  80104e:	ff d0                	call   *%eax
  801050:	83 c4 10             	add    $0x10,%esp
			break;
  801053:	e9 ce 00 00 00       	jmp    801126 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  801058:	83 ec 08             	sub    $0x8,%esp
  80105b:	ff 75 0c             	pushl  0xc(%ebp)
  80105e:	6a 30                	push   $0x30
  801060:	8b 45 08             	mov    0x8(%ebp),%eax
  801063:	ff d0                	call   *%eax
  801065:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801068:	83 ec 08             	sub    $0x8,%esp
  80106b:	ff 75 0c             	pushl  0xc(%ebp)
  80106e:	6a 78                	push   $0x78
  801070:	8b 45 08             	mov    0x8(%ebp),%eax
  801073:	ff d0                	call   *%eax
  801075:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801078:	8b 45 14             	mov    0x14(%ebp),%eax
  80107b:	83 c0 04             	add    $0x4,%eax
  80107e:	89 45 14             	mov    %eax,0x14(%ebp)
  801081:	8b 45 14             	mov    0x14(%ebp),%eax
  801084:	83 e8 04             	sub    $0x4,%eax
  801087:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801089:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80108c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801093:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80109a:	eb 1f                	jmp    8010bb <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80109c:	83 ec 08             	sub    $0x8,%esp
  80109f:	ff 75 e8             	pushl  -0x18(%ebp)
  8010a2:	8d 45 14             	lea    0x14(%ebp),%eax
  8010a5:	50                   	push   %eax
  8010a6:	e8 e7 fb ff ff       	call   800c92 <getuint>
  8010ab:	83 c4 10             	add    $0x10,%esp
  8010ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010b1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8010b4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8010bb:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8010bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010c2:	83 ec 04             	sub    $0x4,%esp
  8010c5:	52                   	push   %edx
  8010c6:	ff 75 e4             	pushl  -0x1c(%ebp)
  8010c9:	50                   	push   %eax
  8010ca:	ff 75 f4             	pushl  -0xc(%ebp)
  8010cd:	ff 75 f0             	pushl  -0x10(%ebp)
  8010d0:	ff 75 0c             	pushl  0xc(%ebp)
  8010d3:	ff 75 08             	pushl  0x8(%ebp)
  8010d6:	e8 00 fb ff ff       	call   800bdb <printnum>
  8010db:	83 c4 20             	add    $0x20,%esp
			break;
  8010de:	eb 46                	jmp    801126 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8010e0:	83 ec 08             	sub    $0x8,%esp
  8010e3:	ff 75 0c             	pushl  0xc(%ebp)
  8010e6:	53                   	push   %ebx
  8010e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ea:	ff d0                	call   *%eax
  8010ec:	83 c4 10             	add    $0x10,%esp
			break;
  8010ef:	eb 35                	jmp    801126 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  8010f1:	c6 05 80 30 80 00 00 	movb   $0x0,0x803080
			break;
  8010f8:	eb 2c                	jmp    801126 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  8010fa:	c6 05 80 30 80 00 01 	movb   $0x1,0x803080
			break;
  801101:	eb 23                	jmp    801126 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801103:	83 ec 08             	sub    $0x8,%esp
  801106:	ff 75 0c             	pushl  0xc(%ebp)
  801109:	6a 25                	push   $0x25
  80110b:	8b 45 08             	mov    0x8(%ebp),%eax
  80110e:	ff d0                	call   *%eax
  801110:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801113:	ff 4d 10             	decl   0x10(%ebp)
  801116:	eb 03                	jmp    80111b <vprintfmt+0x3c3>
  801118:	ff 4d 10             	decl   0x10(%ebp)
  80111b:	8b 45 10             	mov    0x10(%ebp),%eax
  80111e:	48                   	dec    %eax
  80111f:	8a 00                	mov    (%eax),%al
  801121:	3c 25                	cmp    $0x25,%al
  801123:	75 f3                	jne    801118 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  801125:	90                   	nop
		}
	}
  801126:	e9 35 fc ff ff       	jmp    800d60 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80112b:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80112c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80112f:	5b                   	pop    %ebx
  801130:	5e                   	pop    %esi
  801131:	5d                   	pop    %ebp
  801132:	c3                   	ret    

00801133 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801133:	55                   	push   %ebp
  801134:	89 e5                	mov    %esp,%ebp
  801136:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801139:	8d 45 10             	lea    0x10(%ebp),%eax
  80113c:	83 c0 04             	add    $0x4,%eax
  80113f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801142:	8b 45 10             	mov    0x10(%ebp),%eax
  801145:	ff 75 f4             	pushl  -0xc(%ebp)
  801148:	50                   	push   %eax
  801149:	ff 75 0c             	pushl  0xc(%ebp)
  80114c:	ff 75 08             	pushl  0x8(%ebp)
  80114f:	e8 04 fc ff ff       	call   800d58 <vprintfmt>
  801154:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801157:	90                   	nop
  801158:	c9                   	leave  
  801159:	c3                   	ret    

0080115a <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80115a:	55                   	push   %ebp
  80115b:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80115d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801160:	8b 40 08             	mov    0x8(%eax),%eax
  801163:	8d 50 01             	lea    0x1(%eax),%edx
  801166:	8b 45 0c             	mov    0xc(%ebp),%eax
  801169:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80116c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116f:	8b 10                	mov    (%eax),%edx
  801171:	8b 45 0c             	mov    0xc(%ebp),%eax
  801174:	8b 40 04             	mov    0x4(%eax),%eax
  801177:	39 c2                	cmp    %eax,%edx
  801179:	73 12                	jae    80118d <sprintputch+0x33>
		*b->buf++ = ch;
  80117b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117e:	8b 00                	mov    (%eax),%eax
  801180:	8d 48 01             	lea    0x1(%eax),%ecx
  801183:	8b 55 0c             	mov    0xc(%ebp),%edx
  801186:	89 0a                	mov    %ecx,(%edx)
  801188:	8b 55 08             	mov    0x8(%ebp),%edx
  80118b:	88 10                	mov    %dl,(%eax)
}
  80118d:	90                   	nop
  80118e:	5d                   	pop    %ebp
  80118f:	c3                   	ret    

00801190 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801190:	55                   	push   %ebp
  801191:	89 e5                	mov    %esp,%ebp
  801193:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801196:	8b 45 08             	mov    0x8(%ebp),%eax
  801199:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80119c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80119f:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a5:	01 d0                	add    %edx,%eax
  8011a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011aa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8011b1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011b5:	74 06                	je     8011bd <vsnprintf+0x2d>
  8011b7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011bb:	7f 07                	jg     8011c4 <vsnprintf+0x34>
		return -E_INVAL;
  8011bd:	b8 03 00 00 00       	mov    $0x3,%eax
  8011c2:	eb 20                	jmp    8011e4 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8011c4:	ff 75 14             	pushl  0x14(%ebp)
  8011c7:	ff 75 10             	pushl  0x10(%ebp)
  8011ca:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8011cd:	50                   	push   %eax
  8011ce:	68 5a 11 80 00       	push   $0x80115a
  8011d3:	e8 80 fb ff ff       	call   800d58 <vprintfmt>
  8011d8:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8011db:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011de:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8011e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8011e4:	c9                   	leave  
  8011e5:	c3                   	ret    

008011e6 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8011e6:	55                   	push   %ebp
  8011e7:	89 e5                	mov    %esp,%ebp
  8011e9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8011ec:	8d 45 10             	lea    0x10(%ebp),%eax
  8011ef:	83 c0 04             	add    $0x4,%eax
  8011f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8011f5:	8b 45 10             	mov    0x10(%ebp),%eax
  8011f8:	ff 75 f4             	pushl  -0xc(%ebp)
  8011fb:	50                   	push   %eax
  8011fc:	ff 75 0c             	pushl  0xc(%ebp)
  8011ff:	ff 75 08             	pushl  0x8(%ebp)
  801202:	e8 89 ff ff ff       	call   801190 <vsnprintf>
  801207:	83 c4 10             	add    $0x10,%esp
  80120a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80120d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801210:	c9                   	leave  
  801211:	c3                   	ret    

00801212 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801212:	55                   	push   %ebp
  801213:	89 e5                	mov    %esp,%ebp
  801215:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801218:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80121f:	eb 06                	jmp    801227 <strlen+0x15>
		n++;
  801221:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801224:	ff 45 08             	incl   0x8(%ebp)
  801227:	8b 45 08             	mov    0x8(%ebp),%eax
  80122a:	8a 00                	mov    (%eax),%al
  80122c:	84 c0                	test   %al,%al
  80122e:	75 f1                	jne    801221 <strlen+0xf>
		n++;
	return n;
  801230:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801233:	c9                   	leave  
  801234:	c3                   	ret    

00801235 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801235:	55                   	push   %ebp
  801236:	89 e5                	mov    %esp,%ebp
  801238:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80123b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801242:	eb 09                	jmp    80124d <strnlen+0x18>
		n++;
  801244:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801247:	ff 45 08             	incl   0x8(%ebp)
  80124a:	ff 4d 0c             	decl   0xc(%ebp)
  80124d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801251:	74 09                	je     80125c <strnlen+0x27>
  801253:	8b 45 08             	mov    0x8(%ebp),%eax
  801256:	8a 00                	mov    (%eax),%al
  801258:	84 c0                	test   %al,%al
  80125a:	75 e8                	jne    801244 <strnlen+0xf>
		n++;
	return n;
  80125c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80125f:	c9                   	leave  
  801260:	c3                   	ret    

00801261 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801261:	55                   	push   %ebp
  801262:	89 e5                	mov    %esp,%ebp
  801264:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801267:	8b 45 08             	mov    0x8(%ebp),%eax
  80126a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80126d:	90                   	nop
  80126e:	8b 45 08             	mov    0x8(%ebp),%eax
  801271:	8d 50 01             	lea    0x1(%eax),%edx
  801274:	89 55 08             	mov    %edx,0x8(%ebp)
  801277:	8b 55 0c             	mov    0xc(%ebp),%edx
  80127a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80127d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801280:	8a 12                	mov    (%edx),%dl
  801282:	88 10                	mov    %dl,(%eax)
  801284:	8a 00                	mov    (%eax),%al
  801286:	84 c0                	test   %al,%al
  801288:	75 e4                	jne    80126e <strcpy+0xd>
		/* do nothing */;
	return ret;
  80128a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80128d:	c9                   	leave  
  80128e:	c3                   	ret    

0080128f <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80128f:	55                   	push   %ebp
  801290:	89 e5                	mov    %esp,%ebp
  801292:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801295:	8b 45 08             	mov    0x8(%ebp),%eax
  801298:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80129b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012a2:	eb 1f                	jmp    8012c3 <strncpy+0x34>
		*dst++ = *src;
  8012a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a7:	8d 50 01             	lea    0x1(%eax),%edx
  8012aa:	89 55 08             	mov    %edx,0x8(%ebp)
  8012ad:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012b0:	8a 12                	mov    (%edx),%dl
  8012b2:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8012b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b7:	8a 00                	mov    (%eax),%al
  8012b9:	84 c0                	test   %al,%al
  8012bb:	74 03                	je     8012c0 <strncpy+0x31>
			src++;
  8012bd:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8012c0:	ff 45 fc             	incl   -0x4(%ebp)
  8012c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012c6:	3b 45 10             	cmp    0x10(%ebp),%eax
  8012c9:	72 d9                	jb     8012a4 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8012cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012ce:	c9                   	leave  
  8012cf:	c3                   	ret    

008012d0 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8012d0:	55                   	push   %ebp
  8012d1:	89 e5                	mov    %esp,%ebp
  8012d3:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8012d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8012dc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012e0:	74 30                	je     801312 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8012e2:	eb 16                	jmp    8012fa <strlcpy+0x2a>
			*dst++ = *src++;
  8012e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e7:	8d 50 01             	lea    0x1(%eax),%edx
  8012ea:	89 55 08             	mov    %edx,0x8(%ebp)
  8012ed:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012f0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012f3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012f6:	8a 12                	mov    (%edx),%dl
  8012f8:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8012fa:	ff 4d 10             	decl   0x10(%ebp)
  8012fd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801301:	74 09                	je     80130c <strlcpy+0x3c>
  801303:	8b 45 0c             	mov    0xc(%ebp),%eax
  801306:	8a 00                	mov    (%eax),%al
  801308:	84 c0                	test   %al,%al
  80130a:	75 d8                	jne    8012e4 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80130c:	8b 45 08             	mov    0x8(%ebp),%eax
  80130f:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801312:	8b 55 08             	mov    0x8(%ebp),%edx
  801315:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801318:	29 c2                	sub    %eax,%edx
  80131a:	89 d0                	mov    %edx,%eax
}
  80131c:	c9                   	leave  
  80131d:	c3                   	ret    

0080131e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80131e:	55                   	push   %ebp
  80131f:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801321:	eb 06                	jmp    801329 <strcmp+0xb>
		p++, q++;
  801323:	ff 45 08             	incl   0x8(%ebp)
  801326:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801329:	8b 45 08             	mov    0x8(%ebp),%eax
  80132c:	8a 00                	mov    (%eax),%al
  80132e:	84 c0                	test   %al,%al
  801330:	74 0e                	je     801340 <strcmp+0x22>
  801332:	8b 45 08             	mov    0x8(%ebp),%eax
  801335:	8a 10                	mov    (%eax),%dl
  801337:	8b 45 0c             	mov    0xc(%ebp),%eax
  80133a:	8a 00                	mov    (%eax),%al
  80133c:	38 c2                	cmp    %al,%dl
  80133e:	74 e3                	je     801323 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801340:	8b 45 08             	mov    0x8(%ebp),%eax
  801343:	8a 00                	mov    (%eax),%al
  801345:	0f b6 d0             	movzbl %al,%edx
  801348:	8b 45 0c             	mov    0xc(%ebp),%eax
  80134b:	8a 00                	mov    (%eax),%al
  80134d:	0f b6 c0             	movzbl %al,%eax
  801350:	29 c2                	sub    %eax,%edx
  801352:	89 d0                	mov    %edx,%eax
}
  801354:	5d                   	pop    %ebp
  801355:	c3                   	ret    

00801356 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801356:	55                   	push   %ebp
  801357:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801359:	eb 09                	jmp    801364 <strncmp+0xe>
		n--, p++, q++;
  80135b:	ff 4d 10             	decl   0x10(%ebp)
  80135e:	ff 45 08             	incl   0x8(%ebp)
  801361:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801364:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801368:	74 17                	je     801381 <strncmp+0x2b>
  80136a:	8b 45 08             	mov    0x8(%ebp),%eax
  80136d:	8a 00                	mov    (%eax),%al
  80136f:	84 c0                	test   %al,%al
  801371:	74 0e                	je     801381 <strncmp+0x2b>
  801373:	8b 45 08             	mov    0x8(%ebp),%eax
  801376:	8a 10                	mov    (%eax),%dl
  801378:	8b 45 0c             	mov    0xc(%ebp),%eax
  80137b:	8a 00                	mov    (%eax),%al
  80137d:	38 c2                	cmp    %al,%dl
  80137f:	74 da                	je     80135b <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801381:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801385:	75 07                	jne    80138e <strncmp+0x38>
		return 0;
  801387:	b8 00 00 00 00       	mov    $0x0,%eax
  80138c:	eb 14                	jmp    8013a2 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80138e:	8b 45 08             	mov    0x8(%ebp),%eax
  801391:	8a 00                	mov    (%eax),%al
  801393:	0f b6 d0             	movzbl %al,%edx
  801396:	8b 45 0c             	mov    0xc(%ebp),%eax
  801399:	8a 00                	mov    (%eax),%al
  80139b:	0f b6 c0             	movzbl %al,%eax
  80139e:	29 c2                	sub    %eax,%edx
  8013a0:	89 d0                	mov    %edx,%eax
}
  8013a2:	5d                   	pop    %ebp
  8013a3:	c3                   	ret    

008013a4 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8013a4:	55                   	push   %ebp
  8013a5:	89 e5                	mov    %esp,%ebp
  8013a7:	83 ec 04             	sub    $0x4,%esp
  8013aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ad:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013b0:	eb 12                	jmp    8013c4 <strchr+0x20>
		if (*s == c)
  8013b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b5:	8a 00                	mov    (%eax),%al
  8013b7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013ba:	75 05                	jne    8013c1 <strchr+0x1d>
			return (char *) s;
  8013bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bf:	eb 11                	jmp    8013d2 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8013c1:	ff 45 08             	incl   0x8(%ebp)
  8013c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c7:	8a 00                	mov    (%eax),%al
  8013c9:	84 c0                	test   %al,%al
  8013cb:	75 e5                	jne    8013b2 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8013cd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8013d2:	c9                   	leave  
  8013d3:	c3                   	ret    

008013d4 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8013d4:	55                   	push   %ebp
  8013d5:	89 e5                	mov    %esp,%ebp
  8013d7:	83 ec 04             	sub    $0x4,%esp
  8013da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013dd:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013e0:	eb 0d                	jmp    8013ef <strfind+0x1b>
		if (*s == c)
  8013e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e5:	8a 00                	mov    (%eax),%al
  8013e7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013ea:	74 0e                	je     8013fa <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8013ec:	ff 45 08             	incl   0x8(%ebp)
  8013ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f2:	8a 00                	mov    (%eax),%al
  8013f4:	84 c0                	test   %al,%al
  8013f6:	75 ea                	jne    8013e2 <strfind+0xe>
  8013f8:	eb 01                	jmp    8013fb <strfind+0x27>
		if (*s == c)
			break;
  8013fa:	90                   	nop
	return (char *) s;
  8013fb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013fe:	c9                   	leave  
  8013ff:	c3                   	ret    

00801400 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  801400:	55                   	push   %ebp
  801401:	89 e5                	mov    %esp,%ebp
  801403:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  801406:	8b 45 08             	mov    0x8(%ebp),%eax
  801409:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  80140c:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801410:	76 63                	jbe    801475 <memset+0x75>
		uint64 data_block = c;
  801412:	8b 45 0c             	mov    0xc(%ebp),%eax
  801415:	99                   	cltd   
  801416:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801419:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  80141c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80141f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801422:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  801426:	c1 e0 08             	shl    $0x8,%eax
  801429:	09 45 f0             	or     %eax,-0x10(%ebp)
  80142c:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  80142f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801432:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801435:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  801439:	c1 e0 10             	shl    $0x10,%eax
  80143c:	09 45 f0             	or     %eax,-0x10(%ebp)
  80143f:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  801442:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801445:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801448:	89 c2                	mov    %eax,%edx
  80144a:	b8 00 00 00 00       	mov    $0x0,%eax
  80144f:	09 45 f0             	or     %eax,-0x10(%ebp)
  801452:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  801455:	eb 18                	jmp    80146f <memset+0x6f>
			*p64++ = data_block, n -= 8;
  801457:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80145a:	8d 41 08             	lea    0x8(%ecx),%eax
  80145d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  801460:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801463:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801466:	89 01                	mov    %eax,(%ecx)
  801468:	89 51 04             	mov    %edx,0x4(%ecx)
  80146b:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  80146f:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801473:	77 e2                	ja     801457 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  801475:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801479:	74 23                	je     80149e <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  80147b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80147e:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  801481:	eb 0e                	jmp    801491 <memset+0x91>
			*p8++ = (uint8)c;
  801483:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801486:	8d 50 01             	lea    0x1(%eax),%edx
  801489:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80148c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80148f:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  801491:	8b 45 10             	mov    0x10(%ebp),%eax
  801494:	8d 50 ff             	lea    -0x1(%eax),%edx
  801497:	89 55 10             	mov    %edx,0x10(%ebp)
  80149a:	85 c0                	test   %eax,%eax
  80149c:	75 e5                	jne    801483 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  80149e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014a1:	c9                   	leave  
  8014a2:	c3                   	ret    

008014a3 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8014a3:	55                   	push   %ebp
  8014a4:	89 e5                	mov    %esp,%ebp
  8014a6:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  8014a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ac:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  8014af:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  8014b5:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8014b9:	76 24                	jbe    8014df <memcpy+0x3c>
		while(n >= 8){
  8014bb:	eb 1c                	jmp    8014d9 <memcpy+0x36>
			*d64 = *s64;
  8014bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014c0:	8b 50 04             	mov    0x4(%eax),%edx
  8014c3:	8b 00                	mov    (%eax),%eax
  8014c5:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8014c8:	89 01                	mov    %eax,(%ecx)
  8014ca:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  8014cd:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  8014d1:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  8014d5:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  8014d9:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8014dd:	77 de                	ja     8014bd <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  8014df:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014e3:	74 31                	je     801516 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  8014e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  8014eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  8014f1:	eb 16                	jmp    801509 <memcpy+0x66>
			*d8++ = *s8++;
  8014f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8014f6:	8d 50 01             	lea    0x1(%eax),%edx
  8014f9:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8014fc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8014ff:	8d 4a 01             	lea    0x1(%edx),%ecx
  801502:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  801505:	8a 12                	mov    (%edx),%dl
  801507:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  801509:	8b 45 10             	mov    0x10(%ebp),%eax
  80150c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80150f:	89 55 10             	mov    %edx,0x10(%ebp)
  801512:	85 c0                	test   %eax,%eax
  801514:	75 dd                	jne    8014f3 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  801516:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801519:	c9                   	leave  
  80151a:	c3                   	ret    

0080151b <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80151b:	55                   	push   %ebp
  80151c:	89 e5                	mov    %esp,%ebp
  80151e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801521:	8b 45 0c             	mov    0xc(%ebp),%eax
  801524:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801527:	8b 45 08             	mov    0x8(%ebp),%eax
  80152a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80152d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801530:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801533:	73 50                	jae    801585 <memmove+0x6a>
  801535:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801538:	8b 45 10             	mov    0x10(%ebp),%eax
  80153b:	01 d0                	add    %edx,%eax
  80153d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801540:	76 43                	jbe    801585 <memmove+0x6a>
		s += n;
  801542:	8b 45 10             	mov    0x10(%ebp),%eax
  801545:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801548:	8b 45 10             	mov    0x10(%ebp),%eax
  80154b:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80154e:	eb 10                	jmp    801560 <memmove+0x45>
			*--d = *--s;
  801550:	ff 4d f8             	decl   -0x8(%ebp)
  801553:	ff 4d fc             	decl   -0x4(%ebp)
  801556:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801559:	8a 10                	mov    (%eax),%dl
  80155b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80155e:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801560:	8b 45 10             	mov    0x10(%ebp),%eax
  801563:	8d 50 ff             	lea    -0x1(%eax),%edx
  801566:	89 55 10             	mov    %edx,0x10(%ebp)
  801569:	85 c0                	test   %eax,%eax
  80156b:	75 e3                	jne    801550 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80156d:	eb 23                	jmp    801592 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80156f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801572:	8d 50 01             	lea    0x1(%eax),%edx
  801575:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801578:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80157b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80157e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801581:	8a 12                	mov    (%edx),%dl
  801583:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801585:	8b 45 10             	mov    0x10(%ebp),%eax
  801588:	8d 50 ff             	lea    -0x1(%eax),%edx
  80158b:	89 55 10             	mov    %edx,0x10(%ebp)
  80158e:	85 c0                	test   %eax,%eax
  801590:	75 dd                	jne    80156f <memmove+0x54>
			*d++ = *s++;

	return dst;
  801592:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801595:	c9                   	leave  
  801596:	c3                   	ret    

00801597 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801597:	55                   	push   %ebp
  801598:	89 e5                	mov    %esp,%ebp
  80159a:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80159d:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8015a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a6:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8015a9:	eb 2a                	jmp    8015d5 <memcmp+0x3e>
		if (*s1 != *s2)
  8015ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015ae:	8a 10                	mov    (%eax),%dl
  8015b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015b3:	8a 00                	mov    (%eax),%al
  8015b5:	38 c2                	cmp    %al,%dl
  8015b7:	74 16                	je     8015cf <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8015b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015bc:	8a 00                	mov    (%eax),%al
  8015be:	0f b6 d0             	movzbl %al,%edx
  8015c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015c4:	8a 00                	mov    (%eax),%al
  8015c6:	0f b6 c0             	movzbl %al,%eax
  8015c9:	29 c2                	sub    %eax,%edx
  8015cb:	89 d0                	mov    %edx,%eax
  8015cd:	eb 18                	jmp    8015e7 <memcmp+0x50>
		s1++, s2++;
  8015cf:	ff 45 fc             	incl   -0x4(%ebp)
  8015d2:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8015d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8015d8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015db:	89 55 10             	mov    %edx,0x10(%ebp)
  8015de:	85 c0                	test   %eax,%eax
  8015e0:	75 c9                	jne    8015ab <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8015e2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015e7:	c9                   	leave  
  8015e8:	c3                   	ret    

008015e9 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8015e9:	55                   	push   %ebp
  8015ea:	89 e5                	mov    %esp,%ebp
  8015ec:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8015ef:	8b 55 08             	mov    0x8(%ebp),%edx
  8015f2:	8b 45 10             	mov    0x10(%ebp),%eax
  8015f5:	01 d0                	add    %edx,%eax
  8015f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8015fa:	eb 15                	jmp    801611 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8015fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ff:	8a 00                	mov    (%eax),%al
  801601:	0f b6 d0             	movzbl %al,%edx
  801604:	8b 45 0c             	mov    0xc(%ebp),%eax
  801607:	0f b6 c0             	movzbl %al,%eax
  80160a:	39 c2                	cmp    %eax,%edx
  80160c:	74 0d                	je     80161b <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80160e:	ff 45 08             	incl   0x8(%ebp)
  801611:	8b 45 08             	mov    0x8(%ebp),%eax
  801614:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801617:	72 e3                	jb     8015fc <memfind+0x13>
  801619:	eb 01                	jmp    80161c <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80161b:	90                   	nop
	return (void *) s;
  80161c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80161f:	c9                   	leave  
  801620:	c3                   	ret    

00801621 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801621:	55                   	push   %ebp
  801622:	89 e5                	mov    %esp,%ebp
  801624:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801627:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80162e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801635:	eb 03                	jmp    80163a <strtol+0x19>
		s++;
  801637:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80163a:	8b 45 08             	mov    0x8(%ebp),%eax
  80163d:	8a 00                	mov    (%eax),%al
  80163f:	3c 20                	cmp    $0x20,%al
  801641:	74 f4                	je     801637 <strtol+0x16>
  801643:	8b 45 08             	mov    0x8(%ebp),%eax
  801646:	8a 00                	mov    (%eax),%al
  801648:	3c 09                	cmp    $0x9,%al
  80164a:	74 eb                	je     801637 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80164c:	8b 45 08             	mov    0x8(%ebp),%eax
  80164f:	8a 00                	mov    (%eax),%al
  801651:	3c 2b                	cmp    $0x2b,%al
  801653:	75 05                	jne    80165a <strtol+0x39>
		s++;
  801655:	ff 45 08             	incl   0x8(%ebp)
  801658:	eb 13                	jmp    80166d <strtol+0x4c>
	else if (*s == '-')
  80165a:	8b 45 08             	mov    0x8(%ebp),%eax
  80165d:	8a 00                	mov    (%eax),%al
  80165f:	3c 2d                	cmp    $0x2d,%al
  801661:	75 0a                	jne    80166d <strtol+0x4c>
		s++, neg = 1;
  801663:	ff 45 08             	incl   0x8(%ebp)
  801666:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80166d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801671:	74 06                	je     801679 <strtol+0x58>
  801673:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801677:	75 20                	jne    801699 <strtol+0x78>
  801679:	8b 45 08             	mov    0x8(%ebp),%eax
  80167c:	8a 00                	mov    (%eax),%al
  80167e:	3c 30                	cmp    $0x30,%al
  801680:	75 17                	jne    801699 <strtol+0x78>
  801682:	8b 45 08             	mov    0x8(%ebp),%eax
  801685:	40                   	inc    %eax
  801686:	8a 00                	mov    (%eax),%al
  801688:	3c 78                	cmp    $0x78,%al
  80168a:	75 0d                	jne    801699 <strtol+0x78>
		s += 2, base = 16;
  80168c:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801690:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801697:	eb 28                	jmp    8016c1 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801699:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80169d:	75 15                	jne    8016b4 <strtol+0x93>
  80169f:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a2:	8a 00                	mov    (%eax),%al
  8016a4:	3c 30                	cmp    $0x30,%al
  8016a6:	75 0c                	jne    8016b4 <strtol+0x93>
		s++, base = 8;
  8016a8:	ff 45 08             	incl   0x8(%ebp)
  8016ab:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8016b2:	eb 0d                	jmp    8016c1 <strtol+0xa0>
	else if (base == 0)
  8016b4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016b8:	75 07                	jne    8016c1 <strtol+0xa0>
		base = 10;
  8016ba:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8016c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c4:	8a 00                	mov    (%eax),%al
  8016c6:	3c 2f                	cmp    $0x2f,%al
  8016c8:	7e 19                	jle    8016e3 <strtol+0xc2>
  8016ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cd:	8a 00                	mov    (%eax),%al
  8016cf:	3c 39                	cmp    $0x39,%al
  8016d1:	7f 10                	jg     8016e3 <strtol+0xc2>
			dig = *s - '0';
  8016d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d6:	8a 00                	mov    (%eax),%al
  8016d8:	0f be c0             	movsbl %al,%eax
  8016db:	83 e8 30             	sub    $0x30,%eax
  8016de:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016e1:	eb 42                	jmp    801725 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8016e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e6:	8a 00                	mov    (%eax),%al
  8016e8:	3c 60                	cmp    $0x60,%al
  8016ea:	7e 19                	jle    801705 <strtol+0xe4>
  8016ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ef:	8a 00                	mov    (%eax),%al
  8016f1:	3c 7a                	cmp    $0x7a,%al
  8016f3:	7f 10                	jg     801705 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8016f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f8:	8a 00                	mov    (%eax),%al
  8016fa:	0f be c0             	movsbl %al,%eax
  8016fd:	83 e8 57             	sub    $0x57,%eax
  801700:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801703:	eb 20                	jmp    801725 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801705:	8b 45 08             	mov    0x8(%ebp),%eax
  801708:	8a 00                	mov    (%eax),%al
  80170a:	3c 40                	cmp    $0x40,%al
  80170c:	7e 39                	jle    801747 <strtol+0x126>
  80170e:	8b 45 08             	mov    0x8(%ebp),%eax
  801711:	8a 00                	mov    (%eax),%al
  801713:	3c 5a                	cmp    $0x5a,%al
  801715:	7f 30                	jg     801747 <strtol+0x126>
			dig = *s - 'A' + 10;
  801717:	8b 45 08             	mov    0x8(%ebp),%eax
  80171a:	8a 00                	mov    (%eax),%al
  80171c:	0f be c0             	movsbl %al,%eax
  80171f:	83 e8 37             	sub    $0x37,%eax
  801722:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801725:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801728:	3b 45 10             	cmp    0x10(%ebp),%eax
  80172b:	7d 19                	jge    801746 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80172d:	ff 45 08             	incl   0x8(%ebp)
  801730:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801733:	0f af 45 10          	imul   0x10(%ebp),%eax
  801737:	89 c2                	mov    %eax,%edx
  801739:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80173c:	01 d0                	add    %edx,%eax
  80173e:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801741:	e9 7b ff ff ff       	jmp    8016c1 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801746:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801747:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80174b:	74 08                	je     801755 <strtol+0x134>
		*endptr = (char *) s;
  80174d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801750:	8b 55 08             	mov    0x8(%ebp),%edx
  801753:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801755:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801759:	74 07                	je     801762 <strtol+0x141>
  80175b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80175e:	f7 d8                	neg    %eax
  801760:	eb 03                	jmp    801765 <strtol+0x144>
  801762:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801765:	c9                   	leave  
  801766:	c3                   	ret    

00801767 <ltostr>:

void
ltostr(long value, char *str)
{
  801767:	55                   	push   %ebp
  801768:	89 e5                	mov    %esp,%ebp
  80176a:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80176d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801774:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80177b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80177f:	79 13                	jns    801794 <ltostr+0x2d>
	{
		neg = 1;
  801781:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801788:	8b 45 0c             	mov    0xc(%ebp),%eax
  80178b:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80178e:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801791:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801794:	8b 45 08             	mov    0x8(%ebp),%eax
  801797:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80179c:	99                   	cltd   
  80179d:	f7 f9                	idiv   %ecx
  80179f:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8017a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017a5:	8d 50 01             	lea    0x1(%eax),%edx
  8017a8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8017ab:	89 c2                	mov    %eax,%edx
  8017ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b0:	01 d0                	add    %edx,%eax
  8017b2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8017b5:	83 c2 30             	add    $0x30,%edx
  8017b8:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8017ba:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017bd:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017c2:	f7 e9                	imul   %ecx
  8017c4:	c1 fa 02             	sar    $0x2,%edx
  8017c7:	89 c8                	mov    %ecx,%eax
  8017c9:	c1 f8 1f             	sar    $0x1f,%eax
  8017cc:	29 c2                	sub    %eax,%edx
  8017ce:	89 d0                	mov    %edx,%eax
  8017d0:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  8017d3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8017d7:	75 bb                	jne    801794 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8017d9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8017e0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017e3:	48                   	dec    %eax
  8017e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8017e7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017eb:	74 3d                	je     80182a <ltostr+0xc3>
		start = 1 ;
  8017ed:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8017f4:	eb 34                	jmp    80182a <ltostr+0xc3>
	{
		char tmp = str[start] ;
  8017f6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017fc:	01 d0                	add    %edx,%eax
  8017fe:	8a 00                	mov    (%eax),%al
  801800:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801803:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801806:	8b 45 0c             	mov    0xc(%ebp),%eax
  801809:	01 c2                	add    %eax,%edx
  80180b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80180e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801811:	01 c8                	add    %ecx,%eax
  801813:	8a 00                	mov    (%eax),%al
  801815:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801817:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80181a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80181d:	01 c2                	add    %eax,%edx
  80181f:	8a 45 eb             	mov    -0x15(%ebp),%al
  801822:	88 02                	mov    %al,(%edx)
		start++ ;
  801824:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801827:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80182a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80182d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801830:	7c c4                	jl     8017f6 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801832:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801835:	8b 45 0c             	mov    0xc(%ebp),%eax
  801838:	01 d0                	add    %edx,%eax
  80183a:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80183d:	90                   	nop
  80183e:	c9                   	leave  
  80183f:	c3                   	ret    

00801840 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801840:	55                   	push   %ebp
  801841:	89 e5                	mov    %esp,%ebp
  801843:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801846:	ff 75 08             	pushl  0x8(%ebp)
  801849:	e8 c4 f9 ff ff       	call   801212 <strlen>
  80184e:	83 c4 04             	add    $0x4,%esp
  801851:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801854:	ff 75 0c             	pushl  0xc(%ebp)
  801857:	e8 b6 f9 ff ff       	call   801212 <strlen>
  80185c:	83 c4 04             	add    $0x4,%esp
  80185f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801862:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801869:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801870:	eb 17                	jmp    801889 <strcconcat+0x49>
		final[s] = str1[s] ;
  801872:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801875:	8b 45 10             	mov    0x10(%ebp),%eax
  801878:	01 c2                	add    %eax,%edx
  80187a:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80187d:	8b 45 08             	mov    0x8(%ebp),%eax
  801880:	01 c8                	add    %ecx,%eax
  801882:	8a 00                	mov    (%eax),%al
  801884:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801886:	ff 45 fc             	incl   -0x4(%ebp)
  801889:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80188c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80188f:	7c e1                	jl     801872 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801891:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801898:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80189f:	eb 1f                	jmp    8018c0 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8018a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018a4:	8d 50 01             	lea    0x1(%eax),%edx
  8018a7:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8018aa:	89 c2                	mov    %eax,%edx
  8018ac:	8b 45 10             	mov    0x10(%ebp),%eax
  8018af:	01 c2                	add    %eax,%edx
  8018b1:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8018b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018b7:	01 c8                	add    %ecx,%eax
  8018b9:	8a 00                	mov    (%eax),%al
  8018bb:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8018bd:	ff 45 f8             	incl   -0x8(%ebp)
  8018c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018c3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018c6:	7c d9                	jl     8018a1 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8018c8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018cb:	8b 45 10             	mov    0x10(%ebp),%eax
  8018ce:	01 d0                	add    %edx,%eax
  8018d0:	c6 00 00             	movb   $0x0,(%eax)
}
  8018d3:	90                   	nop
  8018d4:	c9                   	leave  
  8018d5:	c3                   	ret    

008018d6 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8018d6:	55                   	push   %ebp
  8018d7:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8018d9:	8b 45 14             	mov    0x14(%ebp),%eax
  8018dc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8018e2:	8b 45 14             	mov    0x14(%ebp),%eax
  8018e5:	8b 00                	mov    (%eax),%eax
  8018e7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018ee:	8b 45 10             	mov    0x10(%ebp),%eax
  8018f1:	01 d0                	add    %edx,%eax
  8018f3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018f9:	eb 0c                	jmp    801907 <strsplit+0x31>
			*string++ = 0;
  8018fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018fe:	8d 50 01             	lea    0x1(%eax),%edx
  801901:	89 55 08             	mov    %edx,0x8(%ebp)
  801904:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801907:	8b 45 08             	mov    0x8(%ebp),%eax
  80190a:	8a 00                	mov    (%eax),%al
  80190c:	84 c0                	test   %al,%al
  80190e:	74 18                	je     801928 <strsplit+0x52>
  801910:	8b 45 08             	mov    0x8(%ebp),%eax
  801913:	8a 00                	mov    (%eax),%al
  801915:	0f be c0             	movsbl %al,%eax
  801918:	50                   	push   %eax
  801919:	ff 75 0c             	pushl  0xc(%ebp)
  80191c:	e8 83 fa ff ff       	call   8013a4 <strchr>
  801921:	83 c4 08             	add    $0x8,%esp
  801924:	85 c0                	test   %eax,%eax
  801926:	75 d3                	jne    8018fb <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801928:	8b 45 08             	mov    0x8(%ebp),%eax
  80192b:	8a 00                	mov    (%eax),%al
  80192d:	84 c0                	test   %al,%al
  80192f:	74 5a                	je     80198b <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801931:	8b 45 14             	mov    0x14(%ebp),%eax
  801934:	8b 00                	mov    (%eax),%eax
  801936:	83 f8 0f             	cmp    $0xf,%eax
  801939:	75 07                	jne    801942 <strsplit+0x6c>
		{
			return 0;
  80193b:	b8 00 00 00 00       	mov    $0x0,%eax
  801940:	eb 66                	jmp    8019a8 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801942:	8b 45 14             	mov    0x14(%ebp),%eax
  801945:	8b 00                	mov    (%eax),%eax
  801947:	8d 48 01             	lea    0x1(%eax),%ecx
  80194a:	8b 55 14             	mov    0x14(%ebp),%edx
  80194d:	89 0a                	mov    %ecx,(%edx)
  80194f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801956:	8b 45 10             	mov    0x10(%ebp),%eax
  801959:	01 c2                	add    %eax,%edx
  80195b:	8b 45 08             	mov    0x8(%ebp),%eax
  80195e:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801960:	eb 03                	jmp    801965 <strsplit+0x8f>
			string++;
  801962:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801965:	8b 45 08             	mov    0x8(%ebp),%eax
  801968:	8a 00                	mov    (%eax),%al
  80196a:	84 c0                	test   %al,%al
  80196c:	74 8b                	je     8018f9 <strsplit+0x23>
  80196e:	8b 45 08             	mov    0x8(%ebp),%eax
  801971:	8a 00                	mov    (%eax),%al
  801973:	0f be c0             	movsbl %al,%eax
  801976:	50                   	push   %eax
  801977:	ff 75 0c             	pushl  0xc(%ebp)
  80197a:	e8 25 fa ff ff       	call   8013a4 <strchr>
  80197f:	83 c4 08             	add    $0x8,%esp
  801982:	85 c0                	test   %eax,%eax
  801984:	74 dc                	je     801962 <strsplit+0x8c>
			string++;
	}
  801986:	e9 6e ff ff ff       	jmp    8018f9 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80198b:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80198c:	8b 45 14             	mov    0x14(%ebp),%eax
  80198f:	8b 00                	mov    (%eax),%eax
  801991:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801998:	8b 45 10             	mov    0x10(%ebp),%eax
  80199b:	01 d0                	add    %edx,%eax
  80199d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8019a3:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8019a8:	c9                   	leave  
  8019a9:	c3                   	ret    

008019aa <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  8019aa:	55                   	push   %ebp
  8019ab:	89 e5                	mov    %esp,%ebp
  8019ad:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  8019b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  8019b6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8019bd:	eb 4a                	jmp    801a09 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  8019bf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c5:	01 c2                	add    %eax,%edx
  8019c7:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8019ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019cd:	01 c8                	add    %ecx,%eax
  8019cf:	8a 00                	mov    (%eax),%al
  8019d1:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  8019d3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019d9:	01 d0                	add    %edx,%eax
  8019db:	8a 00                	mov    (%eax),%al
  8019dd:	3c 40                	cmp    $0x40,%al
  8019df:	7e 25                	jle    801a06 <str2lower+0x5c>
  8019e1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019e7:	01 d0                	add    %edx,%eax
  8019e9:	8a 00                	mov    (%eax),%al
  8019eb:	3c 5a                	cmp    $0x5a,%al
  8019ed:	7f 17                	jg     801a06 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  8019ef:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f5:	01 d0                	add    %edx,%eax
  8019f7:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8019fa:	8b 55 08             	mov    0x8(%ebp),%edx
  8019fd:	01 ca                	add    %ecx,%edx
  8019ff:	8a 12                	mov    (%edx),%dl
  801a01:	83 c2 20             	add    $0x20,%edx
  801a04:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801a06:	ff 45 fc             	incl   -0x4(%ebp)
  801a09:	ff 75 0c             	pushl  0xc(%ebp)
  801a0c:	e8 01 f8 ff ff       	call   801212 <strlen>
  801a11:	83 c4 04             	add    $0x4,%esp
  801a14:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801a17:	7f a6                	jg     8019bf <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801a19:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801a1c:	c9                   	leave  
  801a1d:	c3                   	ret    

00801a1e <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801a1e:	55                   	push   %ebp
  801a1f:	89 e5                	mov    %esp,%ebp
  801a21:	57                   	push   %edi
  801a22:	56                   	push   %esi
  801a23:	53                   	push   %ebx
  801a24:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801a27:	8b 45 08             	mov    0x8(%ebp),%eax
  801a2a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a2d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a30:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a33:	8b 7d 18             	mov    0x18(%ebp),%edi
  801a36:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801a39:	cd 30                	int    $0x30
  801a3b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801a3e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801a41:	83 c4 10             	add    $0x10,%esp
  801a44:	5b                   	pop    %ebx
  801a45:	5e                   	pop    %esi
  801a46:	5f                   	pop    %edi
  801a47:	5d                   	pop    %ebp
  801a48:	c3                   	ret    

00801a49 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801a49:	55                   	push   %ebp
  801a4a:	89 e5                	mov    %esp,%ebp
  801a4c:	83 ec 04             	sub    $0x4,%esp
  801a4f:	8b 45 10             	mov    0x10(%ebp),%eax
  801a52:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801a55:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a58:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a5c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a5f:	6a 00                	push   $0x0
  801a61:	51                   	push   %ecx
  801a62:	52                   	push   %edx
  801a63:	ff 75 0c             	pushl  0xc(%ebp)
  801a66:	50                   	push   %eax
  801a67:	6a 00                	push   $0x0
  801a69:	e8 b0 ff ff ff       	call   801a1e <syscall>
  801a6e:	83 c4 18             	add    $0x18,%esp
}
  801a71:	90                   	nop
  801a72:	c9                   	leave  
  801a73:	c3                   	ret    

00801a74 <sys_cgetc>:

int
sys_cgetc(void)
{
  801a74:	55                   	push   %ebp
  801a75:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801a77:	6a 00                	push   $0x0
  801a79:	6a 00                	push   $0x0
  801a7b:	6a 00                	push   $0x0
  801a7d:	6a 00                	push   $0x0
  801a7f:	6a 00                	push   $0x0
  801a81:	6a 02                	push   $0x2
  801a83:	e8 96 ff ff ff       	call   801a1e <syscall>
  801a88:	83 c4 18             	add    $0x18,%esp
}
  801a8b:	c9                   	leave  
  801a8c:	c3                   	ret    

00801a8d <sys_lock_cons>:

void sys_lock_cons(void)
{
  801a8d:	55                   	push   %ebp
  801a8e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801a90:	6a 00                	push   $0x0
  801a92:	6a 00                	push   $0x0
  801a94:	6a 00                	push   $0x0
  801a96:	6a 00                	push   $0x0
  801a98:	6a 00                	push   $0x0
  801a9a:	6a 03                	push   $0x3
  801a9c:	e8 7d ff ff ff       	call   801a1e <syscall>
  801aa1:	83 c4 18             	add    $0x18,%esp
}
  801aa4:	90                   	nop
  801aa5:	c9                   	leave  
  801aa6:	c3                   	ret    

00801aa7 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801aa7:	55                   	push   %ebp
  801aa8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801aaa:	6a 00                	push   $0x0
  801aac:	6a 00                	push   $0x0
  801aae:	6a 00                	push   $0x0
  801ab0:	6a 00                	push   $0x0
  801ab2:	6a 00                	push   $0x0
  801ab4:	6a 04                	push   $0x4
  801ab6:	e8 63 ff ff ff       	call   801a1e <syscall>
  801abb:	83 c4 18             	add    $0x18,%esp
}
  801abe:	90                   	nop
  801abf:	c9                   	leave  
  801ac0:	c3                   	ret    

00801ac1 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801ac1:	55                   	push   %ebp
  801ac2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801ac4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ac7:	8b 45 08             	mov    0x8(%ebp),%eax
  801aca:	6a 00                	push   $0x0
  801acc:	6a 00                	push   $0x0
  801ace:	6a 00                	push   $0x0
  801ad0:	52                   	push   %edx
  801ad1:	50                   	push   %eax
  801ad2:	6a 08                	push   $0x8
  801ad4:	e8 45 ff ff ff       	call   801a1e <syscall>
  801ad9:	83 c4 18             	add    $0x18,%esp
}
  801adc:	c9                   	leave  
  801add:	c3                   	ret    

00801ade <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801ade:	55                   	push   %ebp
  801adf:	89 e5                	mov    %esp,%ebp
  801ae1:	56                   	push   %esi
  801ae2:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801ae3:	8b 75 18             	mov    0x18(%ebp),%esi
  801ae6:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ae9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801aec:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aef:	8b 45 08             	mov    0x8(%ebp),%eax
  801af2:	56                   	push   %esi
  801af3:	53                   	push   %ebx
  801af4:	51                   	push   %ecx
  801af5:	52                   	push   %edx
  801af6:	50                   	push   %eax
  801af7:	6a 09                	push   $0x9
  801af9:	e8 20 ff ff ff       	call   801a1e <syscall>
  801afe:	83 c4 18             	add    $0x18,%esp
}
  801b01:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801b04:	5b                   	pop    %ebx
  801b05:	5e                   	pop    %esi
  801b06:	5d                   	pop    %ebp
  801b07:	c3                   	ret    

00801b08 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  801b08:	55                   	push   %ebp
  801b09:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  801b0b:	6a 00                	push   $0x0
  801b0d:	6a 00                	push   $0x0
  801b0f:	6a 00                	push   $0x0
  801b11:	6a 00                	push   $0x0
  801b13:	ff 75 08             	pushl  0x8(%ebp)
  801b16:	6a 0a                	push   $0xa
  801b18:	e8 01 ff ff ff       	call   801a1e <syscall>
  801b1d:	83 c4 18             	add    $0x18,%esp
}
  801b20:	c9                   	leave  
  801b21:	c3                   	ret    

00801b22 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801b22:	55                   	push   %ebp
  801b23:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801b25:	6a 00                	push   $0x0
  801b27:	6a 00                	push   $0x0
  801b29:	6a 00                	push   $0x0
  801b2b:	ff 75 0c             	pushl  0xc(%ebp)
  801b2e:	ff 75 08             	pushl  0x8(%ebp)
  801b31:	6a 0b                	push   $0xb
  801b33:	e8 e6 fe ff ff       	call   801a1e <syscall>
  801b38:	83 c4 18             	add    $0x18,%esp
}
  801b3b:	c9                   	leave  
  801b3c:	c3                   	ret    

00801b3d <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801b3d:	55                   	push   %ebp
  801b3e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801b40:	6a 00                	push   $0x0
  801b42:	6a 00                	push   $0x0
  801b44:	6a 00                	push   $0x0
  801b46:	6a 00                	push   $0x0
  801b48:	6a 00                	push   $0x0
  801b4a:	6a 0c                	push   $0xc
  801b4c:	e8 cd fe ff ff       	call   801a1e <syscall>
  801b51:	83 c4 18             	add    $0x18,%esp
}
  801b54:	c9                   	leave  
  801b55:	c3                   	ret    

00801b56 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801b56:	55                   	push   %ebp
  801b57:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801b59:	6a 00                	push   $0x0
  801b5b:	6a 00                	push   $0x0
  801b5d:	6a 00                	push   $0x0
  801b5f:	6a 00                	push   $0x0
  801b61:	6a 00                	push   $0x0
  801b63:	6a 0d                	push   $0xd
  801b65:	e8 b4 fe ff ff       	call   801a1e <syscall>
  801b6a:	83 c4 18             	add    $0x18,%esp
}
  801b6d:	c9                   	leave  
  801b6e:	c3                   	ret    

00801b6f <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801b6f:	55                   	push   %ebp
  801b70:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801b72:	6a 00                	push   $0x0
  801b74:	6a 00                	push   $0x0
  801b76:	6a 00                	push   $0x0
  801b78:	6a 00                	push   $0x0
  801b7a:	6a 00                	push   $0x0
  801b7c:	6a 0e                	push   $0xe
  801b7e:	e8 9b fe ff ff       	call   801a1e <syscall>
  801b83:	83 c4 18             	add    $0x18,%esp
}
  801b86:	c9                   	leave  
  801b87:	c3                   	ret    

00801b88 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801b88:	55                   	push   %ebp
  801b89:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801b8b:	6a 00                	push   $0x0
  801b8d:	6a 00                	push   $0x0
  801b8f:	6a 00                	push   $0x0
  801b91:	6a 00                	push   $0x0
  801b93:	6a 00                	push   $0x0
  801b95:	6a 0f                	push   $0xf
  801b97:	e8 82 fe ff ff       	call   801a1e <syscall>
  801b9c:	83 c4 18             	add    $0x18,%esp
}
  801b9f:	c9                   	leave  
  801ba0:	c3                   	ret    

00801ba1 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801ba1:	55                   	push   %ebp
  801ba2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801ba4:	6a 00                	push   $0x0
  801ba6:	6a 00                	push   $0x0
  801ba8:	6a 00                	push   $0x0
  801baa:	6a 00                	push   $0x0
  801bac:	ff 75 08             	pushl  0x8(%ebp)
  801baf:	6a 10                	push   $0x10
  801bb1:	e8 68 fe ff ff       	call   801a1e <syscall>
  801bb6:	83 c4 18             	add    $0x18,%esp
}
  801bb9:	c9                   	leave  
  801bba:	c3                   	ret    

00801bbb <sys_scarce_memory>:

void sys_scarce_memory()
{
  801bbb:	55                   	push   %ebp
  801bbc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801bbe:	6a 00                	push   $0x0
  801bc0:	6a 00                	push   $0x0
  801bc2:	6a 00                	push   $0x0
  801bc4:	6a 00                	push   $0x0
  801bc6:	6a 00                	push   $0x0
  801bc8:	6a 11                	push   $0x11
  801bca:	e8 4f fe ff ff       	call   801a1e <syscall>
  801bcf:	83 c4 18             	add    $0x18,%esp
}
  801bd2:	90                   	nop
  801bd3:	c9                   	leave  
  801bd4:	c3                   	ret    

00801bd5 <sys_cputc>:

void
sys_cputc(const char c)
{
  801bd5:	55                   	push   %ebp
  801bd6:	89 e5                	mov    %esp,%ebp
  801bd8:	83 ec 04             	sub    $0x4,%esp
  801bdb:	8b 45 08             	mov    0x8(%ebp),%eax
  801bde:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801be1:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801be5:	6a 00                	push   $0x0
  801be7:	6a 00                	push   $0x0
  801be9:	6a 00                	push   $0x0
  801beb:	6a 00                	push   $0x0
  801bed:	50                   	push   %eax
  801bee:	6a 01                	push   $0x1
  801bf0:	e8 29 fe ff ff       	call   801a1e <syscall>
  801bf5:	83 c4 18             	add    $0x18,%esp
}
  801bf8:	90                   	nop
  801bf9:	c9                   	leave  
  801bfa:	c3                   	ret    

00801bfb <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801bfb:	55                   	push   %ebp
  801bfc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801bfe:	6a 00                	push   $0x0
  801c00:	6a 00                	push   $0x0
  801c02:	6a 00                	push   $0x0
  801c04:	6a 00                	push   $0x0
  801c06:	6a 00                	push   $0x0
  801c08:	6a 14                	push   $0x14
  801c0a:	e8 0f fe ff ff       	call   801a1e <syscall>
  801c0f:	83 c4 18             	add    $0x18,%esp
}
  801c12:	90                   	nop
  801c13:	c9                   	leave  
  801c14:	c3                   	ret    

00801c15 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  801c15:	55                   	push   %ebp
  801c16:	89 e5                	mov    %esp,%ebp
  801c18:	83 ec 04             	sub    $0x4,%esp
  801c1b:	8b 45 10             	mov    0x10(%ebp),%eax
  801c1e:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  801c21:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801c24:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801c28:	8b 45 08             	mov    0x8(%ebp),%eax
  801c2b:	6a 00                	push   $0x0
  801c2d:	51                   	push   %ecx
  801c2e:	52                   	push   %edx
  801c2f:	ff 75 0c             	pushl  0xc(%ebp)
  801c32:	50                   	push   %eax
  801c33:	6a 15                	push   $0x15
  801c35:	e8 e4 fd ff ff       	call   801a1e <syscall>
  801c3a:	83 c4 18             	add    $0x18,%esp
}
  801c3d:	c9                   	leave  
  801c3e:	c3                   	ret    

00801c3f <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801c3f:	55                   	push   %ebp
  801c40:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  801c42:	8b 55 10             	mov    0x10(%ebp),%edx
  801c45:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c48:	6a 00                	push   $0x0
  801c4a:	6a 00                	push   $0x0
  801c4c:	52                   	push   %edx
  801c4d:	50                   	push   %eax
  801c4e:	ff 75 08             	pushl  0x8(%ebp)
  801c51:	6a 16                	push   $0x16
  801c53:	e8 c6 fd ff ff       	call   801a1e <syscall>
  801c58:	83 c4 18             	add    $0x18,%esp
}
  801c5b:	c9                   	leave  
  801c5c:	c3                   	ret    

00801c5d <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  801c5d:	55                   	push   %ebp
  801c5e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801c60:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c63:	8b 45 08             	mov    0x8(%ebp),%eax
  801c66:	6a 00                	push   $0x0
  801c68:	6a 00                	push   $0x0
  801c6a:	6a 00                	push   $0x0
  801c6c:	52                   	push   %edx
  801c6d:	50                   	push   %eax
  801c6e:	6a 17                	push   $0x17
  801c70:	e8 a9 fd ff ff       	call   801a1e <syscall>
  801c75:	83 c4 18             	add    $0x18,%esp
}
  801c78:	c9                   	leave  
  801c79:	c3                   	ret    

00801c7a <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  801c7a:	55                   	push   %ebp
  801c7b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801c7d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c80:	8b 45 08             	mov    0x8(%ebp),%eax
  801c83:	6a 00                	push   $0x0
  801c85:	6a 00                	push   $0x0
  801c87:	6a 00                	push   $0x0
  801c89:	52                   	push   %edx
  801c8a:	50                   	push   %eax
  801c8b:	6a 18                	push   $0x18
  801c8d:	e8 8c fd ff ff       	call   801a1e <syscall>
  801c92:	83 c4 18             	add    $0x18,%esp
}
  801c95:	c9                   	leave  
  801c96:	c3                   	ret    

00801c97 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801c97:	55                   	push   %ebp
  801c98:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801c9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801c9d:	6a 00                	push   $0x0
  801c9f:	ff 75 14             	pushl  0x14(%ebp)
  801ca2:	ff 75 10             	pushl  0x10(%ebp)
  801ca5:	ff 75 0c             	pushl  0xc(%ebp)
  801ca8:	50                   	push   %eax
  801ca9:	6a 19                	push   $0x19
  801cab:	e8 6e fd ff ff       	call   801a1e <syscall>
  801cb0:	83 c4 18             	add    $0x18,%esp
}
  801cb3:	c9                   	leave  
  801cb4:	c3                   	ret    

00801cb5 <sys_run_env>:

void sys_run_env(int32 envId)
{
  801cb5:	55                   	push   %ebp
  801cb6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801cb8:	8b 45 08             	mov    0x8(%ebp),%eax
  801cbb:	6a 00                	push   $0x0
  801cbd:	6a 00                	push   $0x0
  801cbf:	6a 00                	push   $0x0
  801cc1:	6a 00                	push   $0x0
  801cc3:	50                   	push   %eax
  801cc4:	6a 1a                	push   $0x1a
  801cc6:	e8 53 fd ff ff       	call   801a1e <syscall>
  801ccb:	83 c4 18             	add    $0x18,%esp
}
  801cce:	90                   	nop
  801ccf:	c9                   	leave  
  801cd0:	c3                   	ret    

00801cd1 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801cd1:	55                   	push   %ebp
  801cd2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  801cd4:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd7:	6a 00                	push   $0x0
  801cd9:	6a 00                	push   $0x0
  801cdb:	6a 00                	push   $0x0
  801cdd:	6a 00                	push   $0x0
  801cdf:	50                   	push   %eax
  801ce0:	6a 1b                	push   $0x1b
  801ce2:	e8 37 fd ff ff       	call   801a1e <syscall>
  801ce7:	83 c4 18             	add    $0x18,%esp
}
  801cea:	c9                   	leave  
  801ceb:	c3                   	ret    

00801cec <sys_getenvid>:

int32 sys_getenvid(void)
{
  801cec:	55                   	push   %ebp
  801ced:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801cef:	6a 00                	push   $0x0
  801cf1:	6a 00                	push   $0x0
  801cf3:	6a 00                	push   $0x0
  801cf5:	6a 00                	push   $0x0
  801cf7:	6a 00                	push   $0x0
  801cf9:	6a 05                	push   $0x5
  801cfb:	e8 1e fd ff ff       	call   801a1e <syscall>
  801d00:	83 c4 18             	add    $0x18,%esp
}
  801d03:	c9                   	leave  
  801d04:	c3                   	ret    

00801d05 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801d05:	55                   	push   %ebp
  801d06:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801d08:	6a 00                	push   $0x0
  801d0a:	6a 00                	push   $0x0
  801d0c:	6a 00                	push   $0x0
  801d0e:	6a 00                	push   $0x0
  801d10:	6a 00                	push   $0x0
  801d12:	6a 06                	push   $0x6
  801d14:	e8 05 fd ff ff       	call   801a1e <syscall>
  801d19:	83 c4 18             	add    $0x18,%esp
}
  801d1c:	c9                   	leave  
  801d1d:	c3                   	ret    

00801d1e <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801d1e:	55                   	push   %ebp
  801d1f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801d21:	6a 00                	push   $0x0
  801d23:	6a 00                	push   $0x0
  801d25:	6a 00                	push   $0x0
  801d27:	6a 00                	push   $0x0
  801d29:	6a 00                	push   $0x0
  801d2b:	6a 07                	push   $0x7
  801d2d:	e8 ec fc ff ff       	call   801a1e <syscall>
  801d32:	83 c4 18             	add    $0x18,%esp
}
  801d35:	c9                   	leave  
  801d36:	c3                   	ret    

00801d37 <sys_exit_env>:


void sys_exit_env(void)
{
  801d37:	55                   	push   %ebp
  801d38:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  801d3a:	6a 00                	push   $0x0
  801d3c:	6a 00                	push   $0x0
  801d3e:	6a 00                	push   $0x0
  801d40:	6a 00                	push   $0x0
  801d42:	6a 00                	push   $0x0
  801d44:	6a 1c                	push   $0x1c
  801d46:	e8 d3 fc ff ff       	call   801a1e <syscall>
  801d4b:	83 c4 18             	add    $0x18,%esp
}
  801d4e:	90                   	nop
  801d4f:	c9                   	leave  
  801d50:	c3                   	ret    

00801d51 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801d51:	55                   	push   %ebp
  801d52:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801d54:	6a 00                	push   $0x0
  801d56:	6a 00                	push   $0x0
  801d58:	ff 75 10             	pushl  0x10(%ebp)
  801d5b:	ff 75 0c             	pushl  0xc(%ebp)
  801d5e:	ff 75 08             	pushl  0x8(%ebp)
  801d61:	6a 13                	push   $0x13
  801d63:	e8 b6 fc ff ff       	call   801a1e <syscall>
  801d68:	83 c4 18             	add    $0x18,%esp
	return ;
  801d6b:	90                   	nop
}
  801d6c:	c9                   	leave  
  801d6d:	c3                   	ret    

00801d6e <sys_rcr2>:
uint32 sys_rcr2()
{
  801d6e:	55                   	push   %ebp
  801d6f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801d71:	6a 00                	push   $0x0
  801d73:	6a 00                	push   $0x0
  801d75:	6a 00                	push   $0x0
  801d77:	6a 00                	push   $0x0
  801d79:	6a 00                	push   $0x0
  801d7b:	6a 1e                	push   $0x1e
  801d7d:	e8 9c fc ff ff       	call   801a1e <syscall>
  801d82:	83 c4 18             	add    $0x18,%esp
}
  801d85:	c9                   	leave  
  801d86:	c3                   	ret    

00801d87 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801d87:	55                   	push   %ebp
  801d88:	89 e5                	mov    %esp,%ebp
  801d8a:	83 ec 04             	sub    $0x4,%esp
  801d8d:	8b 45 08             	mov    0x8(%ebp),%eax
  801d90:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801d93:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801d97:	6a 00                	push   $0x0
  801d99:	6a 00                	push   $0x0
  801d9b:	6a 00                	push   $0x0
  801d9d:	6a 00                	push   $0x0
  801d9f:	50                   	push   %eax
  801da0:	6a 1f                	push   $0x1f
  801da2:	e8 77 fc ff ff       	call   801a1e <syscall>
  801da7:	83 c4 18             	add    $0x18,%esp
	return ;
  801daa:	90                   	nop
}
  801dab:	c9                   	leave  
  801dac:	c3                   	ret    

00801dad <rsttst>:
void rsttst()
{
  801dad:	55                   	push   %ebp
  801dae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801db0:	6a 00                	push   $0x0
  801db2:	6a 00                	push   $0x0
  801db4:	6a 00                	push   $0x0
  801db6:	6a 00                	push   $0x0
  801db8:	6a 00                	push   $0x0
  801dba:	6a 21                	push   $0x21
  801dbc:	e8 5d fc ff ff       	call   801a1e <syscall>
  801dc1:	83 c4 18             	add    $0x18,%esp
	return ;
  801dc4:	90                   	nop
}
  801dc5:	c9                   	leave  
  801dc6:	c3                   	ret    

00801dc7 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801dc7:	55                   	push   %ebp
  801dc8:	89 e5                	mov    %esp,%ebp
  801dca:	83 ec 04             	sub    $0x4,%esp
  801dcd:	8b 45 14             	mov    0x14(%ebp),%eax
  801dd0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801dd3:	8b 55 18             	mov    0x18(%ebp),%edx
  801dd6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801dda:	52                   	push   %edx
  801ddb:	50                   	push   %eax
  801ddc:	ff 75 10             	pushl  0x10(%ebp)
  801ddf:	ff 75 0c             	pushl  0xc(%ebp)
  801de2:	ff 75 08             	pushl  0x8(%ebp)
  801de5:	6a 20                	push   $0x20
  801de7:	e8 32 fc ff ff       	call   801a1e <syscall>
  801dec:	83 c4 18             	add    $0x18,%esp
	return ;
  801def:	90                   	nop
}
  801df0:	c9                   	leave  
  801df1:	c3                   	ret    

00801df2 <chktst>:
void chktst(uint32 n)
{
  801df2:	55                   	push   %ebp
  801df3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801df5:	6a 00                	push   $0x0
  801df7:	6a 00                	push   $0x0
  801df9:	6a 00                	push   $0x0
  801dfb:	6a 00                	push   $0x0
  801dfd:	ff 75 08             	pushl  0x8(%ebp)
  801e00:	6a 22                	push   $0x22
  801e02:	e8 17 fc ff ff       	call   801a1e <syscall>
  801e07:	83 c4 18             	add    $0x18,%esp
	return ;
  801e0a:	90                   	nop
}
  801e0b:	c9                   	leave  
  801e0c:	c3                   	ret    

00801e0d <inctst>:

void inctst()
{
  801e0d:	55                   	push   %ebp
  801e0e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801e10:	6a 00                	push   $0x0
  801e12:	6a 00                	push   $0x0
  801e14:	6a 00                	push   $0x0
  801e16:	6a 00                	push   $0x0
  801e18:	6a 00                	push   $0x0
  801e1a:	6a 23                	push   $0x23
  801e1c:	e8 fd fb ff ff       	call   801a1e <syscall>
  801e21:	83 c4 18             	add    $0x18,%esp
	return ;
  801e24:	90                   	nop
}
  801e25:	c9                   	leave  
  801e26:	c3                   	ret    

00801e27 <gettst>:
uint32 gettst()
{
  801e27:	55                   	push   %ebp
  801e28:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801e2a:	6a 00                	push   $0x0
  801e2c:	6a 00                	push   $0x0
  801e2e:	6a 00                	push   $0x0
  801e30:	6a 00                	push   $0x0
  801e32:	6a 00                	push   $0x0
  801e34:	6a 24                	push   $0x24
  801e36:	e8 e3 fb ff ff       	call   801a1e <syscall>
  801e3b:	83 c4 18             	add    $0x18,%esp
}
  801e3e:	c9                   	leave  
  801e3f:	c3                   	ret    

00801e40 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801e40:	55                   	push   %ebp
  801e41:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e43:	6a 00                	push   $0x0
  801e45:	6a 00                	push   $0x0
  801e47:	6a 00                	push   $0x0
  801e49:	6a 00                	push   $0x0
  801e4b:	6a 00                	push   $0x0
  801e4d:	6a 25                	push   $0x25
  801e4f:	e8 ca fb ff ff       	call   801a1e <syscall>
  801e54:	83 c4 18             	add    $0x18,%esp
  801e57:	a3 88 30 80 00       	mov    %eax,0x803088
	return uheapPlaceStrategy ;
  801e5c:	a1 88 30 80 00       	mov    0x803088,%eax
}
  801e61:	c9                   	leave  
  801e62:	c3                   	ret    

00801e63 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801e63:	55                   	push   %ebp
  801e64:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801e66:	8b 45 08             	mov    0x8(%ebp),%eax
  801e69:	a3 88 30 80 00       	mov    %eax,0x803088
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801e6e:	6a 00                	push   $0x0
  801e70:	6a 00                	push   $0x0
  801e72:	6a 00                	push   $0x0
  801e74:	6a 00                	push   $0x0
  801e76:	ff 75 08             	pushl  0x8(%ebp)
  801e79:	6a 26                	push   $0x26
  801e7b:	e8 9e fb ff ff       	call   801a1e <syscall>
  801e80:	83 c4 18             	add    $0x18,%esp
	return ;
  801e83:	90                   	nop
}
  801e84:	c9                   	leave  
  801e85:	c3                   	ret    

00801e86 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801e86:	55                   	push   %ebp
  801e87:	89 e5                	mov    %esp,%ebp
  801e89:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801e8a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e8d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e90:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e93:	8b 45 08             	mov    0x8(%ebp),%eax
  801e96:	6a 00                	push   $0x0
  801e98:	53                   	push   %ebx
  801e99:	51                   	push   %ecx
  801e9a:	52                   	push   %edx
  801e9b:	50                   	push   %eax
  801e9c:	6a 27                	push   $0x27
  801e9e:	e8 7b fb ff ff       	call   801a1e <syscall>
  801ea3:	83 c4 18             	add    $0x18,%esp
}
  801ea6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801ea9:	c9                   	leave  
  801eaa:	c3                   	ret    

00801eab <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801eab:	55                   	push   %ebp
  801eac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801eae:	8b 55 0c             	mov    0xc(%ebp),%edx
  801eb1:	8b 45 08             	mov    0x8(%ebp),%eax
  801eb4:	6a 00                	push   $0x0
  801eb6:	6a 00                	push   $0x0
  801eb8:	6a 00                	push   $0x0
  801eba:	52                   	push   %edx
  801ebb:	50                   	push   %eax
  801ebc:	6a 28                	push   $0x28
  801ebe:	e8 5b fb ff ff       	call   801a1e <syscall>
  801ec3:	83 c4 18             	add    $0x18,%esp
}
  801ec6:	c9                   	leave  
  801ec7:	c3                   	ret    

00801ec8 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801ec8:	55                   	push   %ebp
  801ec9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801ecb:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801ece:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ed1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed4:	6a 00                	push   $0x0
  801ed6:	51                   	push   %ecx
  801ed7:	ff 75 10             	pushl  0x10(%ebp)
  801eda:	52                   	push   %edx
  801edb:	50                   	push   %eax
  801edc:	6a 29                	push   $0x29
  801ede:	e8 3b fb ff ff       	call   801a1e <syscall>
  801ee3:	83 c4 18             	add    $0x18,%esp
}
  801ee6:	c9                   	leave  
  801ee7:	c3                   	ret    

00801ee8 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801ee8:	55                   	push   %ebp
  801ee9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801eeb:	6a 00                	push   $0x0
  801eed:	6a 00                	push   $0x0
  801eef:	ff 75 10             	pushl  0x10(%ebp)
  801ef2:	ff 75 0c             	pushl  0xc(%ebp)
  801ef5:	ff 75 08             	pushl  0x8(%ebp)
  801ef8:	6a 12                	push   $0x12
  801efa:	e8 1f fb ff ff       	call   801a1e <syscall>
  801eff:	83 c4 18             	add    $0x18,%esp
	return ;
  801f02:	90                   	nop
}
  801f03:	c9                   	leave  
  801f04:	c3                   	ret    

00801f05 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801f05:	55                   	push   %ebp
  801f06:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801f08:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f0b:	8b 45 08             	mov    0x8(%ebp),%eax
  801f0e:	6a 00                	push   $0x0
  801f10:	6a 00                	push   $0x0
  801f12:	6a 00                	push   $0x0
  801f14:	52                   	push   %edx
  801f15:	50                   	push   %eax
  801f16:	6a 2a                	push   $0x2a
  801f18:	e8 01 fb ff ff       	call   801a1e <syscall>
  801f1d:	83 c4 18             	add    $0x18,%esp
	return;
  801f20:	90                   	nop
}
  801f21:	c9                   	leave  
  801f22:	c3                   	ret    

00801f23 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801f23:	55                   	push   %ebp
  801f24:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801f26:	6a 00                	push   $0x0
  801f28:	6a 00                	push   $0x0
  801f2a:	6a 00                	push   $0x0
  801f2c:	6a 00                	push   $0x0
  801f2e:	6a 00                	push   $0x0
  801f30:	6a 2b                	push   $0x2b
  801f32:	e8 e7 fa ff ff       	call   801a1e <syscall>
  801f37:	83 c4 18             	add    $0x18,%esp
}
  801f3a:	c9                   	leave  
  801f3b:	c3                   	ret    

00801f3c <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801f3c:	55                   	push   %ebp
  801f3d:	89 e5                	mov    %esp,%ebp
  801f3f:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801f42:	83 ec 04             	sub    $0x4,%esp
  801f45:	68 08 2d 80 00       	push   $0x802d08
  801f4a:	68 0a 01 00 00       	push   $0x10a
  801f4f:	68 18 2d 80 00       	push   $0x802d18
  801f54:	e8 12 e9 ff ff       	call   80086b <_panic>

00801f59 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801f59:	55                   	push   %ebp
  801f5a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801f5c:	6a 00                	push   $0x0
  801f5e:	6a 00                	push   $0x0
  801f60:	6a 00                	push   $0x0
  801f62:	ff 75 0c             	pushl  0xc(%ebp)
  801f65:	ff 75 08             	pushl  0x8(%ebp)
  801f68:	6a 33                	push   $0x33
  801f6a:	e8 af fa ff ff       	call   801a1e <syscall>
  801f6f:	83 c4 18             	add    $0x18,%esp
	return;
  801f72:	90                   	nop
}
  801f73:	c9                   	leave  
  801f74:	c3                   	ret    

00801f75 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801f75:	55                   	push   %ebp
  801f76:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801f78:	6a 00                	push   $0x0
  801f7a:	6a 00                	push   $0x0
  801f7c:	6a 00                	push   $0x0
  801f7e:	ff 75 0c             	pushl  0xc(%ebp)
  801f81:	ff 75 08             	pushl  0x8(%ebp)
  801f84:	6a 34                	push   $0x34
  801f86:	e8 93 fa ff ff       	call   801a1e <syscall>
  801f8b:	83 c4 18             	add    $0x18,%esp
	return ;
  801f8e:	90                   	nop
}
  801f8f:	c9                   	leave  
  801f90:	c3                   	ret    
  801f91:	66 90                	xchg   %ax,%ax
  801f93:	90                   	nop

00801f94 <__udivdi3>:
  801f94:	55                   	push   %ebp
  801f95:	57                   	push   %edi
  801f96:	56                   	push   %esi
  801f97:	53                   	push   %ebx
  801f98:	83 ec 1c             	sub    $0x1c,%esp
  801f9b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801f9f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801fa3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801fa7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801fab:	89 ca                	mov    %ecx,%edx
  801fad:	89 f8                	mov    %edi,%eax
  801faf:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801fb3:	85 f6                	test   %esi,%esi
  801fb5:	75 2d                	jne    801fe4 <__udivdi3+0x50>
  801fb7:	39 cf                	cmp    %ecx,%edi
  801fb9:	77 65                	ja     802020 <__udivdi3+0x8c>
  801fbb:	89 fd                	mov    %edi,%ebp
  801fbd:	85 ff                	test   %edi,%edi
  801fbf:	75 0b                	jne    801fcc <__udivdi3+0x38>
  801fc1:	b8 01 00 00 00       	mov    $0x1,%eax
  801fc6:	31 d2                	xor    %edx,%edx
  801fc8:	f7 f7                	div    %edi
  801fca:	89 c5                	mov    %eax,%ebp
  801fcc:	31 d2                	xor    %edx,%edx
  801fce:	89 c8                	mov    %ecx,%eax
  801fd0:	f7 f5                	div    %ebp
  801fd2:	89 c1                	mov    %eax,%ecx
  801fd4:	89 d8                	mov    %ebx,%eax
  801fd6:	f7 f5                	div    %ebp
  801fd8:	89 cf                	mov    %ecx,%edi
  801fda:	89 fa                	mov    %edi,%edx
  801fdc:	83 c4 1c             	add    $0x1c,%esp
  801fdf:	5b                   	pop    %ebx
  801fe0:	5e                   	pop    %esi
  801fe1:	5f                   	pop    %edi
  801fe2:	5d                   	pop    %ebp
  801fe3:	c3                   	ret    
  801fe4:	39 ce                	cmp    %ecx,%esi
  801fe6:	77 28                	ja     802010 <__udivdi3+0x7c>
  801fe8:	0f bd fe             	bsr    %esi,%edi
  801feb:	83 f7 1f             	xor    $0x1f,%edi
  801fee:	75 40                	jne    802030 <__udivdi3+0x9c>
  801ff0:	39 ce                	cmp    %ecx,%esi
  801ff2:	72 0a                	jb     801ffe <__udivdi3+0x6a>
  801ff4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801ff8:	0f 87 9e 00 00 00    	ja     80209c <__udivdi3+0x108>
  801ffe:	b8 01 00 00 00       	mov    $0x1,%eax
  802003:	89 fa                	mov    %edi,%edx
  802005:	83 c4 1c             	add    $0x1c,%esp
  802008:	5b                   	pop    %ebx
  802009:	5e                   	pop    %esi
  80200a:	5f                   	pop    %edi
  80200b:	5d                   	pop    %ebp
  80200c:	c3                   	ret    
  80200d:	8d 76 00             	lea    0x0(%esi),%esi
  802010:	31 ff                	xor    %edi,%edi
  802012:	31 c0                	xor    %eax,%eax
  802014:	89 fa                	mov    %edi,%edx
  802016:	83 c4 1c             	add    $0x1c,%esp
  802019:	5b                   	pop    %ebx
  80201a:	5e                   	pop    %esi
  80201b:	5f                   	pop    %edi
  80201c:	5d                   	pop    %ebp
  80201d:	c3                   	ret    
  80201e:	66 90                	xchg   %ax,%ax
  802020:	89 d8                	mov    %ebx,%eax
  802022:	f7 f7                	div    %edi
  802024:	31 ff                	xor    %edi,%edi
  802026:	89 fa                	mov    %edi,%edx
  802028:	83 c4 1c             	add    $0x1c,%esp
  80202b:	5b                   	pop    %ebx
  80202c:	5e                   	pop    %esi
  80202d:	5f                   	pop    %edi
  80202e:	5d                   	pop    %ebp
  80202f:	c3                   	ret    
  802030:	bd 20 00 00 00       	mov    $0x20,%ebp
  802035:	89 eb                	mov    %ebp,%ebx
  802037:	29 fb                	sub    %edi,%ebx
  802039:	89 f9                	mov    %edi,%ecx
  80203b:	d3 e6                	shl    %cl,%esi
  80203d:	89 c5                	mov    %eax,%ebp
  80203f:	88 d9                	mov    %bl,%cl
  802041:	d3 ed                	shr    %cl,%ebp
  802043:	89 e9                	mov    %ebp,%ecx
  802045:	09 f1                	or     %esi,%ecx
  802047:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80204b:	89 f9                	mov    %edi,%ecx
  80204d:	d3 e0                	shl    %cl,%eax
  80204f:	89 c5                	mov    %eax,%ebp
  802051:	89 d6                	mov    %edx,%esi
  802053:	88 d9                	mov    %bl,%cl
  802055:	d3 ee                	shr    %cl,%esi
  802057:	89 f9                	mov    %edi,%ecx
  802059:	d3 e2                	shl    %cl,%edx
  80205b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80205f:	88 d9                	mov    %bl,%cl
  802061:	d3 e8                	shr    %cl,%eax
  802063:	09 c2                	or     %eax,%edx
  802065:	89 d0                	mov    %edx,%eax
  802067:	89 f2                	mov    %esi,%edx
  802069:	f7 74 24 0c          	divl   0xc(%esp)
  80206d:	89 d6                	mov    %edx,%esi
  80206f:	89 c3                	mov    %eax,%ebx
  802071:	f7 e5                	mul    %ebp
  802073:	39 d6                	cmp    %edx,%esi
  802075:	72 19                	jb     802090 <__udivdi3+0xfc>
  802077:	74 0b                	je     802084 <__udivdi3+0xf0>
  802079:	89 d8                	mov    %ebx,%eax
  80207b:	31 ff                	xor    %edi,%edi
  80207d:	e9 58 ff ff ff       	jmp    801fda <__udivdi3+0x46>
  802082:	66 90                	xchg   %ax,%ax
  802084:	8b 54 24 08          	mov    0x8(%esp),%edx
  802088:	89 f9                	mov    %edi,%ecx
  80208a:	d3 e2                	shl    %cl,%edx
  80208c:	39 c2                	cmp    %eax,%edx
  80208e:	73 e9                	jae    802079 <__udivdi3+0xe5>
  802090:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802093:	31 ff                	xor    %edi,%edi
  802095:	e9 40 ff ff ff       	jmp    801fda <__udivdi3+0x46>
  80209a:	66 90                	xchg   %ax,%ax
  80209c:	31 c0                	xor    %eax,%eax
  80209e:	e9 37 ff ff ff       	jmp    801fda <__udivdi3+0x46>
  8020a3:	90                   	nop

008020a4 <__umoddi3>:
  8020a4:	55                   	push   %ebp
  8020a5:	57                   	push   %edi
  8020a6:	56                   	push   %esi
  8020a7:	53                   	push   %ebx
  8020a8:	83 ec 1c             	sub    $0x1c,%esp
  8020ab:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8020af:	8b 74 24 34          	mov    0x34(%esp),%esi
  8020b3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8020b7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8020bb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8020bf:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8020c3:	89 f3                	mov    %esi,%ebx
  8020c5:	89 fa                	mov    %edi,%edx
  8020c7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8020cb:	89 34 24             	mov    %esi,(%esp)
  8020ce:	85 c0                	test   %eax,%eax
  8020d0:	75 1a                	jne    8020ec <__umoddi3+0x48>
  8020d2:	39 f7                	cmp    %esi,%edi
  8020d4:	0f 86 a2 00 00 00    	jbe    80217c <__umoddi3+0xd8>
  8020da:	89 c8                	mov    %ecx,%eax
  8020dc:	89 f2                	mov    %esi,%edx
  8020de:	f7 f7                	div    %edi
  8020e0:	89 d0                	mov    %edx,%eax
  8020e2:	31 d2                	xor    %edx,%edx
  8020e4:	83 c4 1c             	add    $0x1c,%esp
  8020e7:	5b                   	pop    %ebx
  8020e8:	5e                   	pop    %esi
  8020e9:	5f                   	pop    %edi
  8020ea:	5d                   	pop    %ebp
  8020eb:	c3                   	ret    
  8020ec:	39 f0                	cmp    %esi,%eax
  8020ee:	0f 87 ac 00 00 00    	ja     8021a0 <__umoddi3+0xfc>
  8020f4:	0f bd e8             	bsr    %eax,%ebp
  8020f7:	83 f5 1f             	xor    $0x1f,%ebp
  8020fa:	0f 84 ac 00 00 00    	je     8021ac <__umoddi3+0x108>
  802100:	bf 20 00 00 00       	mov    $0x20,%edi
  802105:	29 ef                	sub    %ebp,%edi
  802107:	89 fe                	mov    %edi,%esi
  802109:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80210d:	89 e9                	mov    %ebp,%ecx
  80210f:	d3 e0                	shl    %cl,%eax
  802111:	89 d7                	mov    %edx,%edi
  802113:	89 f1                	mov    %esi,%ecx
  802115:	d3 ef                	shr    %cl,%edi
  802117:	09 c7                	or     %eax,%edi
  802119:	89 e9                	mov    %ebp,%ecx
  80211b:	d3 e2                	shl    %cl,%edx
  80211d:	89 14 24             	mov    %edx,(%esp)
  802120:	89 d8                	mov    %ebx,%eax
  802122:	d3 e0                	shl    %cl,%eax
  802124:	89 c2                	mov    %eax,%edx
  802126:	8b 44 24 08          	mov    0x8(%esp),%eax
  80212a:	d3 e0                	shl    %cl,%eax
  80212c:	89 44 24 04          	mov    %eax,0x4(%esp)
  802130:	8b 44 24 08          	mov    0x8(%esp),%eax
  802134:	89 f1                	mov    %esi,%ecx
  802136:	d3 e8                	shr    %cl,%eax
  802138:	09 d0                	or     %edx,%eax
  80213a:	d3 eb                	shr    %cl,%ebx
  80213c:	89 da                	mov    %ebx,%edx
  80213e:	f7 f7                	div    %edi
  802140:	89 d3                	mov    %edx,%ebx
  802142:	f7 24 24             	mull   (%esp)
  802145:	89 c6                	mov    %eax,%esi
  802147:	89 d1                	mov    %edx,%ecx
  802149:	39 d3                	cmp    %edx,%ebx
  80214b:	0f 82 87 00 00 00    	jb     8021d8 <__umoddi3+0x134>
  802151:	0f 84 91 00 00 00    	je     8021e8 <__umoddi3+0x144>
  802157:	8b 54 24 04          	mov    0x4(%esp),%edx
  80215b:	29 f2                	sub    %esi,%edx
  80215d:	19 cb                	sbb    %ecx,%ebx
  80215f:	89 d8                	mov    %ebx,%eax
  802161:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802165:	d3 e0                	shl    %cl,%eax
  802167:	89 e9                	mov    %ebp,%ecx
  802169:	d3 ea                	shr    %cl,%edx
  80216b:	09 d0                	or     %edx,%eax
  80216d:	89 e9                	mov    %ebp,%ecx
  80216f:	d3 eb                	shr    %cl,%ebx
  802171:	89 da                	mov    %ebx,%edx
  802173:	83 c4 1c             	add    $0x1c,%esp
  802176:	5b                   	pop    %ebx
  802177:	5e                   	pop    %esi
  802178:	5f                   	pop    %edi
  802179:	5d                   	pop    %ebp
  80217a:	c3                   	ret    
  80217b:	90                   	nop
  80217c:	89 fd                	mov    %edi,%ebp
  80217e:	85 ff                	test   %edi,%edi
  802180:	75 0b                	jne    80218d <__umoddi3+0xe9>
  802182:	b8 01 00 00 00       	mov    $0x1,%eax
  802187:	31 d2                	xor    %edx,%edx
  802189:	f7 f7                	div    %edi
  80218b:	89 c5                	mov    %eax,%ebp
  80218d:	89 f0                	mov    %esi,%eax
  80218f:	31 d2                	xor    %edx,%edx
  802191:	f7 f5                	div    %ebp
  802193:	89 c8                	mov    %ecx,%eax
  802195:	f7 f5                	div    %ebp
  802197:	89 d0                	mov    %edx,%eax
  802199:	e9 44 ff ff ff       	jmp    8020e2 <__umoddi3+0x3e>
  80219e:	66 90                	xchg   %ax,%ax
  8021a0:	89 c8                	mov    %ecx,%eax
  8021a2:	89 f2                	mov    %esi,%edx
  8021a4:	83 c4 1c             	add    $0x1c,%esp
  8021a7:	5b                   	pop    %ebx
  8021a8:	5e                   	pop    %esi
  8021a9:	5f                   	pop    %edi
  8021aa:	5d                   	pop    %ebp
  8021ab:	c3                   	ret    
  8021ac:	3b 04 24             	cmp    (%esp),%eax
  8021af:	72 06                	jb     8021b7 <__umoddi3+0x113>
  8021b1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8021b5:	77 0f                	ja     8021c6 <__umoddi3+0x122>
  8021b7:	89 f2                	mov    %esi,%edx
  8021b9:	29 f9                	sub    %edi,%ecx
  8021bb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8021bf:	89 14 24             	mov    %edx,(%esp)
  8021c2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8021c6:	8b 44 24 04          	mov    0x4(%esp),%eax
  8021ca:	8b 14 24             	mov    (%esp),%edx
  8021cd:	83 c4 1c             	add    $0x1c,%esp
  8021d0:	5b                   	pop    %ebx
  8021d1:	5e                   	pop    %esi
  8021d2:	5f                   	pop    %edi
  8021d3:	5d                   	pop    %ebp
  8021d4:	c3                   	ret    
  8021d5:	8d 76 00             	lea    0x0(%esi),%esi
  8021d8:	2b 04 24             	sub    (%esp),%eax
  8021db:	19 fa                	sbb    %edi,%edx
  8021dd:	89 d1                	mov    %edx,%ecx
  8021df:	89 c6                	mov    %eax,%esi
  8021e1:	e9 71 ff ff ff       	jmp    802157 <__umoddi3+0xb3>
  8021e6:	66 90                	xchg   %ax,%ax
  8021e8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8021ec:	72 ea                	jb     8021d8 <__umoddi3+0x134>
  8021ee:	89 d9                	mov    %ebx,%ecx
  8021f0:	e9 62 ff ff ff       	jmp    802157 <__umoddi3+0xb3>
