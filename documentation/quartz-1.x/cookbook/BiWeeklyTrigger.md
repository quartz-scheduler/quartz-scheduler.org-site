<div class="secNavPanel"><a href=".">Contents</a> | <a href="WeeklyTrigger">&lsaquo;&nbsp;Prev</a> | <a href="MonthlyTrigger">Next&nbsp;&rsaquo;</a></div>





# How-To: Trigger That Executes Every 2 Weeks

As with a trigger meant to fire every two days, CronTrigger won't work for this schedule. For more details, see <a href="BiDailyTrigger">Trigger That Fires Every 2 Days</a>. We'll need to use a SimpleTrigger or DateIntervalTrigger:


<pre>

/* 
 * Note that this will create a trigger that starts immediately.
 * To control the start time, use trigger.setStartTime(Date)
 */
SimpleTrigger trigger = new SimpleTrigger("trigger1", "group1");
trigger.setRepeatCount(SimpleTrigger.REPEAT_INDEFINITELY);
// 7(days per week) * 24(hours per day) * 60(minutes per hour) * 60(seconds per minute) * 1000(milliseconds per second)
trigger.setRepeatInterval(2L * 7L * 24L * 60L * 60L * 1000L);

</pre>


OR -


<pre>

/* 
 * Note that this will create a trigger that starts immediately.
 * To control the start time, use trigger.setStartTime(Date)
 */
DateIntervalTrigger trigger = new DateIntervalTrigger("trigger1", "group1", DateIntervalTrigger.IntervalUnit.WEEK, 2);

</pre>





