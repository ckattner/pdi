# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Pdi
  class Spoon
    # General return object for wrapping up a execution call result (execution) and
    # a usable result (value)
    class Result
      attr_reader :execution, :value

      def initialize(execution, value)
        @execution = execution
        @value     = value

        freeze
      end
    end
  end
end
