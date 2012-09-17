#!/bin/env ruby
# -*- coding: utf-8 -*-

require 'fluent-logger'

HOST = 'sl00'
PORT = 24224
TAG  = 'debug.test'

Fluent::Logger::FluentLogger.open(nil, :host=>HOST, :port=>PORT)
Fluent::Logger.post(TAG, {"agent"=>"foo"})
