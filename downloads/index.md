---
layout: page
title: Downloads
visible_title: "Download Quartz"
permalink: /downloads/
active_menu_id: site_mnu_download
---

## Direct/Manual Downloads


You can download the full distribution (with examples, source, dependencies, doc, etc.).

Or if you are a Maven user you can add the dependencies to your existing project.

### Latest release

#### Full Distribution

<i class="fa fa-download"></i> [Quartz 2.2.1](http://d2zwv9pap9ylyd.cloudfront.net/quartz-2.2.1-distribution.tar.gz)  .tar.gz


For more information on this release, see the [release notes](https://jira.terracotta.org/jira/secure/ReleaseNote.jspa?version=11610&styleName=Text&projectId=10282).

#### Quartz 2.2.x Maven Snippets

To include Quartz 2.2.x in your project, use:

<pre class="prettyprint highlight"><code class="language-xml" data-lang="xml">  &lt;dependency&gt;
    &lt;groupId&gt;org.quartz-scheduler&lt;/groupId&gt;
    &lt;artifactId&gt;quartz&lt;/artifactId&gt;
    &lt;version&gt;{{ site.qtz_latest_version }}&lt;/version&gt;
  &lt;/dependency&gt;
  &lt;dependency&gt;
    &lt;groupId&gt;org.quartz-scheduler&lt;/groupId&gt;
    &lt;artifactId&gt;quartz-jobs&lt;/artifactId&gt;
    &lt;version&gt;{{ site.qtz_latest_version }}&lt;/version&gt;
  &lt;/dependency&gt;   </code></pre>

_Note: Be sure to substitute the version number above with the version number of Quartz that you want to use._


--

### Previous releases

#### Full Distributions

<i class="fa fa-download"></i> [Quartz 2.1.7](http://d2zwv9pap9ylyd.cloudfront.net/quartz-2.1.7.tar.gz)  .tar.gz

<i class="fa fa-download"></i> [Quartz 2.0.2](http://d2zwv9pap9ylyd.cloudfront.net/quartz-2.0.2.tar.gz)  .tar.gz

<i class="fa fa-download"></i> [Quartz 1.8.6](http://d2zwv9pap9ylyd.cloudfront.net/quartz-1.8.6.tar.gz)  .tar.gz


A full [change log](https://jira.terracotta.org/jira/browse/QTZ/?selectedTab=com.atlassian.jira.jira-projects-plugin:changelog-panel) is available..

#### Pre-2.2.0 Maven Snippets

To include older Quartz versions in your project, use:

<pre class="prettyprint highlight"><code class="language-xml" data-lang="xml">  &lt;dependency&gt;
    &lt;groupId&gt;org.quartz-scheduler&lt;/groupId&gt;
    &lt;artifactId&gt;quartz&lt;/artifactId&gt;
    &lt;version&gt;2.1.7&lt;/version&gt;
  &lt;/dependency&gt;
  &lt;dependency&gt;
    &lt;groupId&gt;org.quartz-scheduler&lt;/groupId&gt;
    &lt;artifactId&gt;quartz-oracle&lt;/artifactId&gt;
    &lt;version&gt;2.1.7&lt;/version&gt;
  &lt;/dependency&gt;
  &lt;dependency&gt;
    &lt;groupId&gt;org.quartz-scheduler&lt;/groupId&gt;
    &lt;artifactId&gt;quartz-weblogic&lt;/artifactId&gt;
    &lt;version&gt;2.1.7&lt;/version&gt;
  &lt;/dependency&gt;
  &lt;dependency&gt;
    &lt;groupId&gt;org.quartz-scheduler&lt;/groupId&gt;
    &lt;artifactId&gt;quartz-jboss&lt;/artifactId&gt;
    &lt;version&gt;2.1.7&lt;/version&gt;
  &lt;/dependency&gt;   </code></pre>

_Note: Be sure to substitute the version number above with the version number of Quartz that you want to use._
