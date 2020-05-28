# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require_relative 'executor/result'

module Pdi
  # This class is the library's "metal" layer, the one which actually makes the system call and
  # interacts with the operating system (through Ruby's standard library.)
  class Executor
    attr_reader :timeout_in_seconds

    def initialize(timeout_in_seconds: nil)
      @timeout_in_seconds = timeout_in_seconds

      freeze
    end

    def run(args)
      args = Array(args).map(&:to_s)

      IO.popen(args, err: %i[child out]) do |io|
        io_read =
          if timeout_in_seconds
            Timeout.timeout(timeout_in_seconds) { io.read }
          else
            io.read
          end

        io.close
        status = $CHILD_STATUS

        Result.new(
          args: args,
          status: {
            code: status.exitstatus,
            out: io_read,
            pid: status.pid
          }
        )
      rescue Timeout::Error => e
        Process.kill(9, io.pid)
        raise e
      end
    end
  end
end
