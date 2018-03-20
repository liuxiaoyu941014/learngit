FROM docker.corp.tanmer.com/tanmer/dockers/ubuntu:16.04

RUN apt-get install imagemagick libmagickwand-dev -y
ARG BUNDLE_GEMS__TANMER__COM
WORKDIR /srv/dagle
COPY Gemfile* /srv/dagle/
COPY components /srv/dagle/components
COPY vendor/cache vendor/cache
RUN bash -c "source /etc/profile && BUNDLE_GEMS__TANMER__COM=${BUNDLE_GEMS__TANMER__COM} bundle install --jobs 4 --deployment --without development test"
COPY . .
RUN rm -f .ruby-version && rm -f .ruby-gemset && rm -rf vendor/cache
EXPOSE 3000
