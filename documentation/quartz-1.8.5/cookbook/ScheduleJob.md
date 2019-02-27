<div class="secNavPanel"><a href=".">Contents</a> | <a href="DefineJobWithData">&lsaquo;&nbsp;Prev</a> | <a href="UnscheduleJob">Next&nbsp;&rsaquo;</a></div>





# How-To: Scheduling a Job

### Scheduling a Job

<pre>

// Define job instance
JobDetail job = new JobDetail("job1", "group1", MyJobClass.class);
	
// Define a Trigger that will fire "now"
Trigger trigger = new SimpleTrigger("trigger1", "group1", new Date());
	
// Schedule the job with the trigger
sched.scheduleJob(job, trigger);

</pre>




