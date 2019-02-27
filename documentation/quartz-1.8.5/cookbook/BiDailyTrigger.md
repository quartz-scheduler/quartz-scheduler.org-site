<div class="secNavPanel"><a href=".">Contents</a> | <a href="DailyTrigger">&lsaquo;&nbsp;Prev</a> | <a href="WeeklyTrigger">Next&nbsp;&rsaquo;</a></div>





# How-To: Trigger That Executes Every 2 Days

At first glance, you may be tempted to use a CronTrigger. However, if this is truly to be every two days, CronTrigger won't work. To illustrate this, simply think of how many days are in a typical month (28-31). A cron expression like "0 0 5 2/2 * ?" would give us a trigger that would restart its count at the beginning of every month. This means that we would would get subsequent firings on July 30 and August 2, which is an interval of three days, not two.

Likewise, an expression like "0 0 5 1/2 * ?" would end up firing on July 31 and August 1, just one day apart.

Therefore, for this schedule, using SimpleTrigger or DateIntervalTrigger makes sense:


<pre>

/* 
 * Note that this will create a trigger that starts immediately.
 * To control the start time, use trigger.setStartTime(Date)
 */
SimpleTrigger trigger = new SimpleTrigger("trigger1", "group1");
trigger.setRepeatCount(SimpleTrigger.REPEAT_INDEFINITELY);
// 24 hours * 60(minutes per hour) * 60(seconds per minute) * 1000(milliseconds per second)
trigger.setRepeatInterval(2L * 24L * 60L * 60L * 1000L);

</pre>


OR -


<pre>

/* 
 * Note that this will create a trigger that starts immediately.
 * To control the start time, use trigger.setStartTime(Date)
 */
DateIntervalTrigger trigger = new DateIntervalTrigger("trigger1", "group1", DateIntervalTrigger.IntervalUnit.DAY, 2);

</pre>




