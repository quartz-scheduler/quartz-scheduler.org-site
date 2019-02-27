<div class="secNavPanel"><a href=".">Contents</a> | <a href="ConfigPlugins">&lsaquo;&nbsp;Prev</a> | <a href="ConfigRAMJobStore">Next&nbsp;&rsaquo;</a></div>





# Quartz Enterprise Job Scheduler 1.x Configuration Reference

## Configure Scheduler RMI Settings

None of the primary properties are required, and all have 'reasonable' defaults. When using Quartz via RMI, you
need to start an instance of Quartz with it configured to "export" its services via RMI. You then create clients to the
server by configuring a Quartz scheduler to "proxy" its work to the server. 

<blockquote>
Some users experience problems with class availability (namely Job classes) between the client and server. To work
through these problems you'll need an understanding of RMI's "codebase" and RMI security managers. You may find these
resources to be useful:

An excellent description of RMI and codebase: <a href="http://www.kedwards.com/jini/codebase.html">http://www.kedwards.com/jini/codebase.html</a> . One of the important points
is to realize that "codebase" is used by the client!

Quick info about security managers: <a
    href="http://gethelp.devx.com/techtips/java_pro/10MinuteSolutions/10min0500.asp">http://gethelp.devx.com/techtips/java_pro/10MinuteSolutions/10min0500.asp</a>

And finally from the java API docs, read the docs for the RMISecurityManager

<a href="http://java.sun.com/j2se/1.4.2/docs/api/java/rmi/RMISecurityManager.html">http://java.sun.com/j2se/1.4.2/docs/api/java/rmi/RMISecurityManager.html</a>
</blockquote>




<table>
    <thead>
        <tr>
            <th>Property Name</th>
            <th>Required</th>

            <th>Default Value</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>org.quartz.scheduler.rmi.export</td>
            <td>no</td>
            <td>false</td>
        </tr>
        <tr>
            <td>org.quartz.scheduler.rmi.registryHost</td>
            <td>no</td>
            <td>'localhost'</td>

        </tr>
        <tr>
            <td>org.quartz.scheduler.rmi.registryPort</td>
            <td>no</td>
            <td>1099</td>
        </tr>
        <tr>
            <td>org.quartz.scheduler.rmi.createRegistry</td>
            <td>no</td>
            <td>'never'</td>
        </tr>

        <tr>
            <td>org.quartz.scheduler.rmi.serverPort</td>
            <td>no</td>
            <td>random</td>
        </tr>
        <tr>
            <td>org.quartz.scheduler.rmi.proxy</td>
            <td>no</td>
            <td>false</td>
        </tr>
    </tbody>
</table>

**org.quartz.scheduler.rmi.export**

If you want the Quartz Scheduler to export itself via RMI as a server then set the 'rmi.export' flag to true.

**org.quartz.scheduler.rmi.registryHost**

The host at which the RMI Registry can be found (often 'localhost').

**org.quartz.scheduler.rmi.registryPort**

The port on which the RMI Registry is listening (usually 1099).

**org.quartz.scheduler.rmi.createRegistry**


Set the 'rmi.createRegistry' flag according to how you want Quartz to cause the creation of an RMI Registry. Use "false"
or "never" if you don't want Quartz to create a registry (e.g. if you already have an external registry running). Use
"true" or "as_needed" if you want Quartz to first attempt to use an existing registry, and then fall back to creating
one. Use "always" if you want Quartz to attempt creating a Registry, and then fall back to using an existing one. If a
registry is created, it will be bound to port number in the given 'org.quartz.scheduler.rmi.registryPort' property, and
'org.quartz.rmi.registryHost' should be "localhost".

**org.quartz.scheduler.rmi.serverPort**

The port on which the the Quartz Scheduler service will bind and listen for connections. By default, the RMI service
will 'randomly' select a port as the scheduler is bound to the RMI Registry.


**org.quartz.scheduler.rmi.proxy**

If you want to connect to (use) a remotely served scheduler, then set the 'org.quartz.scheduler.rmi.proxy' flag to true.
You must also then specify a host and port for the RMI Registry process - which is typically 'localhost' port 1099.

<blockquote>
It does not make sense to specify a 'true' value for both 'org.quartz.scheduler.rmi.export' and
'org.quartz.scheduler.rmi.proxy' in the same config file - if you do, the 'export' option will be ignored. A value of
'false' for both 'export' and 'proxy' properties is of course valid, if you're not using Quartz via RMI.
</blockquote>





