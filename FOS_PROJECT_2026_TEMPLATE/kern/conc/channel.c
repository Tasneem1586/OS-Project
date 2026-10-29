/*
 * channel.c
 *
 *  Created on: Sep 22, 2024
 *      Author: HP
 */
#include "channel.h"
#include <kern/proc/user_environment.h>
#include <kern/cpu/sched.h>
#include <kern/cpu/cpu.h>
#include <inc/string.h>
#include <inc/disk.h>

/************************************************************************************/
//==================================================================================//
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.GM#4] BLOCKING - [0] GIVEN FUNCTIONS
//===============================
// 1) INITIALIZE THE CHANNEL:
//===============================
// initialize its lock & queue
void init_channel(struct Channel *chan, char *name)
{
	strcpy(chan->name, name);
	init_queue(&(chan->queue));
}
/************************************************************************************/

//=====================================================================================//
//============================== REQUIRED FUNCTIONS ===================================//
//=====================================================================================//
//===============================
// 2) SLEEP ON A GIVEN CHANNEL:
//===============================
// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
// Ref: xv6-x86 OS code.


//TODO: [PROJECT'26.GM#4] BLOCKING - [13] Channel sleep
void sleep(struct Channel *chan, struct kspinlock* lk)
{
	 struct Env *e = get_cpu_proc();
	    if (e == NULL)
	        panic("sleep: no current process");
	    acquire_kspinlock(&ProcessQueues.qlock);
	    release_kspinlock(lk);
	    e->channel = chan;
	    e->env_status = ENV_BLOCKED;
	    enqueue(&chan->queue, e);
	    sched();
	    e->channel = NULL;
	    release_kspinlock(&ProcessQueues.qlock);
	    acquire_kspinlock(lk);
	panic("sleep() is not implemented yet...!!");
}

//==================================================
// 3) WAKEUP ONE BLOCKED PROCESS ON A GIVEN CHANNEL:
//==================================================
// Wake up ONE process sleeping on chan.
// The qlock must be held.
// Ref: xv6-x86 OS code
// chan MUST be of type "struct Env_Queue" to hold the blocked processes
//TODO: [PROJECT'26.GM#4] BLOCKING - [14] Channel wakeup_one
void wakeup_one(struct Channel *chan)
{
    struct Env *e;
    acquire_kspinlock(&ProcessQueues.qlock);
    e = dequeue(&chan->queue);
    if (e != NULL) {
        e->channel = NULL;
        e->env_status = ENV_READY;
        sched_insert_ready(e);
    }
    release_kspinlock(&ProcessQueues.qlock);
	panic("wakeup_one() is not implemented yet...!!");
}

//====================================================
// 4) WAKEUP ALL BLOCKED PROCESSES ON A GIVEN CHANNEL:
//====================================================
// Wake up all processes sleeping on chan.
// The queues lock must be held.
// Ref: xv6-x86 OS code
// chan MUST be of type "struct Env_Queue" to hold the blocked processes
//TODO: [PROJECT'26.GM#4] BLOCKING - [15] Channel wakeup_all

void wakeup_all(struct Channel *chan)
{
	struct Env *e;

	    acquire_kspinlock(&ProcessQueues.qlock);

	    while ((e = dequeue(&chan->queue)) != NULL) {
	        e->channel = NULL;
	        e->env_status = ENV_READY;
	        sched_insert_ready(e);
	    }

	    release_kspinlock(&ProcessQueues.qlock);
	panic("wakeup_all() is not implemented yet...!!");
}
