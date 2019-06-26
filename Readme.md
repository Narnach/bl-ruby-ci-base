# Base image for CircleCI

For a client I've got some a-typical requirements for CI. CircleCI has Debian images, but I need a MS SQL client, which is only available for Ubuntu.
Long story short: this contains Ruby, MS SQL, Node.js and some other stuff required to run our test suite.

Ruby is old because the codebase is old. First you make it work, then you test the hell out of it, then you upgrade it :-D 