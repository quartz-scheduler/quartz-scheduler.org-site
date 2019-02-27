<div class="secNavPanel"><a href=".">Contents</a> | <a href="ConfigRMI">&lsaquo;&nbsp;Prev</a> | <a href="ConfigJobStoreTX">Next&nbsp;&rsaquo;</a></div>





# Quartz Enterprise Job Scheduler 1.x Configuration Reference

## Configure RAMJobStore


RAMJobStore is used to store scheduling information (job, triggers and calendars) within memory.  RAMJobStore is fast and lightweight, but all scheduling information is lost when the process terminates.  




RAMJobStore is selected by setting the 'org.quartz.jobStore.class' property as such:

**Setting The Scheduler's JobStore to RAMJobStore**

<pre>
org.quartz.jobStore.class = org.quartz.simpl.RAMJobStore
</pre>





RAMJobStore can be tuned with the following properties:


<table><thead>
<tr>
<th>Property Name</th>
<th>Required</th>
<th>Type</th>
<th>Default Value</th>
</tr>
</thead>
<tbody>
<tr>
<td>org.quartz.jobStore.misfireThreshold</td>

<td>no</td>
<td>int</td>
<td>60000</td>
</tr>
</tbody></table>


**org.quartz.jobStore.misfireThreshold**

The the number of milliseconds the scheduler will 'tolerate' a trigger to pass its next-fire-time by, before being considered "misfired".  The default value (if you don't make an entry of this property in your configuration) is 60000 (60 seconds).




