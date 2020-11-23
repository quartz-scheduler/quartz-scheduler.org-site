<div class="secNavPanel"><a href="./">Contents</a> | <a href="/documentation/quartz-1.8.6/tutorials/TutorialLesson03">&lsaquo;&nbsp;Prev</a> | <a href="/documentation/quartz-1.8.6/tutorials/TutorialLesson05">Next&nbsp;&rsaquo;</a></div>
# Quartz Enterprise Job Scheduler 1.x Tutorial

## Lesson 4: More About Triggers

Like jobs, triggers are relatively easy to work with, but do contain a variety of customizable options that you
need to be aware of and understand before you can make full use of Quartz. Also, as noted earlier, there are different
types of triggers, that you can select to meet different scheduling needs.

You will learn about the two most common types of triggers in <a href="/documentation/quartz-1.8.6/tutorials/TutorialLesson05"
    title="Tutorial Lesson 5">Lesson 5: Simple Triggers</a> and <a href="/documentation/quartz-1.8.6/tutorials/TutorialLesson06"
    title="Tutorial Lesson 6">Lesson 6: Cron Triggers</a>.

### Calendars {#TutorialLesson4-Calendars}

Quartz ***Calendar*** objects (not java.util.Calendar objects) can be associated with triggers at the
time the trigger is stored in the scheduler. Calendars are useful for excluding blocks of time from the the trigger's
firing schedule. For instance, you could create a trigger that fires a job every weekday at 9:30 am, but then add a
Calendar that excludes all of the business's holidays.

Calendar's can be any serializable objects that implement the Calendar interface, which looks like this:

**The Calendar Interface**

<pre>
package org.quartz;

public interface Calendar {

  public boolean isTimeIncluded(long timeStamp);

  public long getNextIncludedTime(long timeStamp);

}
</pre>


Notice that the parameters to these methods are of the long type. As you may guess, they are timestamps in
millisecond format. This means that calendars can 'block out' sections of time as narrow as a millisecond. Most likely,
you'll be interested in 'blocking-out' entire days. As a convenience, Quartz includes the class
org.quartz.impl.HolidayCalendar, which does just that.

Calendars must be instantiated and registered with the scheduler via the addCalendar(..) method. If you use
HolidayCalendar, after instantiating it, you should use its addExcludedDate(Date date) method in order to populate it
with the days you wish to have excluded from scheduling. The same calendar instance can be used with multiple triggers
such as this:

**An Example of using calendars**

<pre>
HolidayCalendar cal = new HolidayCalendar();
cal.addExcludedDate( someDate );

sched.addCalendar("myHolidays", cal, false);

Trigger trigger = TriggerUtils.makeHourlyTrigger(); // fire every one hour interval
trigger.setStartTime(TriggerUtils.getEvenHourDate(new Date()));  // start on the next even hour
trigger.setName("myTrigger1");

trigger.setCalendarName("myHolidays");

// .. schedule job with trigger

Trigger trigger2 = TriggerUtils.makeDailyTrigger(8, 0); // fire every day at 08:00
trigger.setStartTime(new Date()); // begin immediately
trigger2.setName("myTrigger2");

trigger2.setCalendarName("myHolidays");

// .. schedule job with trigger2
</pre>


The details of the values passed in the SimpleTrigger constructors will be explained in the next section. For
now, just believe that the code above creates two triggers: one that will repeat every 60 seconds forever, and one that
will repeat five times with a five day interval between firings. However, any of the firings that would have occurred
during the period excluded by the calendar will be skipped.

### Priority (v1.6)

Sometimes, when you have many Triggers (or few worker threads in your Quartz thread pool), Quartz may not have
enough resources to immediately fire all of the Triggers that are scheduled to fire at the same time.&nbsp; In this
case, you may want to control which of your Triggers get first crack at the available Quartz worker threads.&nbsp; For
this purpose, you can set the *priority* property on a Trigger.&nbsp; If N Triggers are to fire at the same time,
but there are only Z worker threads currently available, then the first Z Triggers with the *highest* priority
will get first dibs.&nbsp; If you do not set a priority on a Trigger, then it will use the default priority of 5.&nbsp;
Any integer value is allowed for priority, positive or negative.

**Note:** When a Trigger is detected to require recovery, its recovery is scheduled with the same priority as
the original Trigger.

**An Example of using trigger priorities**

<pre>
// All three Triggers will be scheduled to fire 5 minutes from now.
Calendar cal = Calendar.getInstance();
cal.add(Calendar.MINUTE, 5);

Trigger trig1 = new SimpleTrigger("T1", "MyGroup", cal.getTime());
Trigger trig2 = new SimpleTrigger("T2", "MyGroup", cal.getTime());
Trigger trig3 = new SimpleTrigger("T3", "MyGroup", cal.getTime());

JobDetail jobDetail = new JobDetail("MyJob", "MyGroup", NoOpJob.class);

// Trigger1 does not have its priority set, so it defaults to 5
sched.scheduleJob(jobDetail, trig1);

// Trigger2 has its priority set to 10
trig2.setJobName(jobDetail.getName());
trig2.setPriority(10);
sched.scheduleJob(trig2);

// Trigger2 has its priority set to 1
trig3.setJobName(jobDetail.getName());
trig2.setPriority(1);
sched.scheduleJob(trig3);

// Five minutes from now, when the scheduler invokes these three triggers
// they will be allocated worker threads in decreasing order of their
// priority: Trigger2(10), Trigger1(5), Trigger3(1)
</pre>


### Misfire Instructions {#TutorialLesson4-MisfireInstructions}

Another important property of a Trigger is its "misfire instruction". A misfire occurs if a persistent trigger
"misses" its firing time because of the scheduler being shutdown, or because there are no available threads in Quartz's
thread pool for executing the job. The different trigger types have different misfire instructions available to them. By
default they use a 'smart policy' instruction - which has dynamic behavior based on trigger type and configuration. When
the scheduler starts, it searches for any persistent triggers that have misfired, and it then updates each of them based
on their individually configured misfire instructions. When you start using Quartz in your own projects, you should make
yourself familiar with the misfire instructions that are defined on the given trigger types, and explained in their
JavaDoc. More specific information about misfire instructions will be given within the tutorial lessons specific to each
trigger type. The misfire instruction for a given trigger instance can be configured using the *setMisfireInstruction(..)*
method.

### TriggerUtils - Triggers Made Easy {#TutorialLesson4-TriggerUtilsTriggersMadeEasy}

The TriggerUtils class (in the org.quartz package) contains conveniences to help you create triggers and dates
without having to monkey around with java.util.Calendar objects. Use this class to easily make triggers that fire every
minute, hour, day, week, month, etc. Also use this class to generate dates that are rounded to the nearest second,
minute or hour - this can be very useful for setting trigger start-times.

### TriggerListeners {#TutorialLesson4-TriggerListeners}

Finally, triggers may have registered listeners, just as jobs may. Objects implementing the ***TriggerListener***
interface will receive notifications as a trigger is fired.




