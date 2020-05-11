# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require_relative 'status'

module Pdi
  class Executor
    # General return object for an execution call result.
    class Result
      extend Forwardable
      acts_as_hashable

      attr_reader :args, :status

      def_delegators :status, :code, :out, :pid

      def initialize(args:, status: {})
        @args   = args
        @status = Status.make(status)

        freeze
      end
    end
  end
end
