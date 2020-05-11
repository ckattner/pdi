# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Pdi
  class Executor
    # General return object for describing the operating system return data.
    class Status
      acts_as_hashable

      attr_reader :code, :out, :pid

      def initialize(code:, out: '', pid:)
        @code = code
        @out  = out
        @pid  = pid

        freeze
      end
    end
  end
end
