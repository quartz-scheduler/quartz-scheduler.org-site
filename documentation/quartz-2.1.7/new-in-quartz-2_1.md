---
title: What's New
visible_title: "Quartz What's New"
active_sub_menu_id: site_mnu_docs_new_in
---

# What's New In Quartz Scheduler 2.1


We'd like to express thanks to the community contributors that performed a significant amount of the work contained in this release!

## API Changes

* <a href="https://jira.terracotta.org/jira/browse/QTZ-197">QTZ-197</a> - JobDataMap has had improvements made to its interface w/respect to generics
* <a href="https://jira.terracotta.org/jira/browse/QTZ-184">QTZ-184</a> - GroupMatcher API changes to avoid generics compiler warnings

## New Features

* <a href="https://jira.terracotta.org/jira/browse/QTZ-196">QTZ-196</a> - New trigger type 'DailyTimeIntervalTrigger'
* <a href="https://jira.terracotta.org/jira/browse/QTZ-186">QTZ-186</a> - Improvements for interrupting executing jobs


## Miscellaneous

* Performance improvements, including:
  * *Now Implemented In JDBC-JobStore*: Ability to batch-acquire triggers that are ready to be fired, which can provide performance improvements for very busy schedulers (TerracottaJobStore and RAMJobStore got this feature with Quartz 2.0).  NOTE: If "org.quartz.scheduler.batchTriggerAcquisitionMaxCount" is set to > 1, and JDBC JobStore is used, then "org.quartz.jobStore.acquireTriggersWithinLock" must be set to "true" to avoid data corruption.

* PropertySettingJobFactory is now the default JobFactory.    
* Various bug fixes, for complete listing see the release notes from Jira: <a href="https://jira.terracotta.org/jira/secure/ReleaseNote.jspa?projectId=10282&version=10981">https://jira.terracotta.org/jira/secure/ReleaseNote.jspa?projectId=10282&version=10981</a>
