# AusNimbus Redis

[![Build Status](https://travis-ci.org/ausnimbus/redis-component.svg?branch=master)](https://travis-ci.org/ausnimbus/redis-component)
[![Docker Repository on Quay](https://quay.io/repository/ausnimbus/redis-component/status "Docker Repository on Quay")](https://quay.io/repository/ausnimbus/redis-component)

This repository contains the source for deploying [Redis](https://www.ausnimbus.com.au/instant-apps/redis/)
on [AusNimbus](https://www.ausnimbus.com.au/).

## Environment Variables

The following environment variables are available to configure your Redis instance:

- REDIS_MAXMEMORY: Max memory Redis can use (default: automatically configured)
- REDIS_DIR: Redis data directory (default: `/data`)
- REDIS_EXTRA_OPTIONS: Extra parameters to passed to `redis-server`

## Versions

The versions currently supported are:

- 3.2
