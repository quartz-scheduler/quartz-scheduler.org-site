<div class="secNavPanel"><a href=".">Contents</a> | <a href="ConfigListeners">&lsaquo;&nbsp;Prev</a> | <a href="ConfigRMI">Next&nbsp;&rsaquo;</a></div>





# Quartz Enterprise Job Scheduler 1.x Configuration Reference

## Configure Scheduler Plugins


Like listeners configuring plugins through the configuration file consists of giving then a name, and then specifying the class name, and any other properties to be set on the instance. The class must have a no-arg constructor, and the properties are set reflectively. Only primitive data type values (including Strings) are supported.

Thus, the general pattern for defining a plug-in is:

**Configuring a Plugin**

<pre>
org.quartz.plugin.NAME.class = com.foo.MyPluginClass
org.quartz.plugin.NAME.propName = propValue
org.quartz.plugin.NAME.prop2Name = prop2Value
</pre>







There are several Plugins that come with Quartz, that can be found in the *org.quartz.plugins* package (and subpackages).  Example of configuring a few of them are as follows:

### Sample configuration of Logging Trigger History Plugin {#ConfigPlugins-SampleconfigurationofLoggingTriggerHistoryPlugin}

The logging trigger history plugin catches trigger events (it is also a trigger listener) and logs then with Jakarta Commons-Logging.  See the class's JavaDoc for a list of all the possible parameters.

**Sample configuration of Logging Trigger History Plugin**

<pre>
org.quartz.plugin.triggHistory.class = \
  org.quartz.plugins.history.LoggingTriggerHistoryPlugin
org.quartz.plugin.triggHistory.triggerFiredMessage = \
  Trigger \{1\}.\{0\} fired job \{6\}.\{5\} at: \{4, date, HH:mm:ss MM/dd/yyyy}
org.quartz.plugin.triggHistory.triggerCompleteMessage = \
  Trigger \{1\}.\{0\} completed firing job \{6\}.\{5\} at \{4, date, HH:mm:ss MM/dd/yyyy\}.
</pre>





### Sample configuration of XML Scheduling Data Processor Plugin {#ConfigPlugins-SampleconfigurationofJobInitializationPlugin}

Job initialization plugin reads a set of jobs and triggers from an XML file, and adds them to the scheduler during initialization.  It can also delete exiting data.  See the class's JavaDoc for more details.

**Sample configuration of JobInitializationPlugin**

<pre class="code-java">org.quartz.plugin.jobInitializer.class = \
  org.quartz.plugins.xml.XMLSchedulingDataProcessorPlugin
org.quartz.plugin.jobInitializer.fileNames = \
  data/my_job_data.xml
org.quartz.plugin.jobInitializer.failOnFileNotFound = <span class="code-keyword">true</span>
</pre>


The XML schema definition for the file can be found here:

<a href="http://www.quartz-scheduler.org/xml/job_scheduling_data_1_8.xsd">http://www.quartz-scheduler.org/xml/job_scheduling_data_1_8.xsd&nbsp;&rsaquo;</a>


### Sample configuration of Shutdown Hook Plugin {#ConfigPlugins-SampleconfigurationofShutdownHookPlugin}

The shutdown-hook plugin catches the event of the JVM terminating, and calls shutdown on the scheduler.

**Sample configuration of ShutdownHookPlugin**

<pre>
org.quartz.plugin.shutdownhook.class = \
  org.quartz.plugins.management.ShutdownHookPlugin
org.quartz.plugin.shutdownhook.cleanShutdown = <span class="code-keyword">true</span>
</pre>





