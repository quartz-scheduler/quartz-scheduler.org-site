<div class="secNavPanel"><a href=".">Contents</a> | <a href="Example3">&lsaquo;&nbsp;Prev</a> | <a href="Example5">Next&nbsp;&rsaquo;</a></div>





# Example 4 - Job Parameters and Job State

## Overview {#Example4-Overview}
This example is designed to demonstrate how you can pass run-time parameters into quartz jobs and how you can maintain state in a job.

The program will perform the following actions:


+ Start up the Quartz Scheduler
+ Schedule two jobs, each job will execute the every ten seconds for a total of times
+ The scheduler will pass a run-time job parameter of "Green" to the first job instance
+ The scheduler will pass a run-time job parameter of "Red" to the second job instance
+ The program will wait 60 seconds so that the two jobs have plenty of time to run
+ Shut down the Scheduler




## Running the Example {#Example4-RunningtheExample}
This example can be executed from the **examples/example4** directory.   There are two out-of-the-box methods for running this example


+ **example4.sh** - A UNIX/Linux shell script
+ **example4.bat** - A Windows Batch file



## The Code {#Example4-TheCode}

The code for this example resides in the package **org.quartz.examples.example4**.   

The code in this example is made up of the following classes:

<table><thead>
<tr>
<th> Class Name </th>
<th> Description</th>
</tr>
</thead>
<tbody>
<tr>
<td> JobStateExample </td>
<td> The main program</td>
</tr>
<tr>
<td> ColorJob </td>
<td> A simple job that prints a favorite color (passed in as a run-time parameter) and displays its execution count.</td>
</tr>
</tbody></table>

### ColorJob {#Example4-ColorJob}

ColorJob is a simple job that implements the *StateFulJob* interface and logs the following information when the job is executed:


+ The time/date of execution
+ The job's favorite color (which is passed in as a run-time parameter)
+ The job's execution count calculated from a member variable
+ The job's execution count maintained as a job map parameter




<pre>
_log.info("ColorJob: " + jobName + " executing at " + new Date() + "\n" +
    "  favorite color is " + favoriteColor + "\n" + 
    "  execution count (from job map) is " + count + "\n" + 
    "  execution count (from job member variable) is " + _counter);
</pre>


The variable *favoriteColor* is passed in as a job parameter.  It is retrieved as follows from the *JobDataMap*:


<pre>
JobDataMap data = context.getJobDetail().getJobDataMap();
String favoriteColor = data.getString(FAVORITE_COLOR);
</pre>


The variable *count* is stored in the job data map as well:


<pre>
JobDataMap data = context.getJobDetail().getJobDataMap();
int count = data.getInt(EXECUTION_COUNT);
</pre>


The variable is later incremented and stored back into the job data map so that job state can be preserved:


<pre>
count++;
data.put(EXECUTION_COUNT, count);
</pre>


There is also a member variable named *counter*.   This variable is defined as a member variable to the class:


<pre>
private int _counter = 1;
</pre>


This variable is also incremented and displayed.  However, its count will always be displayed as "1" because Quartz will always instantiate a new instance of the class during each execution.   This prevents member variables from being used to maintain state.

### JobStateExample  {#Example4-JobStateExample}
The program starts by getting an instance of the Scheduler.  This is done by creating a *StdSchedulerFactory* and then using it to create a scheduler.   This will create a simple, RAM-based scheduler.


<pre>
SchedulerFactory sf = new StdSchedulerFactory();
Scheduler sched = sf.getScheduler();
</pre>


Job #1 is scheduled to run every 10 seconds, for a maximum of five times:

<pre>
JobDetail job1 = new JobDetail("job1", "group1", ColorJob.class);
		SimpleTrigger trigger1 = new SimpleTrigger("trigger1", "group1", "job1", "group1",
				new Date(ts), null, 4, 10000);
		// pass initialization parameters into the job
</pre>


Job #1 is passed in two job parameters.   One is a favorite color, with a value of "Green".  The other is an execution count, which is initialized with a value of 1.

<pre>
job1.getJobDataMap().put(ColorJob.FAVORITE_COLOR, "Green");
		job1.getJobDataMap().put(ColorJob.EXECUTION_COUNT, 1);
</pre>


Job #2 is also scheduled to run every 10 seconds, for a maximum of five times:

<pre>
JobDetail job2 = new JobDetail("job2", "group1", ColorJob.class);
		SimpleTrigger trigger2 = new SimpleTrigger("trigger2", "group1", "job2", "group1",
				new Date(ts + 1000), null, 4, 10000);
</pre>


Job #2 is also passed in two job parameters.   One is a favorite color, with a value of "Red".  The other is an execution count, which is initialized with a value of 1.

<pre>
job2.getJobDataMap().put(ColorJob.FAVORITE_COLOR, "Red");
		job2.getJobDataMap().put(ColorJob.EXECUTION_COUNT, 1);
</pre>



The scheduler is then started.


<pre>
sched.start();
</pre>


To let the program have an opportunity to run the job, we then sleep for one minute (60 seconds)

<pre>
Thread.sleep(60L * 1000L);
</pre>


Finally, we will gracefully shutdown the scheduler:

<pre>
sched.shutdown(true);
</pre>


Note:  passing *true* into the *shutdown* message tells the Quartz Scheduler to wait until all jobs have completed running before returning from the method call.




