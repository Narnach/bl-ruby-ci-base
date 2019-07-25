# Setup a base image with some env vars, and re-use it:
# - once to do some local compilation
# - once to build our final image (without compilation steps' temporary data)
# MS SQL has a source list for it, so that's why we use it.
# Use the buildpack-deps version to get a lot of useful dependencies for free.
FROM buildpack-deps:16.04

# Top-level version config
ENV UBUNTU_VERSION="16.04"
ENV RUBY_VERSION="2.6.3"
ENV BUNDLER_VERSION="1.17.3"

# Rbenv relevant info
ENV RBENV_ROOT /usr/local/rbenv
# Rbenv and mssql have non-standard paths
ENV PATH $RBENV_ROOT/bin:$RBENV_ROOT/shims:/opt/mssql-tools/bin:$PATH

# Prevent interactive interface from asking to accept the EULA
ENV ACCEPT_EULA 'Y'

# Ruby compilation does not generate documentation
ENV CONFIGURE_OPTS --disable-install-doc

# Good default: don't install documentation and RI for gems
RUN echo 'gem: --no-document --no-ri' >> /root/.gemrc

# Base packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        # Enable HTTPS sources
        apt-transport-https \
        # Compile stuff
        build-essential \
        # Helps us fix locales to not run into odd C errors
        locales \
        # Helpful headers for Nokogiri
        libxml2-dev libxslt1-dev\
        # If you use Javascript, you need this
        nodejs \
        # Timezone data
        tzdata \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Fix the default locale in the image to something that does not raise odd C errors (before we compile anything)
RUN locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8

# Rbenv and ruby-build
RUN git clone --depth 1 git://github.com/sstephenson/rbenv.git /usr/local/rbenv && \
    git clone --depth 1 https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build && \
    /usr/local/rbenv/plugins/ruby-build/install.sh

# Ruby
RUN rbenv install $RUBY_VERSION && \
    rbenv global $RUBY_VERSION

# Bundler
RUN eval "$(rbenv init -)"; gem install bundler --version $BUNDLER_VERSION

# MS SQL instructions come from: https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-tools?view=sql-server-2017#ubuntu
# Add Microsoft's source list, which relies on HTTPS
RUN curl --silent https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl --silent https://packages.microsoft.com/config/ubuntu/$UBUNTU_VERSION/prod.list | tee /etc/apt/sources.list.d/msprod.list && \
    # Update apt-get with new repo, then install dependencies. Add related dependencies on their own lines to keep it clear what goes together.
    apt-get update && \
    apt-get install -y --no-install-recommends \
        mssql-tools unixodbc-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
