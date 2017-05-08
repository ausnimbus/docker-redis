# AusNimbus Redis

[![Build Status](https://travis-ci.org/ausnimbus/redis-container.svg?branch=master)](https://travis-ci.org/ausnimbus/redis-container)
[![Docker Repository on Quay](https://quay.io/repository/ausnimbus/redis/status "Docker Repository on Quay")](https://quay.io/repository/ausnimbus/redis)

This repository contains the source for deploying [Redis](https://www.ausnimbus.com.au/instant-apps/redis/)
on [AusNimbus](https://www.ausnimbus.com.au/).

## Environment Variables
-----------

The following environment variables are available to configure your redis instance:

* REDIS_MAX_MEMORY: Max memory Redis can use (automatically set to maximum memory)
* REDIS_EXTRA_PARAMETERS: Extra command line parameters to pass to command `redis-server`

## Versions

The versions currently supported are:

- 3.2
