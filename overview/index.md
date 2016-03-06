---
layout: about_page
title: Overview
visible_title: "Quartz Enterprise Job Scheduler"
permalink: /overview/
active_sub_menu_id: site_mnu_about_about
---

{% include about_intro.html %}

## What Can Quartz Do For You?

If your application has tasks that need to occur at given moments in time, or if your system has recurring maintenance jobs then Quartz may be your ideal solution.

Sample uses of job scheduling with Quartz:

* Driving Process Workflow: As a new order is initially placed, schedule a Job to fire in exactly 2 hours, that will check the status of that order, and trigger a warning notification if an order confirmation message has not yet been received for the order, as well as changing the order's status to 'awaiting intervention'.
* System Maintenance: Schedule a job to dump the contents of a database into an XML file every business day (all weekdays except holidays) at 11:30 PM.
* Providing reminder services within an application.

Please refer to our listing of [features](http://quartz-scheduler.org/overview/features) for more information.


## Learn More About Quartz:

* [Features of Quartz Job Scheduler](features.html)
* [Quick Start Guide](quick-start.html)
* [License and Copyright](license.html)
* [Full Documentation](/documentation)
