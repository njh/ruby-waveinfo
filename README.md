[![Build Status](https://travis-ci.org/njh/ruby-waveinfo.svg)](https://travis-ci.org/njh/ruby-waveinfo)

waveinfo
========

waveinfo is a pure-ruby gem to get the information from the headers of Wave (.wav) files.


Installing
----------

You may get the latest stable version from Rubyforge. Source gems are also available.

    $ gem install waveinfo


Synopsis
--------

    require 'rubygems'
    require 'waveinfo'
    
    wave = WaveInfo.new('example.wav')
    puts "Channels: #{wave.channels}"
    puts "Sample Rate: #{wave.sample_rate} Hz"
    puts "Duration: #{wave.duration} secs"



Resources
---------

* GitHub Project: http://github.com/njh/ruby-waveinfo
* Documentation: http://rdoc.info/gems/waveinfo


License
-------

The waveinfo ruby gem is licensed under the terms of the MIT license.
See the file LICENSE for details.


Contact
-------

* Author:    Nicholas J Humfrey
* Email:     njh@aelius.com
* Home Page: http://www.aelius.com/njh/

