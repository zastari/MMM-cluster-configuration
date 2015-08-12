MMM Cluster Configuration Generator
===================================

A small set of templates and a bash script to generate mmm_common.conf, mmm_mon.conf, and mmm_mon_log.conf for multiple clusters effectively. This does not yet generate the init scripts, and /etc/init.d/mysql-mmm-monitor-${cluster} will still need to be configured manually.

Usage
-----

 * Create clusters.txt with your cluster information
 * Update the work_dir in gen_common.sh with your working directory
 * Run gen_common.sh to generate the associated conf files in the working directory

License
-------

BSD

Author Information
------------------

Tyler Mitchell
