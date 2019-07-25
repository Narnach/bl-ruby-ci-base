# Base image for CircleCI

For a client I've got some a-typical requirements for CI. CircleCI has Debian images, but I need a MS SQL client, which is only available for Ubuntu.
Long story short: this contains Ruby, MS SQL, Node.js and some other stuff required to run our test suite.

Ruby is old because the codebase is old. First you make it work, then you test the hell out of it, then you upgrade it :-D 

## Build instructions

```bash
# Build the image
docker build -t narnach/bl-ruby-ci-base:ruby-2.6.3 .

# Push the image
docker push narnach/bl-ruby-ci-base:ruby-2.6.3
```

## Version updates

* Update `Dockerfile` with the new Ruby version and/or base image version.
* Update this Readme to refer to the correct versions.
* Commit the changes
* Build and push the image. In case of errors, go back to previous steps until it _does_ work.
