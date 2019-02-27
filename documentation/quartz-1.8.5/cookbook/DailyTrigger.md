<div class="secNavPanel"><a href=".">Contents</a> | <a href="NintyMinTrigger">&lsaquo;&nbsp;Prev</a> | <a href="BiDailyTrigger">Next&nbsp;&rsaquo;</a></div>





# How-To: Trigger That Executes Every Day

### Using org.quartz.helpers.TriggerUtils


**Trigger That Executes Every Day at 3:00PM**

<pre>

Trigger trigger = TriggerUtils.makeDailyTrigger(15, 0);
trigger.setName("trigger1");
trigger.setGroup("group1");

</pre>


### Doing it manually

If you would like a Trigger that executes every day at a specified time, use CronTrigger:

**CronTrigger That Executes Every Day at 3:00PM**

<pre>

Trigger trigger = new CronTrigger("trigger1", "group1");
trigger.setCronExpression("0 0 15 * * ?");

</pre>


If you don't care what time it runs (only the period is important), you can use SimpleTrigger (note that startTime will be the time when the trigger was instantiated):

**SimpleTrigger That Executes Every 24 Hours**

<pre>

Trigger trigger = new SimpleTrigger("trigger1", "group1");
// 24 hours * 60(minutes per hour) * 60(seconds per minute) * 1000(milliseconds per second)
trigger.setRepeatInterval(24L * 60L * 60L * 1000L);

</pre>


Technically, if you want the trigger to run at a specific time, you can also use a SimpleTrigger, but it's a bit of work to get the startTime right:

**SimpleTrigger That Executes Every Day at 3:00PM**

<pre>

java.util.Calendar startTime = java.util.Calendar.getInstance();
startTime.set(java.util.Calendar.HOUR_OF_DAY, 15);
startTime.set(java.util.Calendar.MINUTE, 0);
startTime.set(java.util.Calendar.SECOND, 0);
startTime.set(java.util.Calendar.MILLISECOND, 0);

//if the startTime will be before the current time, move to next day
if (startTime.getTime.before(new Date()) {
   startTime.add(java.util.Calendar.DAY_OF_MONTH, 1);
}

Trigger trigger = new SimpleTrigger("trigger1", "group1");
trigger.setRepeatCount(SimpleTrigger.REPEAT_INDEFINITELY);
trigger.setStartTime(startTime.getTime());
// 24 hours * 60(minutes per hour) * 60(seconds per minute) * 1000(milliseconds per second)
trigger.setRepeatInterval(24L * 60L * 60L * 1000L);

</pre>





