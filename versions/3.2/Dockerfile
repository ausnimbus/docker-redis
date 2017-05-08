#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "./hack/run update"
#
# DO NOT EDIT IT DIRECTLY.
#
# <pre>

FROM redis:3.2-alpine
MAINTAINER AusNimbus <support@ausnimbus.com.au>

LABEL summary="Platform for running Redis 3.2 applications" \
      maintainer="AusNimbus <support@ausnimbus.com.au>" \
      io.k8s.description="Platform for running Redis 3.2 applications" \
      io.k8s.display-name="Redis 3.2"

ENV HOME=/opt/app-root/src

RUN apk --no-cache add bash rsync git && rm -rf /var/cache/apk/* && \
    mkdir -p ${HOME}/.pki/nssdb && \
    chown -R 1001:0 ${HOME}/.pki && \
    adduser -S -u 1001 -G root -h ${HOME} -s /sbin/nologin \
      -g "Default Application User" default && \
    chown -R 1001:0 /opt/app-root

# Copy common executable utilities.
COPY ./common/bin/ /usr/bin/

# Each container image can have 'contrib' a directory with extra files needed to
# run and build the application.
COPY ./contrib/ /opt/app-root

# </pre>
# <component>

# Copy the component scripts (override existing container-entrypoint)
COPY ./component/bin/ /usr/bin/

# </component>
# <template>

LABEL io.openshift.expose-services="6379:tcp" \
    io.openshift.tags="component,redis"

RUN chown -R 1001:0 /data && chmod -R ug+rwx /data

# </template>
# <post>

# Drop the root user and make the content of /opt/app-root owned by user 1001
RUN chown -R 1001:0 /opt/app-root && chmod -R ug+rwx /opt/app-root
USER 1001

ENTRYPOINT ["container-entrypoint"]

# </post>
