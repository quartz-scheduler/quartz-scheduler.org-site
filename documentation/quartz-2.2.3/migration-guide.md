---
title: Migration Guide
visible_title: "Quartz 1.8 to 2.2 Migration Guide"
active_sub_menu_id: site_mnu_migration_guide
---

# Quartz 1.8.x to Quartz 2.2 Migration Guide

<center>*If you find errors, or encounter difficulties that you wish had been covered by this document, please help the
entire community by notifying the Quartz team of the needed improvements by posting a message in the forums.*</center>

This document outlines how to migrate an application using Quartz Scheduler 1.8.x to version 2.0 - it does not
document every change or new feature in version 2.0.  For information related to what has changed with Quartz 2.0
please refer to the <a href="new-in-quartz-2">What's New In Quartz Scheduler 2.0</a> document, or refer to the
<a href="https://jira.terracotta.org/jira/secure/ReleaseNote.jspa?projectId=10282&version=10842">2.0 change list</a> in
the project's Jira issue tracker.

Depending upon the particular Quartz features made use of by your existing Quartz 1.x application, there are
various migration issues that you may or may not need address.  Hence, this document attempts to organize the migration
instructions by major feature sets / configuration types.


## Making Changes Required For All Quartz Setups

The Quartz Scheduler API was significantly overhauled with the 2.0 release.  Effort was made to balance making real
improvements with the desire to have minimal effort to migrate existing applications to usage of version 2.0.  Not every
change is explicitly covered below - but those that aren't should be very easy to figure out on your own using your
IDE's code-completion offerings, or a quick look at the 2.0 JavaDoc.

### Quartz Configuration (properties files)

This is the really easy part: No changes are required, existing properties files should work just fine.

### Scheduler API

As you proceed toward making your code build again, remember to refer to JavaDoc for full reference of the API.

#### Typed Collections

 API methods that return (or take as parameters) arrays now return (or take) typed collections.  For example, rather
than *getJobGroupNames(): String[]* we now have *getJobGroupNames(): List&lt;String&gt;*.   After updating your
project code's dependency to be upon the Quartz 2.0 library, the compiler will find and indicate errors at all of your
usages of arrays rather than Lists, Sets, etc.  Many applications will have very few occurrences to fix, while others
with have many dozens - depending upon the nature of the application and its usages of the Quartz API.

Example old code:

<pre>
String[] triggerGroups = sched.getTriggerGroupNames();
</pre>

New code:

<pre>
List&lt;String&gt; triggerGroups = sched.getTriggerGroupNames();
</pre>


#### Job and Trigger Identification (Keys)

Jobs and Triggers are now identified by keys, *JobKey* and *TriggerKey* respectively.  Keys are composed
of two *String* properties: name and group.  As such, methods that once took name and group as two parameters,
now take a key as a single parameter.   Your IDE's compiler will identify all occurrences that need to be fixed.  Note
that JobKey and TriggerKey have static methods on them for easily creating keys, consider using static imports to make
your code cleaner (to avoid code that looks like this:  *new TriggerKey("name", "group"))*.  In some cases the new
usage of keys will make your code a tiny bit longer, but in other cases it greatly simplifies things (e.g. passing/receiving
one argument rather than two).  Also note that group does not need to be specified (just leave the parameter off) when
creating a key if you are not making usage of groups.

Much of this can be done with search-and-replace.

Example old code:

<pre>
String[] triggersInGroup = sched.getTriggerNames("myGroup");
Trigger trg = sched.getTrigger("myTriggerName", "myGroup");
sched.unscheduleJob("myOtherTriggerName", null);
trg.getName();
trg.getJobName();
JobDetail myJob = sched.getJobDetail("myJobName", "myGroup");
</pre>


New code:

<pre>
import static org.quartz.TriggerKey.*;
import static org.quartz.JobKey.*;
...
List&lt;TriggerKey&gt; triggersInGroup = sched.getTriggerKeys("myGroup");
Trigger trg = sched.getTrigger(triggerKey("myTriggerName", "myGroup"));
sched.unscheduleJob(triggerKey("myOtherTriggerName"));
trg.getKey().getName();
trg.getJobKey().getName();
JobDetail myJob = sched.getJobDetail(jobKey("myJobName", "myGroup"));
</pre>


#### Constructing Jobs and Triggers &nbsp; (the new, preferred way - see next section for easier migration)

A new builder-based API provides a Domain Specific Language (DSL) for constructing job and trigger definitions.
Usage of static imports makes your code nice and clean when using the new DSL.  Aside from being a less cumbersome API,
the new builders have provided a means for removing/hiding many methods that were once on various classes (such as
Trigger) that were not meant to be called by the client code.

Please take note of related new classes (that you should use static imports from):  *TriggerBuilder, JobBuilder,
SimpleScheduleBuilder, CronScheduleBuilder, CalendarIntervalSchedulerBuilder, DateBuilder*.

Example old code:

<pre>
JobDetail job = new JobDetail("myJob", "myGroup");
job.setJobClass(MyJobClass.class);
job.setDurability(true);
job.setRequestsRecovery(true);
job.getJobDataMap().put("someKey", "someValue");

SimpleTrigger trg = new SimpleTrigger("myTrigger", null);
trg.setStartTime(new Date(System.currentTimeMillis() + 10000L));
trg.setPriority(6);
trg.setJobName("myJob");
trg.setJobGroup("myGroup");
trg.setRepeatCount(SimpleTrigger.REPEAT_INDEFINITELY);
trg.setRepeatInterval(30000L);
</pre>


New code:

<pre>
import static org.quartz.TriggerBuilder.*;
import static org.quartz.JobBuilder.*;
import static org.quartz.DateBuilder.*;
import static org.quartz.SimpleScheduleBuilder.*;
...
JobDetail job = newJob(MyJobClass.class)
    .withIdentity("myJob", "myGroup")
    .storeDurably()
    .requestRecovery()
    .usingJobData("someKey", "someValue")
    .build();

Trigger trg = newTrigger()
    .withIdentity("myTrigger")
    .startAt(futureDate(10, IntervalUnit.SECONDS))
    .withPriority(6)
    .forJob(job)
    .withSchedule(simpleSchedule()
        .withIntervalInSeconds(30)
        .repeatForever())
    .build();
</pre>


#### Constructing Jobs and Triggers &nbsp; (the easy but not recommended way - see above for preferred)

If you want to get going quicker, without re-writing code to use the new builder/DSL API, you can make some quick
changes to existing code to make the compiler happy.   Trigger and JobDetail are now interfaces, but implementations
still exists that you can "sneakily" reference.  Note that this is only recommended as a temporary way to get your
code working quickly, and you should plan on eventually converting your code to use the new API.

Rather than importing and using *org.quartz.SimpleTrigger*, *org.quartz.CronTrigger*, and
*org.quartz.JobDetail* change your code to import and use *org.quartz.impl.triggers.SimpleTriggerImpl*,
*org.quartz.impl.triggers.CronTriggerImpl*, and *org.quartz.impl.JobDetailImpl*.  (A similar name
substitution pattern can be used for other concrete trigger types).

This can be accomplished with search-and-replace.

Example old code:

<pre>
JobDetail job = new JobDetail("myJob", "myGroup");
...
SimpleTrigger trg = new SimpleTrigger("myTrigger", null);
</pre>


New code:

<pre>
JobDetailImpl job = new JobDetailImpl("myJob", "myGroup");
...
SimpleTriggerImpl trg = new SimpleTriggerImpl("myTrigger", null);
</pre>


#### Changes Relating To Trigger Comparison

Trigger's compareTo() method now correctly relates to its equals() method, in that it compares the trigger's key,
rather than next fire time.  A new Comparator that sorts triggers according to fire time, priority and key was added as
Trigger.TriggerTimeComparator.


This will not affect most Quartz 1.x users, but may, if your own code attempts to sort triggers by placing them
in a sortable collection (e.g. TreeSet), or uses Collections.sort(..) with them.  Please be aware of the change,
and make appropriate adjustment to your code as needed.

### Changes Related To Listeners (JobListener, TriggerListener, SchedulerListener)

Significant changes were made to the way listeners are registered with the scheduler.  There is no longer a
distinction between "global" and "non-global" listeners.  Jobs and Triggers are no longer configured with a list of
names of non-global listeners that should be notified of events related to them.  Instead all listeners are registered
with one or more *Matcher* rules that select which jobs/triggers the listener will be notified of events for.

Additionally, all methods related to the management of listeners were removed from the Scheduler interface and were
placed on a new *ListenerManager* interface.

Most Quartz-using applications do not make use of listeners, but if yours does, you'll have some work to do to make
the compiler happy.

See the new *org.quartz.impl.matchers* package for the complete set of available *Matcher* implementations.

Example old code:

<pre>
scheduler.addGlobalJobListener(myGlobalJobListener);
scheduler.addJobListener(myJobListener);
...
job.addJobListener(myJobListener.getName());
...
</pre>


New code:

<pre>
import static org.quartz.impl.matchers.GroupMatcher.*;
...
// no matcher == match all jobs
scheduler.getListenerManager().addJobListener(myGlobalJobListener);
// match (listen to) all jobs in given group
scheduler.getListenerManager().addJobListener(myJobListener, jobGroupEquals("foo"));
...
</pre>


### Changes Related To TriggerUtils

Methods on *TriggerUtils* related to construction of *Date* instances have been moved to *DateBuilder*
and can be made easy use of via static imports.  Dates can then easily and cleanly be constructed and used in-line with
the new trigger builder DSL.

Methods on *TriggerUtils* related to construction of *Trigger* instances have been moved to
*SimpleScheduleBuilder* and *CronScheduleBuilder* (and other ScheduleBuilder implementations) and can be
made easy use of via static imports.

Example old code:

<pre>
Date startDate = TriggerUtils.getEvenHourDate(new Date()); // next hour, straight up
Trigger t = TriggerUtils.makeDailyTrigger(10,45); // every day at 10:45
t.setStartTime(startDate);
</pre>


New code:

<pre>
import static org.quartz.DateBuilder.*;
import static org.quartz.TriggerBuilder.*;
import static org.quartz.CronScheduleBuilder.*;
...
Trigger t = newTrigger()
    .withSchedule(cronScheduleDaily(10,45)) // every day at 10:45
    .startAt(evenHourDate(new Date()) / next hour, straight up
    .build();
</pre>


### Changes Related To DateIntervalTrigger

*DateIntervalTrigger*, which was introduced late in the 1.x code line was renamed to
*CalendarIntervalTrigger*.   This change is rather significant for those who were using *DateIntervalTrigger*
with JDBC-JobStore, as a class of that name no longer exists, yet the database will contain serialized instances of
it!

To help with this problem a "backward compatibility" JAR (*quartz-backward-compat-2.0.0.jar*) is shipped with
Quartz 2.0, which contains a new version of the missing class that has been updated to be compatible with Quartz 2.0,
yet has the same name and serialVersionUID as the old class. Make sure to put this JAR in your classpath if you have
stored instances of *DateIntervalTrigger*!

It is recommended that you change all code that references/uses *DateIntervalTrigger* to use the new
*CalendarIntervalTrigger*, which will not store to the database in BLOB (serialized) form.

### Changes Related To NthIncludedDayTrigger

*NthIncludedDayTrigger* (a rarely used and issue-fraught Trigger implementation) was removed from Quartz 2.0
code base.   This change is rather significant for those who were using *NthIncludedDayTrigger*
with JDBC-JobStore, as a class of that name no longer exists, yet the database will contain serialized instances of
it!

To help with this problem a "backward compatibility" JAR (*quartz-backward-compat-2.0.0.jar*) is shipped with
Quartz 2.0, which contains a new version of the missing class that has been updated to be compatible with Quartz 2.0,
yet has the same name and serialVersionUID as the old class. Make sure to put this JAR in your classpath if you have
stored instances of *NthIncludedDayTrigger*!

If you were using NthIncludedDayTrigger, it is recommended that you find alternative ways to schedule your jobs
(using other Triggers).

## Making Changes For Setups Using JDBCJobStore

### Database Schema Changes

If you use JDBCJobStore, you will need to make several changes to the database to transform it to the new expected schema.

Exact syntax will vary between databases, but most should work with the following commands or small variations (the
table creation script for each database (found in the Quartz distribution's "docs/dbTables" directory) can also serve
as reference.


<pre>
--
- drop tables that are no longer used
-
drop table qrtz_job_listeners;
drop table qrtz_trigger_listeners;
-
- drop columns that are no longer used
-
alter table qrtz_job_details drop column is_volatile;
alter table qrtz_triggers drop column is_volatile;
alter table qrtz_fired_triggers drop column is_volatile;
-
- add new columns that replace the 'is_stateful' column
-
alter table qrtz_job_details add column is_nonconcurrent bool;
alter table qrtz_job_details add column is_update_data bool;
update qrtz_job_details set is_nonconcurrent = is_stateful;
update qrtz_job_details set is_update_data = is_stateful;
alter table qrtz_job_details drop column is_stateful;
alter table qrtz_fired_triggers add column is_nonconcurrent bool;
update qrtz_fired_triggers set is_nonconcurrent = is_stateful;
alter table qrtz_fired_triggers drop column is_stateful;
-
- add new 'sched_name' column to all tables --- replace "TestScheduler" with your scheduler's configured name
-
alter table qrtz_blob_triggers add column sched_name varchar(120) not null DEFAULT 'TestScheduler';
alter table qrtz_calendars add column sched_name varchar(120) not null DEFAULT 'TestScheduler';
alter table qrtz_cron_triggers add column sched_name varchar(120) not null DEFAULT 'TestScheduler';
alter table qrtz_fired_triggers add column sched_name varchar(120) not null DEFAULT 'TestScheduler';
alter table qrtz_job_details add column sched_name varchar(120) not null DEFAULT 'TestScheduler';
alter table qrtz_locks add column sched_name varchar(120) not null DEFAULT 'TestScheduler';
alter table qrtz_paused_trigger_grps add column sched_name varchar(120) not null DEFAULT 'TestScheduler';
alter table qrtz_scheduler_state add column sched_name varchar(120) not null DEFAULT 'TestScheduler';
alter table qrtz_simple_triggers add column sched_name varchar(120) not null DEFAULT 'TestScheduler';
alter table qrtz_triggers add column sched_name varchar(120) not null DEFAULT 'TestScheduler';
-
- add new 'sched_time' column to qrtz_fired_triggers
-
alter table qrtz_fired_triggers add column sched_time BIGINT(13) NOT NULL;
-
- drop all primary and foreign key constraints, so that we can define new ones
-
alter table qrtz_triggers drop constraint qrtz_triggers_job_name_fkey;
alter table qrtz_blob_triggers drop constraint qrtz_blob_triggers_pkey;
alter table qrtz_blob_triggers drop constraint qrtz_blob_triggers_trigger_name_fkey;
alter table qrtz_simple_triggers drop constraint qrtz_simple_triggers_pkey;
alter table qrtz_simple_triggers drop constraint qrtz_simple_triggers_trigger_name_fkey;
alter table qrtz_cron_triggers drop constraint qrtz_cron_triggers_pkey;
alter table qrtz_cron_triggers drop constraint qrtz_cron_triggers_trigger_name_fkey;
alter table qrtz_job_details drop constraint qrtz_job_details_pkey;
alter table qrtz_job_details add primary key (sched_name, job_name, job_group);
alter table qrtz_triggers drop constraint qrtz_triggers_pkey;
-
- add all primary and foreign key constraints, based on new columns
-
alter table qrtz_triggers add primary key (sched_name, trigger_name, trigger_group);
alter table qrtz_triggers add foreign key (sched_name, job_name, job_group) references qrtz_job_details(sched_name, job_name, job_group);
alter table qrtz_blob_triggers add primary key (sched_name, trigger_name, trigger_group);
alter table qrtz_blob_triggers add foreign key (sched_name, trigger_name, trigger_group) references qrtz_triggers(sched_name, trigger_name, trigger_group);
alter table qrtz_cron_triggers add primary key (sched_name, trigger_name, trigger_group);
alter table qrtz_cron_triggers add foreign key (sched_name, trigger_name, trigger_group) references qrtz_triggers(sched_name, trigger_name, trigger_group);
alter table qrtz_simple_triggers add primary key (sched_name, trigger_name, trigger_group);
alter table qrtz_simple_triggers add foreign key (sched_name, trigger_name, trigger_group) references qrtz_triggers(sched_name, trigger_name, trigger_group);
alter table qrtz_fired_triggers drop constraint qrtz_fired_triggers_pkey;
alter table qrtz_fired_triggers add primary key (sched_name, entry_id);
alter table qrtz_calendars drop constraint qrtz_calendars_pkey;
alter table qrtz_calendars add primary key (sched_name, calendar_name);
alter table qrtz_locks drop constraint qrtz_locks_pkey;
alter table qrtz_locks add primary key (sched_name, lock_name);
alter table qrtz_paused_trigger_grps drop constraint qrtz_paused_trigger_grps_pkey;
alter table qrtz_paused_trigger_grps add primary key (sched_name, trigger_group);
alter table qrtz_scheduler_state drop constraint qrtz_scheduler_state_pkey;
alter table qrtz_scheduler_state add primary key (sched_name, instance_name);
-
- add new simprop_triggers table
-
CREATE TABLE qrtz_simprop_triggers
 (          
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    STR_PROP_1 VARCHAR(512) NULL,
    STR_PROP_2 VARCHAR(512) NULL,
    STR_PROP_3 VARCHAR(512) NULL,
    INT_PROP_1 INT NULL,
    INT_PROP_2 INT NULL,
    LONG_PROP_1 BIGINT NULL,
    LONG_PROP_2 BIGINT NULL,
    DEC_PROP_1 NUMERIC(13,4) NULL,
    DEC_PROP_2 NUMERIC(13,4) NULL,
    BOOL_PROP_1 BOOL NULL,
    BOOL_PROP_2 BOOL NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
    REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);
-
- create indexes for faster queries
-
create index idx_qrtz_j_req_recovery on qrtz_job_details(SCHED_NAME,REQUESTS_RECOVERY);
create index idx_qrtz_j_grp on qrtz_job_details(SCHED_NAME,JOB_GROUP);
create index idx_qrtz_t_j on qrtz_triggers(SCHED_NAME,JOB_NAME,JOB_GROUP);
create index idx_qrtz_t_jg on qrtz_triggers(SCHED_NAME,JOB_GROUP);
create index idx_qrtz_t_c on qrtz_triggers(SCHED_NAME,CALENDAR_NAME);
create index idx_qrtz_t_g on qrtz_triggers(SCHED_NAME,TRIGGER_GROUP);
create index idx_qrtz_t_state on qrtz_triggers(SCHED_NAME,TRIGGER_STATE);
create index idx_qrtz_t_n_state on qrtz_triggers(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP,TRIGGER_STATE);
create index idx_qrtz_t_n_g_state on qrtz_triggers(SCHED_NAME,TRIGGER_GROUP,TRIGGER_STATE);
create index idx_qrtz_t_next_fire_time on qrtz_triggers(SCHED_NAME,NEXT_FIRE_TIME);
create index idx_qrtz_t_nft_st on qrtz_triggers(SCHED_NAME,TRIGGER_STATE,NEXT_FIRE_TIME);
create index idx_qrtz_t_nft_misfire on qrtz_triggers(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME);
create index idx_qrtz_t_nft_st_misfire on qrtz_triggers(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_STATE);
create index idx_qrtz_t_nft_st_misfire_grp on qrtz_triggers(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_GROUP,TRIGGER_STATE);
create index idx_qrtz_ft_trig_inst_name on qrtz_fired_triggers(SCHED_NAME,INSTANCE_NAME);
create index idx_qrtz_ft_inst_job_req_rcvry on qrtz_fired_triggers(SCHED_NAME,INSTANCE_NAME,REQUESTS_RECOVERY);
create index idx_qrtz_ft_j_g on qrtz_fired_triggers(SCHED_NAME,JOB_NAME,JOB_GROUP);
create index idx_qrtz_ft_jg on qrtz_fired_triggers(SCHED_NAME,JOB_GROUP);
create index idx_qrtz_ft_t_g on qrtz_fired_triggers(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP);
create index idx_qrtz_ft_tg on qrtz_fired_triggers(SCHED_NAME,TRIGGER_GROUP);
</pre>
