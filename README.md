The Coud Connect Ruby Gem
==========================

A Ruby wrapper for the [Cloud Connect API](http://develop.g8teway.com).

Installation
------------
    gem install cloud_connect

Usage
-----

    require 'rubygems'
    require 'cloud_connect'

### Instantiate a client

    cloud_connect = CloudConnect::Client.new(:username => 'user', :password => 'password', :account => 'test', :env => 'sandbox')

### Or configure once

    CloudConnect.configure do |config|
      config.username = 'user'
      config.password = 'password'
      config.account  = 'test'
      config.env      = 'sandbox'
    end
    cloud_connect = CloudConnect.client.new

### Login

    cloud_connect.login

### Examples

    cloud_connect.units
    =>  [<#Hashie::Mash id=2 lat=nil lng=nil time=nil>, <#Hashie::Mash id=3 lat=4884481 lng=226392 time="2009-07-08T10:23:13Z">]

Details for the current user
    cloud_connect.user

Details for another user

    cloud_connect.user('other_user')
    cloud_connect.user(1)

Send a message to a unit

    cloud_connect.send_message(1, 11, "Hello World!")

Get a unit's last known position

    unit = cloud_connect.unit(3)
    puts "#{unit.location.join(', ')} @ #{unit.time}"

We recommand you install the [yajl-ruby](http://github.com/brianmario/yajl-ruby) Gem
for improved performance over the default pure ruby JSON library.

Contributing
------------
In the spirit of [free software](http://www.fsf.org/licensing/essays/free-sw.html), **everyone** is encouraged to help improve this project.

Here are some ways *you* can contribute:

* by using alpha, beta, and prerelease versions
* by reporting bugs
* by suggesting new features
* by writing or editing documentation
* by writing specifications
* by writing code (**no patch is too small**: fix typos, add comments, clean up inconsistent whitespace)
* by refactoring code
* by closing [issues](http://github.com/mobiledevices/cloud_connect/issues)
* by reviewing patches

All contributors will be added to the [HISTORY](https://github.com/mobiledevices/cloud_connect/blob/master/HISTORY.md)
file and will receive the respect and gratitude of the community.

Submitting an Issue
-------------------
We use the [GitHub issue tracker](http://github.com/mobiledevices/cloud_connect/issues) to track bugs and
features. Before submitting a bug report or feature request, check to make sure it hasn't already
been submitted. You can indicate support for an existing issuse by voting it up. When submitting a
bug report, please include a [Gist](http://gist.github.com/) that includes a stack trace and any
details that may be necessary to reproduce the bug, including your gem version, Ruby version, and
operating system. Ideally, a bug report should include a pull request with failing specs.

Submitting a Pull Request
-------------------------
1. Fork the project.
2. Create a topic branch.
3. Implement your feature or bug fix.
4. Add documentation for your feature or bug fix.
5. Run <tt>bundle exec rake doc:yard</tt>. If your changes are not 100% documented, go back to step 4.
6. Add specs for your feature or bug fix.
7. Run <tt>bundle exec rake spec</tt>. If your changes are not 100% covered, go back to step 6.
8. Commit and push your changes.
9. Submit a pull request. Please do not include changes to the gemspec, version, or history file. (If you want to create your own version for some reason, please do so in a separate commit.)
