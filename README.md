# AusNimbus Component for Redis [![Build Status](https://travis-ci.org/ausnimbus/redis-component.svg?branch=master)](https://travis-ci.org/ausnimbus/redis-component) [![Docker Repository on Quay](https://quay.io/repository/ausnimbus/redis-component/status "Docker Repository on Quay")](https://quay.io/repository/ausnimbus/redis-component)

[![Redis](https://user-images.githubusercontent.com/2239920/27766348-650c915e-5f10-11e7-8a75-e2f39d828fbf.jpg)](https://www.ausnimbus.com.au/)

The [AusNimbus](https://www.ausnimbus.com.au/) component for [Redis](https://www.ausnimbus.com.au/instant-apps/redis/).

This document describes the behaviour and environment configuration when running Redis on AusNimbus.

## Table of Contents

- [Runtime Environments](#runtime-environments)
- [Environment Configuration](#environment-configuration)

## Runtime Environments

AusNimbus supports the latest stable release for Redis.

The currently supported versions are `3` and `4`

## Environment Configuration

The following environment variables are available for you to configure your Redis environment:

NAME                       | Description
---------------------------|-------------
REDIS_MAX_MEMORY           | Max memory Redis can use (default: automatically configured)
REDIS_DIR                  | Redis data directory (default: `/data`)
REDIS_EXTRA_OPTIONS        | Extra parameters to passed to `redis-server`
