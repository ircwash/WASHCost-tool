calculators
===========

Development URL: http://dev.washcost.org

Live URL: http://www.washcost.org

Technologies Used
-----------------

### Database
MongoDB version: 2.2.3

### Front-end Framework
Zurb Foundation version: 4.3.1

### Ruby
Ruby version: 1.9.3

Rails version: 3.2.13

### Debugging
jazz-hands version: 0.5.1

### DRb server for testing frameworks
spork rails version: 3.2.1



Installation
------------

Clone the repo & cd into it. Then

    bundle install

If you don't have Qt installed (capybara gem will let you know, as it
will fail building), you'll need to install it. On OS X:

    brew install qt

Running the tests
-----------------

### run spork

    spork

### run the integration test

    rspec --drb spec/features
