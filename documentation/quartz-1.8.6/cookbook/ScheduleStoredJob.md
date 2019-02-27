<div class="secNavPanel"><a href=".">Contents</a> | <a href="StoreJob">&lsaquo;&nbsp;Prev</a> | <a href="UpdateJob">Next&nbsp;&rsaquo;</a></div>





# How-To: Scheduling an already stored job

### Scheduling an already stored job

<pre>

// Define a Trigger that will fire "now" and associate it with the existing job
Trigger trigger = new SimpleTrigger("trigger1", "group1", new Date());
trigger.setJobName("jobName");
trigger.setJobGroup("jobGroup");

// Schedule the trigger
sched.scheduleJob(trigger);

</pre>




