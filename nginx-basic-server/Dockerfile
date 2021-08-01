# syntax=docker/dockerfile:experimental
# ref: [https://stackoverflow.com/questions/57739560/what-do-i-need-to-change-in-nginx-official-dockers-image-to-have-the-set-misc-n]
# FROM nginx:${NGINX_VERSION} as build
FROM nginx:1.19.9-alpine as build
ENV NGINX_VERSION=1.19.9
RUN echo "http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz"

RUN apk update && \
    apk add \
        openssh-client \
        git \
        wget \
        # pcre-dev \
        automake \
        gcc \
        g++ \
        make && \
    rm -rf /var/cache/apt

RUN mkdir -p /usr/src
RUN wget "http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz" && \
    tar -C /usr/src -xzvf nginx-${NGINX_VERSION}.tar.gz

RUN mkdir -p -m 0600 ~/.ssh && \
    ssh-keyscan github.com >> ~/.ssh/known_hosts

# WORKDIR /src/ngx_devel_kit
# RUN --mount=type=ssh git clone git@github.com:simpl/ngx_devel_kit .

RUN mkdir -p /src
WORKDIR /src
# RUN wget "https://github.com/openresty/echo-nginx-module/archive/refs/tags/v0.62.tar.gz" && \
    # tar -xzvf v0.62.tar.gz
RUN git clone https://github.com/openresty/echo-nginx-module.git

# WORKDIR /src/set-misc-nginx-module
# RUN --mount=type=ssh git clone git@github.com:openresty/set-misc-nginx-module.git .

WORKDIR /usr/src/nginx-${NGINX_VERSION}

RUN NGINX_ARGS=$(nginx -V 2>&1 | sed -n -e 's/^.*arguments: //p') \
    ./configure --with-compat --with-http_ssl_module --add-dynamic-module=/src/echo-nginx-module ${NGINX_ARGS} && \
    make modules
RUN mkdir -p /opt/modules
COPY /usr/src/nginx-${NGINX_VERSION} /opt/modules

FROM nginx:1.19.9-alpine

# COPY nginx.conf /etc/nginx/nginx.conf
# COPY --from=build /usr/src/nginx-${NGINX_VERSION}/objs/ngx_http_set_misc_module.so /usr/src/nginx-${NGINX_VERSION}/objs/ndk_http_module.so /usr/lib/nginx/modules/
COPY --from=build /opt/modules/echo-nginx-module.so /usr/lib/nginx/modules/