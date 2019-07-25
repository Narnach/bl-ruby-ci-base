# Base image for CircleCI

For a client I've got some a-typical requirements for CI. CircleCI has Debian images, but I need a MS SQL client, which is only available for Ubuntu.

Long story short, this contains:

- Ubuntu 16.04
- Ruby 2.6.3
- MS SQL Tools
- Node.js
- Other (random-ish) stuff useful for getting a Rails app running

## Build instructions

```bash
# Build the image for local use:
docker build -t narnach/bl-ruby-ci-base:ruby-2.6.3 .

# Push the image (only useful for me, the Docker hub repository owner)
docker push narnach/bl-ruby-ci-base:ruby-2.6.3
```

After step 1, you can locally use the Docker image `bl-ruby-ci-base:ruby-2.6.3`.
Step 2 is what I have performed to get the latest version on Docker hub.

Ruby versions I've created images for in this way:

- Ruby 2.2.2
- Ruby 2.6.3

## Version updates / custom images

* Update `Dockerfile` with the new Ruby version and/or base image version. There are `ENV` vars at the top, and the `FROM` also contains the Ubuntu version, so that is listed twice.
* Update this Readme to refer to the correct versions.
* Commit the changes
* Build and push the image. In case of errors, go back to previous steps until it _does_ work.
