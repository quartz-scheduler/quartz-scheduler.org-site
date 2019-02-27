<div class="secNavPanel"><a href=".">Contents</a> | <a href="TenSecTrigger">&lsaquo;&nbsp;Prev</a> | <a href="DailyTrigger">Next&nbsp;&rsaquo;</a></div>





# How-To: Trigger That Executes Every 90 minutes

### Using org.quartz.helpers.TriggerUtils


<pre>

/* 
 * Note that this will create a trigger that starts immediately.
 * To control the start time, use trigger.setStartTime(Date)
 */
Trigger trigger = TriggerUtils.makeMinutelyTrigger(90);
trigger.setName("trigger1");
trigger.setGroup("group1");

</pre>


### Doing it manually


<pre>

/* 
 * Note that this will create a trigger that starts immediately.
 * To control the start time, use trigger.setStartTime(Date)
 */
Trigger trigger = new SimpleTrigger("trigger1", "group1");
trigger.setRepeatCount(SimpleTrigger.REPEAT_INDEFINITELY);
trigger.setRepeatInterval(90L * 60L * 1000L); // minutes * 60(seconds per minute) * 1000(milliseconds per second)

</pre>


OR -


<pre>

/* 
 * Note that this will create a trigger that starts immediately.
 * To control the start time, use trigger.setStartTime(Date)
 */
DateIntervalTrigger trigger = new DateIntervalTrigger("trigger1", "group1", DateIntervalTrigger.IntervalUnit.MINUTE, 90);

</pre>




