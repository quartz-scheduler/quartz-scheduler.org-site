<div class="secNavPanel"><a href=".">Contents</a> | <a href="ShutdownScheduler">&lsaquo;&nbsp;Prev</a> | <a href="MultipleSchedulers">Next&nbsp;&rsaquo;</a></div>






# How-To: Initializing a scheduler within a servlet container

There are two approaches for this...

### Adding A Context/Container Listener To web.xml

<pre>

...
     &lt;context-param&gt;
         &lt;param-name&gt;quartz:config-file&lt;/param-name&gt;
         &lt;param-value&gt;/some/path/my_quartz.properties&lt;/param-value&gt;
     &lt;/context-param&gt;
     &lt;context-param&gt;
         &lt;param-name&gt;quartz:shutdown-on-unload&lt;/param-name&gt;
         &lt;param-value&gt;true&lt;/param-value&gt;
     &lt;/context-param&gt;
     &lt;context-param&gt;
         &lt;param-name&gt;quartz:wait-on-shutdown&lt;/param-name&gt;
         &lt;param-value&gt;false&lt;/param-value&gt;
     &lt;/context-param&gt;
     &lt;context-param&gt;
         &lt;param-name&gt;quartz:start-scheduler-on-load&lt;/param-name&gt;
         &lt;param-value&gt;true&lt;/param-value&gt;
     &lt;/context-param&gt;
...
     &lt;listener&gt;
         &lt;listener-class&gt;
             org.quartz.ee.servlet.QuartzInitializerListener
         &lt;/listener-class&gt;
     &lt;/listener&gt;
...

</pre>


### Adding A Start-up Servlet To web.xml

<pre>

...
	&lt;servlet&gt; 
	  &lt;servlet-name&gt;QuartzInitializer&lt;/servlet-name&gt; 
	  &lt;servlet-class&gt;org.quartz.ee.servlet.QuartzInitializerServlet&lt;/servlet-class&gt; 
	  &lt;init-param&gt;

	    &lt;param-name&gt;shutdown-on-unload&lt;/param-name&gt;
	    &lt;param-value&gt;<span class="code-keyword">true</span>&lt;/param-value&gt;
	  &lt;/init-param&gt;
	  &lt;load-on-startup&gt;2&lt;/load-on-startup&gt;

	&lt;/servlet&gt;
...

</pre>




