# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module PDI
  # This class is the library's "metal" layer, the one which actually makes the system call and
  # interacts with the operating system (through Ruby's standard library.)
  class Executor
    Result = Struct.new(:pid, :out_and_err, :code, :cmd)

    SPACE = ' '

    def run(*args)
      cmd = args.flatten.join(SPACE)

      Open3.popen2e(cmd) do |_stdin, stdout_and_stderr, wait_thr|
        pid         = wait_thr.pid
        code        = wait_thr.value.to_s.split(SPACE).last.to_i
        out_and_err = stdout_and_stderr.read

        Result.new(pid, out_and_err, code, cmd)
      end
    end
  end
end
