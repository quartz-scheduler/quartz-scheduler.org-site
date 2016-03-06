<div class="secNavPanel"><a href=".">Contents</a> | <a href="MonthlyTrigger">&lsaquo;&nbsp;Prev</a> | <a href="DailyCalendarTrigger">Next&nbsp;&rsaquo;</a></div>





# How-To: Trigger that Executes on the Fifth "Working Day" of Every Month

For this example, assume that a "working day" is defined as any weekday that is not a business holiday.

The first thing we must do is define a calendar that excludes days which are not working days. For example:


<pre>

HolidayCalendar workdayCalendar = new HolidayCalendar(wCal);

//Create a holiday for New Year's Day (observed) and add it to the
//  calendar.
java.util.Calendar holidayCalendar = 
	java.util.Calendar.getInstance();
holidayCalendar.set(2006, java.util.Calendar.JANUARY, 2);
workdayCalendar.addExcludedDate(holidayCalendar.getTime());

//continue adding working holidays ...

sched.addCalendar("workingDayCalendar", wCal, false, false);

</pre>


We then need to create the trigger:


<pre>

// Define a Trigger (fires on the fifth working day of every month at 5:00 PM)

NthIncludedDayTrigger testTrigger = 
	new NthIncludedDayTrigger("testTrigger", "TEST");
testTrigger.setJobName("TestJob");
testTrigger.setJobGroup("TEST");
testTrigger.setCalendarName("workingDayCalendar");
testTrigger.setN(5);
testTrigger.setFireAtTime("17:00");
		
sched.scheduleJob(testTrigger);

</pre>


If the current month was January, 2006, this trigger would fire at 5:00 PM on January 9, 2006, the fifth day not excluded by the associated calendar.



