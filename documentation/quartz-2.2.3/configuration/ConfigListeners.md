---
title: Configuration Reference
visible_title: "Quartz Configuration Reference"
active_sub_menu_id: site_mnu_docs_configuration
---
<div class="secNavPanel">
          <a href="index.html">Contents</a> |
          <a href="ConfigThreadPool.html">&lsaquo;&nbsp;ConfigThreadPool</a> |
	  <a href="ConfigPlugins.html">ConfigPlugins&nbsp;&rsaquo;</a>
</div>

# Configuration Reference

## Configure Global Listeners

Global listeners can be instantiated and configured by StdSchedulerFactory, or your application can do it itself
at runtime, and then register the listeners with the scheduler. "Global" listeners listen to the events of every
job/trigger rather than just the jobs/triggers that directly reference them.

Configuring listeners through the configuration file consists of giving then a name, and then specifying the
class name, and any other properties to be set on the instance. The class must have a no-arg constructor, and the
properties are set reflectively. Only primitive data type values (including Strings) are supported.


Thus, the general pattern for defining a "global" TriggerListener is:

**Configuring a Global TriggerListener**

<pre>
org.quartz.triggerListener.NAME.class = com.foo.MyListenerClass
org.quartz.triggerListener.NAME.propName = propValue
org.quartz.triggerListener.NAME.prop2Name = prop2Value
</pre>


And the general pattern for defining a "global" JobListener is:

**Configuring a Global JobListener**

<pre>
org.quartz.jobListener.NAME.class = com.foo.MyListenerClass
org.quartz.jobListener.NAME.propName = propValue
org.quartz.jobListener.NAME.prop2Name = prop2Value
</pre>
