<div class="secNavPanel"><a href=".">Contents</a> | <a href="Example4">&lsaquo;&nbsp;Prev</a> | <a href="Example6">Next&nbsp;&rsaquo;</a></div>





# Example 5 - Job Misfires

## Overview {#Example5-Overview}
This example is designed to demonstrate how you can pass run-time parameters into quartz jobs and how you can maintain state in a job.

The program will perform the following actions:


+ Start up the Quartz Scheduler
+ Schedule two jobs, each job will execute the every three seconds, indefinitely
+ The jobs will take ten seconds to run (preventing the execution trigger from firing every three seconds)
+ Each job has different misfire instructions
+ The program will wait 10 minutes so that the two jobs have plenty of time to run
+ Shut down the Scheduler




## Running the Example {#Example5-RunningtheExample}
This example can be executed from the **examples/example5** directory.   There are two out-of-the-box methods for running this example


+ **example5.sh** - A UNIX/Linux shell script
+ **example5.bat** - A Windows Batch file



## The Code {#Example5-TheCode}

The code for this example resides in the package **org.quartz.examples.example5**.   

The code in this example is made up of the following classes:

<table><thead>
<tr>
<th> Class Name </th>
<th> Description</th>
</tr>
</thead>
<tbody>
<tr>
<td> MisfireExample </td>
<td> The main program</td>
</tr>
<tr>
<td> MisfireJob </td>
<td> A simple job that takes 10 seconds to run</td>
</tr>
</tbody></table>

### MisfireJob  {#Example5-MisfireJob}

MisfireJob is a simple job that prints its execution time and then will wait for a period of time before completing.  The amount of wait time is defined by the job parameter EXECUTION_DELAY.  If this job parameter is not passed in, the job will default to a wait time of 5 seconds:



<pre>
        // default delay to five seconds
        long delay = 5000L;

        // use the delay passed in as a job parameter (if it exists)
        JobDataMap map = context.getJobDetail().getJobDataMap();
        if (map.containsKey(EXECUTION_DELAY)) {
        	delay = map.getLong(EXECUTION_DELAY);
        }

        try {
            Thread.sleep(delay);
        } 
        catch (Exception ignore) {
        }
</pre>



### MisfireExample {#Example5-MisfireExample}

The program starts by getting an instance of the Scheduler.  This is done by creating a *StdSchedulerFactory* and then using it to create a scheduler.   This will create a simple, RAM-based scheduler.


<pre>
SchedulerFactory sf = new StdSchedulerFactory();
Scheduler sched = sf.getScheduler();
</pre>


Job #1 is scheduled to run every 3 seconds indefinitely.  An execution delay of 10 seconds is passed into the job:

<pre>
JobDetail job = new JobDetail("statefulJob1", "group1",
                StatefulDumbJob.class);
        job.getJobDataMap().put(MisfireJob.EXECUTION_DELAY, 10000L);
        SimpleTrigger trigger = new SimpleTrigger("trigger1", "group1", 
        		new Date(ts), null, 
        		SimpleTrigger.REPEAT_INDEFINITELY, 3000L);
        Date ft = sched.scheduleJob(job, trigger);
</pre>



Job #2 is scheduled to run every 3 seconds indefinitely.  An execution delay of 10 seconds is passed into the job:

<pre>
job = new JobDetail("statefulJob2", "group1", StatefulDumbJob.class);
        job.getJobDataMap().put(MisfireJob.EXECUTION_DELAY, 10000L);
        trigger = new SimpleTrigger("trigger2", "group1", 
        		new Date(ts), null,
                SimpleTrigger.REPEAT_INDEFINITELY, 3000L);
        trigger      	.setMisfireInstruction(SimpleTrigger.MISFIRE_INSTRUCTION_RESCHEDULE_NOW_WITH_EXISTING_REPEAT_COUNT);
        ft = sched.scheduleJob(job, trigger);
</pre>


Note:  The trigger for job #2 is set with a misfire instruction that will cause it to reschedule with the existing repeat count.   This policy forces quartz to refire the tirgger as soon as possible.   Job #1 uses the default "smart" trigger policy in quartz, which causes the trigger to fire at it's next normal execution time.


The scheduler is then started.


<pre>
sched.start();
</pre>


To let the program have an opportunity to run the job, we then sleep for ten minutes (600 seconds)

<pre>
Thread.sleep(600L * 1000L);
</pre>


Finally, we will gracefully shutdown the scheduler:

<pre>
sched.shutdown(true);
</pre>


Note:  passing *true* into the *shutdown* message tells the Quartz Scheduler to wait until all jobs have completed running before returning from the method call.



