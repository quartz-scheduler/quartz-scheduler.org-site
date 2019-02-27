<div class="secNavPanel"><a href=".">Contents</a> | <a href="Example3">Next&nbsp;&rsaquo;</a></div>





# Example 1 - Your First Quartz Program

## Overview {#Example1-Overview}
This example is designed to demonstrate how to get up and running with Quartz.   This example will fire off a simple job that says "Hello World".

The program will perform the following actions:


+ Start up the Quartz Scheduler
+ Schedule a job to run at the next even minute
+ Wait for 90 seconds to give Quartz a chance to run the job
+ Shut down the Scheduler



## Running the Example {#Example1-RunningtheExample}
This example can be executed from the **examples/example1** directory.   There are two out-of-the-box methods for running this example


+ **example1.sh** - A UNIX/Linux shell script
+ **example1.bat** - A Windows Batch file



## The Code {#Example1-TheCode}
The code for this example resides in the package **org.quartz.examples.example1**.   

The code in this example is made up of the following classes:

<table><thead>
<tr>
<th> Class Name </th>
<th> Description</th>
</tr>
</thead>
<tbody>
<tr>
<td> SimpleExample </td>
<td> The main program</td>

</tr>
<tr>
<td> HelloJob </td>
<td> A simple job that says Hello World</td>
</tr>
</tbody></table>

### HelloJob {#Example1-HelloJob}
HelloJob is a simple job that implements the *Job* interface and logs a nice message to the log (by default, this will simply go to the screen).   The current date and time is printed in the job so that you can see exactly when the job is run.


<pre>
public void execute(JobExecutionContext context) throws JobExecutionException {
    // Say Hello to the World and display the date/time
    _log.info("Hello World! - " + new Date());
}
</pre>



### SimpleExample {#Example1-SimpleExample}
The program starts by getting an instance of the Scheduler.  This is done by creating a *StdSchedulerFactory* and then using it to create a scheduler.   This will create a simple, RAM-based scheduler.


<pre>
SchedulerFactory sf = new StdSchedulerFactory();
Scheduler sched = sf.getScheduler();
</pre>


The HelloJob is defined as a Job to Quartz using the *JobDetail* class:

<pre>
// define the job and tie it to our HelloJob class
JobDetail job = new JobDetail("job1", "group1", HelloJob.class);
</pre>


We create a *SimpleTrigger* that will fire off at the next round minute:

<pre>
// compute a time that is on the next round minute
Date runTime = TriggerUtils.getEvenMinuteDate(new Date());

// Trigger the job to run on the next round minute
SimpleTrigger trigger = new SimpleTrigger("trigger1", "group1", runTime);
</pre>


We now will associate the Job to the Trigger in the scheduler:

<pre>
// Tell quartz to schedule the job using our trigger
sched.scheduleJob(job, trigger);
</pre>


At this point, the job has been schedule to run when its trigger fires.  However, the scheduler is not yet running.   So, we must tell the scheduler to start up!

<pre>
sched.start();
</pre>


To let the program have an opportunity to run the job, we then sleep for 90 seconds.  The scheduler is running in the background and should fire off the job during those 90 seonds.

<pre>
Thread.sleep(90L * 1000L);
</pre>


Finally, we will gracefully shutdown the scheduler:

<pre>
sched.shutdown(true);
</pre>


Note:  passing *true* into the *shutdown* message tells the Quartz Scheduler to wait until all jobs have completed running before returning from the method call.




