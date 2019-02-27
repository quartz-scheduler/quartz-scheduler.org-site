<div class="secNavPanel"><a href=".">Contents</a> | <a href="Example1">&lsaquo;&nbsp;Prev</a> | <a href="Example4">Next&nbsp;&rsaquo;</a></div>





# Example 3 - Cron-based Triggers

## Overview {#Example3-Overview}
This example is designed to demonstrate how you can use Cron Triggers to schedule jobs.   This example will fire off several simple jobs that say "Hello World" and display the date and time that the job was executed.

The program will perform the following actions:


+ Start up the Quartz Scheduler
+ Schedule several jobs using various features of CronTrigger
+ Wait for 300 seconds (5 minutes) to give Quartz a chance to run the jobs
+ Shut down the Scheduler



Note:  Refer to the Quartz javadoc for a thorough explanation of CronTrigger.

## Running the Example {#Example3-RunningtheExample}
This example can be executed from the **examples/example3** directory.   There are two out-of-the-box methods for running this example


+ **example3.sh** - A UNIX/Linux shell script
+ **example3.bat** - A Windows Batch file



## The Code {#Example3-TheCode}

The code for this example resides in the package **org.quartz.examples.example3**.   

The code in this example is made up of the following classes:

<table><thead>
<tr>
<th> Class Name </th>
<th> Description</th>
</tr>
</thead>
<tbody>
<tr>
<td> CronTriggerExample </td>
<td> The main program</td>
</tr>
<tr>
<td> SimpleJob </td>
<td> A simple job that says Hello World and displays the date/time</td>
</tr>
</tbody></table>

### SimpleJob {#Example3-SimpleJob}
SimpleJob is a simple job that implements the *Job* interface and logs a nice message to the log (by default, this will simply go to the screen).   The current date and time is printed in the job so that you can see exactly when the job is run.


<pre>
public void execute(JobExecutionContext context) throws JobExecutionException {
    String jobName = context.getJobDetail().getFullName();
    _log.info("SimpleJob says: " + jobName + " executing at " + new Date());
}
</pre>


### CronTriggerExample {#Example3-CronTriggerExample}
The program starts by getting an instance of the Scheduler.  This is done by creating a *StdSchedulerFactory* and then using it to create a scheduler.   This will create a simple, RAM-based scheduler.


<pre>
SchedulerFactory sf = new StdSchedulerFactory();
Scheduler sched = sf.getScheduler();
</pre>


Job #1 is scheduled to run every 20 seconds

<pre>
JobDetail job = new JobDetail("job1", "group1", SimpleJob.class);
CronTrigger trigger = new CronTrigger("trigger1", "group1", "job1", "group1", "0/20 * * * * ?");
sched.addJob(job, true);
</pre>


Job #2 is scheduled to run every other minute, starting at 15 seconds past the minute.

<pre>
job = new JobDetail("job2", "group1", SimpleJob.class);
trigger = new CronTrigger("trigger2", "group1", "job2", "group1", "15 0/2 * * * ?");
sched.addJob(job, true);
</pre>


Job #3 is scheduled to every other minute, between 8am and 5pm (17 o'clock).

<pre>
job = new JobDetail("job3", "group1", SimpleJob.class);
trigger = new CronTrigger("trigger3", "group1", "job3", "group1", "0 0/2 8-17 * * ?");
sched.addJob(job, true);
</pre>


Job #4 is scheduled to run every 20 seconds

<pre>
job = new JobDetail("job4", "group1", SimpleJob.class);
trigger = new CronTrigger("trigger4", "group1", "job4", "group1", "0 0/3 17-23 * * ?");
sched.addJob(job, true);
</pre>


Job #5 is scheduled to run at 10am on the 1st and 15th days of the month

<pre>
job = new JobDetail("job5", "group1", SimpleJob.class);
trigger = new CronTrigger("trigger5", "group1", "job5", "group1", "0 0 10am 1,15 * ?");
sched.addJob(job, true);
</pre>


Job #6 is scheduled to run every 30 seconds on Weekdays (Monday through Friday)

<pre>
job = new JobDetail("job6", "group1", SimpleJob.class);
trigger = new CronTrigger("trigger6", "group1", "job6", "group1", "0,30 * * ? * MON-FRI");
sched.addJob(job, true);
</pre>


Job #7 is scheduled to run every 30 seconds on Weekends (Saturday and Sunday)

<pre>
job = new JobDetail("job7", "group1", SimpleJob.class);
trigger = new CronTrigger("trigger7", "group1", "job7", "group1", "0,30 * * ? * SAT,SUN");
sched.addJob(job, true);
</pre>


The scheduler is then started.


<pre>
sched.start();
</pre>


To let the program have an opportunity to run the job, we then sleep for five minutes (300 seconds).  The scheduler is running in the background and should fire off several jobs during that time. 

Note:  Because many of the jobs have hourly and daily restrictions on them, not all of the jobs will run in this example.   For example:   Job #6 only runs on Weekdays while Job #7 only runs on Weekends.

<pre>
Thread.sleep(300L * 1000L);
</pre>


Finally, we will gracefully shutdown the scheduler:

<pre>
sched.shutdown(true);
</pre>

Note:  passing *true* into the *shutdown* message tells the Quartz Scheduler to wait until all jobs have completed running before returning from the method call.




