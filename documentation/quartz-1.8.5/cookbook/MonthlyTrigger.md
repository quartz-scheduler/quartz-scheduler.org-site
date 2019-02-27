<div class="secNavPanel"><a href=".">Contents</a> | <a href="BiWeeklyTrigger">&lsaquo;&nbsp;Prev</a> | <a href="FifthWorkingDayTrigger">Next&nbsp;&rsaquo;</a></div>





# How-To: Trigger That Executes Every Month

(note all examples fire at 5:00 AM.)

### Using org.quartz.helpers.TriggerUtils


<pre>

// Trigger That Executes On the 15th of Every Month

Trigger trigger = TriggerUtils.makeMonthlyTrigger(15, 5, 0);
trigger.setName("trigger1");
trigger.setGroup("group1");

</pre>


### Doing it manually

Unlike many of the other examples in the cookbook, this one cannot be implemented with SimpleTrigger, because there is not an even interval of time between each month. Our only option is CronTrigger, but what we can do with CronTrigger is fairly rich:

<pre>

//CronTrigger That Executes On the First Day of Every Month

CronTrigger trigger = new CronTrigger("trigger1", "group1");
trigger.setCronExpression("0 0 5 1 * ?");

</pre>



<pre>
// CronTrigger That Executes On the 15th of Every Month

CronTrigger trigger = new CronTrigger("trigger1", "group1");
trigger.setCronExpression("0 0 5 15 * ?");

</pre>



<pre>
// CronTrigger That Executes On the Last Day of Every Month

CronTrigger trigger = new CronTrigger("trigger1", "group1");
trigger.setCronExpression("0 0 5 L * ?");

</pre>



<pre>
// CronTrigger That Executes On the First Weekday of Every Month

CronTrigger trigger = new CronTrigger("trigger1", "group1");
trigger.setCronExpression("0 0 5 1W * ?");

</pre>



<pre>
// CronTrigger That Executes On the Last Weekday of Every Month

CronTrigger trigger = new CronTrigger("trigger1", "group1");
trigger.setCronExpression("0 0 5 LW * ?");

</pre>


There are other possible combinations as well, which are more fully covered in the API documentation. All of these options were made by simply changing the day-of-month field. Imagine what you can do if you leverage the other fields as well!



