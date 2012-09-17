#!/bin/env ruby
# -*- coding: utf-8 -*-

require "logger"

class Logger
  class LogDevice
    def add_log_header(file)
      # ログファイルのヘッダーを無効にする
    end
  end
end

class MyLogger
  LOG_FILE_NAME = '/home/fluent/multiline.log'
  SHIFT_AGE = 5
  SHIFT_SIZE = 200

  def initialize
    @logger = Logger.new(LOG_FILE_NAME, SHIFT_AGE, SHIFT_SIZE)
    @logger.level = Logger::DEBUG
    @logger.formatter = Class.new(Logger::Formatter) do
      def call(severity, time, progname, msg)
        "#{time.to_s} #{severity} #{msg}\n"
      end
    end.allocate
  end

  def debug(message)
    @logger.debug message
  end
end

logger = MyLogger.new
#logger.debug "hoge"
logger.debug "hoge\nfuga\npiyo"
