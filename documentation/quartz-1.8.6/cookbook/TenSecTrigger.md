<div class="secNavPanel"><a href=".">Contents</a> | <a href="JobTriggers">&lsaquo;&nbsp;Prev</a> | <a href="NintyMinTrigger">Next&nbsp;&rsaquo;</a></div>





# How-To: Trigger That Executes Every Ten Seconds

### Using org.quartz.helpers.TriggerUtils


<pre>

/*
 * Note that this will create a trigger that starts immediately.
 * To control the start time, use trigger.setStartTime(Date)
 */
Trigger trigger = TriggerUtils.makeSecondlyTrigger(10);
trigger.setName("trigger1");
trigger.setGroup("group1");

</pre>


### Doing it manually


<pre>

/*
 * Note that this will create a trigger that starts immediately.
 * To control the start time, use trigger.setStartTime(Date)
 */
SimpleTrigger trigger = new SimpleTrigger("trigger1", "group1");
trigger.setRepeatCount(SimpleTrigger.REPEAT_INDEFINITELY);
trigger.setRepeatInterval(10000L); // milliseconds

</pre>




