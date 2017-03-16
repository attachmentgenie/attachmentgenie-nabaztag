#THIS MODULE IS NO LONGER MAINTAINED

attachmentgenie-nabaztag
==============

Description
-----------

A Puppet report handler for creating Nabaztag messages from failed runs.

Requirements
------------

* `puppet`
* `nabaztag`

Installation & Usage
-------------------

1.  Install the `nabaztag` gem on your Puppet master

        $ sudo gem install nabaztag

2.  Install attachmentgenie-nabaztag as a module in your Puppet master's module
    path.

3.  Update the `nabaztag_serial`, `nabaztag_token` variables in the
    `nabaztag.yaml` file. Copy the file to `/etc/puppet/`. An example file
    is included.

4.  Enable pluginsync and reports on your master and clients in `puppet.conf`

        [master]
        report = true
        reports = nabaztag
        pluginsync = true
        [agent]
        report = true
        pluginsync = true

5.  Run the Puppet client and sync the report as a plugin
