<div class="secNavPanel"><a href=".">Contents</a> | <a href="UpdateJob">&lsaquo;&nbsp;Prev</a> | <a href="JobInitPlugin">Next&nbsp;&rsaquo;</a></div>





# How-To: Updating a trigger

### Updating a trigger

<pre>

Scheduler sched = StdSchedulerFactory.getDefaultScheduler();
Date startDate = new java.util.Date();
long runEveryInMilliseconds = 3600*1000;  // every hour
String jobName = "my job";

// make sure group and name match the group and name the job was created with
SimpleTrigger trigger = new SimpleTrigger(jobName, Scheduler.DEFAULT_GROUP, startDate, 
			null, // end never
			SimpleTrigger.REPEAT_INDEFINITELY, runEveryInMilliseconds);
trigger.setJobName(jobName);
trigger.setJobGroup(Scheduler.DEFAULT_GROUP);
sched.rescheduleJob(jobName, Scheduler.DEFAULT_GROUP, trigger);

</pre>




