# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Pdi
  class Executor
    # General return object for an execution call result.
    class Result
      attr_reader :cmd,
                  :code,
                  :out,
                  :err,
                  :pid

      def initialize(cmd, code, out, err, pid)
        @cmd  = cmd
        @code = code
        @out  = out
        @err  = err
        @pid  = pid

        freeze
      end
    end
  end
end
