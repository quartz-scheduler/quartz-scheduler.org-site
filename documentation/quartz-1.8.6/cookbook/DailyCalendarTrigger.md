<div class="secNavPanel"><a href=".">Contents</a> | <a href="FifthWorkingDayTrigger">&lsaquo;&nbsp;Prev</a> </div>





# How-To: Trigger That Fires Every 5 Minutes Between 8:15 AM and 5:30 PM (every day)

It is tempting to try and represent this schedule using only a CronTrigger. However, the closest we could come with a CronTrigger is every 5 minutes between 8:00 AM and 6:00 PM every day. Why? Because Each field in a cron expression is independent of the other fields, so setting using the n/m syntax for minute (i.e. "0 15/5 8-5 * * ?") would result in the trigger firing every five minutes starting with the 15th minute every hour: 8:15, 8:20, ... , 8:50, 8:55, 9:15, 9:20...

Another thought is a SimpleTrigger, since we can use startTime and endTime to limit fire times (this also true with CronTrigger). But since startTime and endTime are Date objects, for this to work, we would have to reschedule the SimpleTrigger every day.

So our only real option here is to use a Calendar to build our schedule. We start by building a trigger that is close to what we want. In this case, since we want fire times to be based on a preset time (rather than when the trigger was scheduled), it will probably be easier to use CronTrigger. However, SimpleTrigger would be an effective candidate here as well.


<pre>

// Define the Trigger (fires on the fifth working day of every month at 5:00 PM)

CronTrigger testTrigger = new CronTrigger("testTrigger", "TEST", "0 0/5 * * * ?"); //every five minutes
testTrigger.setJobName("TestJob");
testTrigger.setJobGroup("TEST")

</pre>


Then we create a Calendar to limit out the times we don't want.


<pre>

// Define the Calendar

DailyCalendar dailyCal = new DailyCalendar("dailyCalendar", "8:15", "17:30");

//This creates a calendar which excludes the time range we want.
// We need to the calendar to exclude all but the time range we've defined.
// By inverting the time range, we tell the calendar to exclude all times that
// do not fall in the specified time range:
dailyCal.setInvertTimeRange(true);

//add the calendar to the scheduler
sched.addCalendar("dailyCalendar", dailyCal, true, true);

//associate the calendar with the trigger
testTrigger.setCalendarName("dailyCalendar");

//schedule the trigger
sched.scheduleJob(testTrigger);

</pre>


Note we could have used the expression "0 0/5 8-5 * * ?" which would have created slightly less work for the scheduler, but it would have made the example less clear, so the optimization was left out.



