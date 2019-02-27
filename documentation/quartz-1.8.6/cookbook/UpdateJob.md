<div class="secNavPanel"><a href=".">Contents</a> | <a href="ScheduleStoredJob">&lsaquo;&nbsp;Prev</a> | <a href="UpdateTrigger">Next&nbsp;&rsaquo;</a></div>





# How-To: Update an existing job

### Update an existing job

<pre>

// Add the new job to the scheduler, instructing it to "replace"
//  the existing job with the given name and group (if any)
scheduler.addJob((new JobDetail("job1", "group1", NewJobClass.class), true);

</pre>




