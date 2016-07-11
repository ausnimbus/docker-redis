FROM  openshift/base-centos7

MAINTAINER AusNimbus <support@ausnimbus.com.au>

ENV REDIS_VERSION 3.2.3
ENV REDIS_SHA1 92d6d93ef2efc91e595c8bf578bf72baff397507

LABEL io.k8s.description="Redis is an open source (BSD licensed), in-memory data structure store, used as database, cache and message broker." \
      io.k8s.display-name="Redis 3.2" \
      io.openshift.expose-services="6379:redis" \
      io.openshift.tags="cache,nosql,redis"

EXPOSE 6379

RUN curl -o redis.tar.gz -SL http://download.redis.io/releases/redis-${REDIS_VERSION}.tar.gz \
      && echo "$REDIS_SHA1 *redis.tar.gz" | sha1sum -c - \
      && tar -xzf redis.tar.gz -C /usr/src \
      && rm redis.tar.gz \
      && mv "/usr/src/redis-$REDIS_VERSION" /usr/src/redis \
      && make -C /usr/src/redis \
      && make -C /usr/src/redis install \
      && rm -r /usr/src/redis

COPY container-entrypoint /usr/bin/

USER 1001
VOLUME /opt/app-root/src
ENTRYPOINT ["container-entrypoint"]
CMD ["redis-server"]
