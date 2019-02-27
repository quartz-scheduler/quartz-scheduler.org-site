<div class="secNavPanel"><a href=".">Contents</a> | <a href="ScheduleJob">&lsaquo;&nbsp;Prev</a> | <a href="StoreJob">Next&nbsp;&rsaquo;</a></div>





# How-To: Unscheduling a Job

### Unscheduling a Particular Trigger of Job

<pre>

// Schedule the job with the trigger
scheduler.unscheduleJob(triggerName, triggerGroup);

</pre>


### Deleting a Job and Unscheduling All of Its Triggers

<pre>

// Schedule the job with the trigger
scheduler.deleteJob(jobName, jobGroup);

</pre>




