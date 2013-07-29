appledev
========

A Dashing widget that shows the Apple Developer System Status.

![Screenshot](screenshot.png?raw=true)

## Installation

Install the gem

    $ echo "gem 'nokogiri'" >> $dashing_dir/Gemfile
    $ cd $dashing_dir ; bundle install

Copy the appledev files

    $ mkdir $dashing_dir/widgets/appledev
    $ cp appledev.rb $dashing_dir/jobs
    $ cp appledev.coffee $dashing_dir/widgets/appledev
    $ cp appledev.html $dashing_dir/widgets/appledev
    $ cp appledev.scss $dashing_dir/widgets/appledev
     
Modify the dashboard file to include the widget

    <li data-row="1" data-col="1" data-sizex="1" data-sizey="2">
        <div data-id="appledev" data-view="Appledev" data-title="Apple Developer"></div>
    </li>
