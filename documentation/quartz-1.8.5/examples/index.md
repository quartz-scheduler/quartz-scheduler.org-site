# Examples Overview

Welcome to the documentation for the Quartz 1.x Example programs.   As of version 1.5, Quartz ships with 13 out-of-the-box examples that demonstrate the various features of Quartz and the Quartz API.


## Where to Find the Examples {#ExamplesOverview-WheretoFindtheExamples}

All of the examples listed on here are part of the Quartz distribution.

To download Quartz, visit <a href="/downloads">http://www.quartz-scheduler.org/download</a> and select the latest Quartz distribution.

The quartz examples are listed under the **examples** directory under the main Quartz directory.  Under the **examples** directory, you will find an example sub-directory for each example, labeled **example1**, **example2**, **example3** etc...

Every example contains a UNIX/Linux shell scripts for executing the examples as well at Windows batch files.   Additionally, every example has a readme.txt file.  Please consult this file before running the examples.

The source code for the examples are located in package **org.quartz.examples**.   Every example has its own sub-package, **org.quartz.examples.example1**, **org.quartz.examples.example2**, etc...


## The Examples {#ExamplesOverview-TheExamples}

<table><thead>
<tr>
<th> Example </th>
<th> Title </th>
<th> Description </th>
</tr>
</thead>

<tr>
<td width="75"> <a href="/documentation/quartz-1.x/examples/Example1" title="Example1">Example 1</a> </td>
<td> First Quartz Program </td>

<td> Think of this as a "Hello World" for Quartz </td>
</tr>
<tr>
<td> Example 2 </td>
<td> Simple Triggers </td>
<td> Shows a dozen different ways of using Simple Triggers to schedule your jobs </td>
</tr>
<tr>
<td> <a href="/documentation/quartz-1.x/examples/Example3" title="Example3">Example 3</a> </td>

<td> Cron Triggers </td>
<td> Shows how Cron Triggers can be used to schedule your job </td>
</tr>
<tr>
<td> <a href="/documentation/quartz-1.x/examples/Example4" title="Example4">Example 4</a> </td>
<td> Job State and Parameters </td>
<td> Demonstrates how parameters can be passed into jobs and how jobs maintain state </td>

</tr>
<tr>
<td> <a href="/documentation/quartz-1.x/examples/Example5" title="Example5">Example 5</a> </td>
<td> Handling Job Misfires </td>
<td> Sometimes job will not execute when they are supposed to.  See how to handle these Misfires </td>
</tr>
<tr>
<td> <a href="/documentation/quartz-1.x/examples/Example6" title="Example6">Example 6</a> </td>

<td> Dealing with Job Exceptions </td>
<td> No job is perfect.  See how you can let the scheduler know how to deal with exceptions that are thrown by your job </td>
</tr>
<tr>
<td> Example 7 </td>
<td> Interrupting Jobs </td>
<td> Shows how the scheduler can interrupt your jobs and how to code your jobs to deal with interruptions </td>

</tr>
<tr>
<td> Example 8 </td>
<td> Fun with Calendars </td>
<td> Demonstrates how a Holiday calendar can be used to exclude execution of jobs on a holiday </td>
</tr>
<tr>
<td> Example 9 </td>
<td> Job Listeners </td>

<td> Use job listeners to have one job trigger another job, building a simple workflow </td>
</tr>
<tr>
<td> Example 10 </td>
<td> Using Quartz Plug-Ins </td>
<td> Demonstrates the use of the XML Job Initialization plug-in as well as the History Logging plug-ins </td>
</tr>
<tr>
<td> Example 11 </td>

<td> Quartz Under High Load </td>
<td> Quartz can run a lot of jobs but see how thread pools can limit how many jobs can execute simultaneously </td>
</tr>
<tr>
<td> Example 12 </td>
<td> Remote Job Scheduling using RMI </td>
<td> Using Remote Method Invocation, a Quartz scheduler can be remotely scheduled by a client </td>

</tr>
<tr>
<td> Example 13 </td>
<td> Clustered Quartz </td>
<td> Demonstrates how Quartz can be used in a clustered environment and how Quartz can use the database to persist scheduling information </td>
</tr>
<tr>
<td> <a href="/documentation/quartz-1.x/examples/Example14" title="Example14">Example 14</a> </td>

<td> Trigger Priorities </td>
<td> Demonstrates how Trigger priorities can be used to manage firing order for Triggers with the same fire time </td>
</tr>
</tbody></table>




