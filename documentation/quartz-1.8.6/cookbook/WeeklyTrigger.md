<div class="secNavPanel"><a href=".">Contents</a> | <a href="BiDailyTrigger">&lsaquo;&nbsp;Prev</a> | <a href="BiWeeklyTrigger">Next&nbsp;&rsaquo;</a></div>





# How-To: Trigger That Executes Every Week

### Using org.quartz.helpers.TriggerUtils


<pre>

// Trigger That Executes Every Wednesday at 3:00PM

Trigger trigger = TriggerUtils.MakeWeeklyTrigger(TriggerUtils.WEDNESDAY, 15, 0);
trigger.setName("trigger1");
trigger.setGroup("group1");

</pre>


### Doing it manually

If you would like a Trigger that executes every week on a specified day of the week at a specified time, use CronTrigger:

<pre>

// CronTrigger That Executes Every Wednesday at 3:00PM
Trigger trigger = new CronTrigger("trigger1", "group1");
trigger.setCronExpression("0 0 15 ? * WED");

</pre>


If you don't care what time it runs (only the period is important), you can use SimpleTrigger (note that startTime will be the time when the trigger was instantiated):

<pre>

// SimpleTrigger That Executes Every 7 Days

Trigger trigger = new SimpleTrigger("trigger1", "group1");
// 7(days per week) * 24(hours per day) * 60(minutes per hour) * 60(seconds per minute) * 1000(milliseconds per second)
trigger.setRepeatInterval(7L * 24L * 60L * 60L * 1000L);

</pre>


Technically, if you want to specify the time the trigger will fire, you can use a SimpleTrigger, but it's a lot of work to get the startTime right:

<pre>

// SimpleTrigger That Executes Every Wednesday at 3:00PM

java.util.Calendar startTime = java.util.Calendar.getInstance();
startTime.set(java.util.Calendar.HOUR_OF_DAY, 15);
startTime.set(java.util.Calendar.MINUTE, 0);
startTime.set(java.util.Calendar.SECOND, 0);
startTime.set(java.util.Calendar.MILLISECOND, 0);
startTime.set(java.util.Calendar.DAY_OF_WEEK, java.util.Calendar.WEDNESDAY);

//if the startTime will be before the current time, move to next week
if (startTime.getTime.before(new Date()) {
   startTime.add(java.util.Calendar.DAY_OF_MONTH, 7);
}

Trigger trigger = new SimpleTrigger("trigger1", "group1");
trigger.setRepeatCount(SimpleTrigger.REPEAT_INDEFINITELY);
trigger.setStartTime(startTime.getTime());
//7(days per week) * 24(hours per day) * 60(minutes per hour) * 60(seconds per minute) * 1000(milliseconds per second)
trigger.setRepeatInterval(7L * 24L * 60L * 60L * 1000L);

</pre>


You may also simply use a DateIntervalTrigger to 


<pre>

/* 
 * Note that this will create a trigger that starts immediately.
 * To control the start time, use trigger.setStartTime(Date)
 */
DateIntervalTrigger trigger = new DateIntervalTrigger("trigger1", "group1", DateIntervalTrigger.IntervalUnit.WEEK, 1);

</pre>



