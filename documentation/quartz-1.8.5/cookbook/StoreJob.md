<div class="secNavPanel"><a href=".">Contents</a> | <a href="UnscheduleJob">&lsaquo;&nbsp;Prev</a> | <a href="ScheduleStoredJob">Next&nbsp;&rsaquo;</a></div>





# How-To: Storing a Job for Later Use

### Storing a Job

<pre>

// Define job instance
JobDetail job = new JobDetail("job1", "group1", MyJobClass.class);
	
// Add the the job to the scheduler's store
sched.addJob(job, false);

</pre>




