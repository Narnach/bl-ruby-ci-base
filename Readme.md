# Base image for CircleCI

> I've stopped using this myself, so this project is archived to reflect this. As with all my open source code, it's licensed under MIT so feel free to use this however you want.

For a client I've got some a-typical requirements for CI. CircleCI has Debian images, but I need a MS SQL client, which is only available for Ubuntu.

Long story short, this contains:

- Ubuntu 16.04
- Ruby 2.6.5
- MS SQL Tools
- Node.js
- Other (random-ish) stuff useful for getting a Rails app running

## Using this

The images built from this repository are available on [Docker hub](https://hub.docker.com/r/narnach/bl-ruby-ci-base). You can download the latest version via:

```bash
docker pull narnach/bl-ruby-ci-base
```

## Build instructions

```bash
# Build the image for local use, tagging it with the Ruby version and the "latest" tag.
docker build -t narnach/bl-ruby-ci-base:latest -t narnach/bl-ruby-ci-base:ruby-2.6.5 .

# Push the image (only useful for me, the Docker hub repository owner)
docker push narnach/bl-ruby-ci-base:ruby-2.6.5
docker push narnach/bl-ruby-ci-base:latest 
```

After step 1, you can locally use the Docker image `bl-ruby-ci-base:ruby-2.6.5`.
Step 2 is what I have performed to get the latest version on Docker hub.

Ruby versions I've created images for in this way:

- Ruby 2.2.2
- Ruby 2.6.3
- Ruby 2.6.5

## Version updates / custom images

* Update `Dockerfile` with the new Ruby version and/or base image version. There are `ENV` vars at the top, and the `FROM` also contains the Ubuntu version, so that is listed twice.
* Update this Readme to refer to the correct versions.
* Commit the changes
* Build and push the image. In case of errors, go back to previous steps until it _does_ work.
