<div class="secNavPanel"><a href="./">Contents</a> | <a href="/documentation/quartz-1.8.6/tutorials/TutorialLesson04">&lsaquo;&nbsp;Prev</a> | <a href="/documentation/quartz-1.8.6/tutorials/TutorialLesson06">Next&nbsp;&rsaquo;</a></div>
# Quartz Enterprise Job Scheduler 1.x Tutorial

## Lesson 5: SimpleTrigger


***SimpleTrigger*** should meet your scheduling needs if you need to have a job execute exactly once at
a specific moment in time, or at a specific moment in time followed by repeats at a specific interval. For example,
if you want the trigger to fire at exactly 11:23:54 AM on January 13, 2005, and then fire five more times,
every ten seconds.

With this description, you may not find it surprising to find that the properties of a SimpleTrigger include: a
start-time, and end-time, a repeat count, and a repeat interval. All of these properties are exactly what you'd expect
them to be, with only a couple special notes related to the end-time property.

The repeat count can be zero, a positive integer, or the constant value SimpleTrigger.REPEAT_INDEFINITELY. The
repeat interval property must be zero, or a positive long value, and represents a number of milliseconds. Note that a
repeat interval of zero will cause 'repeat count' firings of the trigger to happen concurrently (or as close to
concurrently as the scheduler can manage).

If you're not already familiar with the java.util.Calendar class, you may find it helpful for computing your
trigger fire-times, depending on the ***startTime*** (or endTime) that you're trying to create. The *org.quartz.helpers.TriggerUtils*
class is also helpful in this respect.

The ***endTime*** property (if it is specified) overrides the repeat count property. This can be useful
if you wish to create a trigger such as one that fires every 10 seconds until a given moment in time - rather than
having to compute the number of times it would repeat between the start-time and the end-time, you can simply specify
the end-time and then use a repeat count of REPEAT_INDEFINITELY (you could even specify a repeat count of some huge
number that is sure to be more than the number of times the trigger will actually fire before the end-time arrives).

SimpleTrigger has a few different constructors, but we'll examine this one, and use it in the few examples that
follow:

**One Of SimpleTrigger's Constructors:**

<pre>
public SimpleTrigger(String name,
                       String group,
                       Date startTime,
                       Date endTime,
                       int repeatCount,
                       long repeatInterval)
</pre>


**SimpleTrigger Example 1 - Create a trigger that fires exactly once, ten seconds from now**

<pre>
long startTime = System.currentTimeMillis() + 10000L;

  SimpleTrigger trigger = new SimpleTrigger("myTrigger",
                                            null,
                                            new Date(startTime),
                                            null,
                                            0,
                                            0L);
</pre>


**SimpleTrigger Example 2 - Create a trigger that fires immediately, then repeats every 60
seconds, forever**


<pre>
SimpleTrigger trigger = new SimpleTrigger("myTrigger",
                                            null,
                                            new Date(),
                                            null,
                                            SimpleTrigger.REPEAT_INDEFINITELY,
                                            60L * 1000L);
</pre>


**SimpleTrigger Example 3 - Create a trigger that fires immediately, then repeats every 10
seconds until 40 seconds from now**

<pre>
long endTime = System.currentTimeMillis() + 40000L;

  SimpleTrigger trigger = new SimpleTrigger("myTrigger",
                                            "myGroup",
                                            new Date(),
                                            new Date(endTime),
                                            SimpleTrigger.REPEAT_INDEFINITELY,
                                            10L * 1000L);
</pre>


**SimpleTrigger Example 4 - Create a trigger that fires on March 17 of the year 2002 at
precisely 10:30 am, and repeats 5 times (for a total of 6 firings) - with a 30 second delay between each firing**


<pre>
java.util.Calendar cal = new java.util.GregorianCalendar(2002, cal.MARCH, 17);
  cal.set(cal.HOUR, 10);
  cal.set(cal.MINUTE, 30);
  cal.set(cal.SECOND, 0);
  cal.set(cal.MILLISECOND, 0);

  Data startTime = cal.getTime()

  SimpleTrigger trigger = new SimpleTrigger("myTrigger",
                                            null,
                                            startTime,
                                            null,
                                            5,
                                            30L * 1000L);
</pre>



Spend some time looking at the other constructors (and property setters) available on SimpleTrigger, so that you
can use the one most convenient to what you want to accomplish.

### SimpleTrigger Misfire Instructions {#TutorialLesson5-SimpleTriggerMisfireInstructions}

SimpleTrigger has several instructions that can be used to inform Quartz what it should do when a misfire occurs.
(Misfire situations were introduced in the More About Triggers section of this tutorial). These instructions are defined
as constants on SimpleTrigger itself (including JavaDoc describing their behavior). The instructions include:

**Misfire Instruction Constants of SimpleTrigger**

<pre>
MISFIRE_INSTRUCTION_FIRE_NOW
MISFIRE_INSTRUCTION_RESCHEDULE_NOW_WITH_EXISTING_REPEAT_COUNT
MISFIRE_INSTRUCTION_RESCHEDULE_NOW_WITH_REMAINING_REPEAT_COUNT
MISFIRE_INSTRUCTION_RESCHEDULE_NEXT_WITH_REMAINING_COUNT
MISFIRE_INSTRUCTION_RESCHEDULE_NEXT_WITH_EXISTING_COUNT
</pre>


You should recall from the earlier lessons that all triggers have the *Trigger.MISFIRE_INSTRUCTION_SMART_POLICY*
instruction available for use, and this instruction is also the default for all trigger types.

If the 'smart policy' instruction is used, SimpleTrigger dynamically chooses between its various MISFIRE
instructions, based on the configuration and state of the given SimpleTrigger instance. The JavaDoc for the
SimpleTrigger.updateAfterMisfire() method explains the exact details of this dynamic behavior.




