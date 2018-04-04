FROM docker.corp.tanmer.com/tanmer/dockers/ubuntu:16.04
WORKDIR /srv/app
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bash -l -c "bundle i --without development test"
ADD .git .git
ADD public/assets public/assets
ADD public/packs public/packs
RUN git checkout -- . && echo $(git rev-parse --short HEAD) > public/VERSION && rm -rf .git
CMD ["entrypoint.sh"]
