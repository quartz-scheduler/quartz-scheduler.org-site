---
title: What's New
visible_title: "Quartz What's New"
active_sub_menu_id: site_mnu_docs_new_in
---
# What's New In Quartz Scheduler 2.2

We'd like to express thanks to the community contributors that provided ideas and patches for much of the work contained in this release!

## API Changes with 2.2.0 (including some minor backward compatibility breakage)

* <a href="https://jira.terracotta.org/jira/browse/QTZ-292">QTZ-292</a> - Scheduler interface : in the method scheduleJobs , the triggers should be part of a Set instead of a List
* <a href="https://jira.terracotta.org/jira/browse/QTZ-304">QTZ-304</a> - Scheduler#scheduleJobs API change to support generics and avoid cast
* <a href="https://jira.terracotta.org/jira/browse/QTZ-366">QTZ-366</a> - Deleted the long-deprecated CloudscapeDelegate
* <a href="https://jira.terracotta.org/jira/browse/QTZ-212">QTZ-212</a> - Add schedulerStarting() method to SchedulerListener interface
* <a href="https://jira.terracotta.org/jira/browse/QTZ-225">QTZ-225</a> - Make the Scheduler's ClassLoadHelper available to plugins when they are initialized

* For those using JDBC JobStore, there is a schema change that requires the addition of a column to the fired_triggers table, you can add such with a SQL statement such as this (with slight variants on data type needed depending upon your database flavor):
  * for oracle: ALTER TABLE QRTZ_FIRED_TRIGGERS ADD COLUMN SCHED_TIME NUMBER(13) NOT NULL;
  * for postgresql:  ALTER TABLE QRTZ_FIRED_TRIGGERS ADD COLUMN SCHED_TIME BIGINT NOT NULL;
  * for MySql:  ALTER TABLE QRTZ_FIRED_TRIGGERS ADD COLUMN SCHED_TIME BIGINT(13) NOT NULL;
  * etc.


## New Features in 2.2.0

* <a href="https://jira.terracotta.org/jira/browse/QTZ-370">QTZ-370</a> - Ability to override default transaction timeout when beginning new UserTransaction
* <a href="https://jira.terracotta.org/jira/browse/QTZ-323">QTZ-323</a> - Ability to override worker thread names (when using SimpleThreadPool)
* <a href="https://jira.terracotta.org/jira/browse/QTZ-79">QTZ-79</a> - Improvements to the out-of-the-box SendMailJob
* <a href="https://jira.terracotta.org/jira/browse/QTZ-121">QTZ-121</a> - Create an EJB Job invoker that supports EJB3
* <a href="https://jira.terracotta.org/jira/browse/QTZ-267">QTZ-267</a> - Add new Scheduler method: scheduleJob(JobDetail job, Set<Trigger> trigger) to schedule multiple triggers for a job all at once.
* <a href="https://jira.terracotta.org/jira/browse/QTZ-272">QTZ-272</a> - Add initialize() to ConnectionProvider interface
* <a href="https://jira.terracotta.org/jira/browse/QTZ-275">QTZ-275</a> - Allow 'triggerless' initial storing of non-durable jobs.
* <a href="https://jira.terracotta.org/jira/browse/QTZ-315">QTZ-315</a> - Improvements for Job Recovery Information
* <a href="https://jira.terracotta.org/jira/browse/QTZ-154">QTZ-154</a> - OSGi support


## Miscellaneous with 2.2.0

* The Quartz library is now distributed only as two jar files:  one with all Quartz functionality, one with the out-of-the-box jobs (see <a href="https://jira.terracotta.org/jira/browse/QTZ-378">QTZ-378</a>)

* Quartz now requires JDK 1.6 or newer (<a href="https://jira.terracotta.org/jira/browse/QTZ-286">QTZ-286</a>)

* Performance improvements, including:
  * Improvements to some select statements in JDBC JobStore

* Some internal SPI/interface refactorings (cleanups) such as on DriverDelegate and its subclasses, the Semaphore class, etc.

* Various bug fixes, for complete listing see the release notes from Jira: <a href="https://jira.terracotta.org/jira/secure/ReleaseNote.jspa?projectId=10282&version=11041">https://jira.terracotta.org/jira/secure/ReleaseNote.jspa?projectId=10282&version=11041</a>
