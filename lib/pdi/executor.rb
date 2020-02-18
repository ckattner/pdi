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
    SPACE = ' '

    def run(*args)
      cmd = args.flatten.join(SPACE)

      out, err, status = Open3.capture3(cmd)

      Result.new(
        cmd,
        status.exitstatus,
        out,
        err,
        status.pid
      )
    end
  end
end
