# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require_relative 'arg'

module PDI
  class Param < Arg
    EQUALS = '='

    attr_reader :key, :value

    def initialize(key, value = '')
      super(Key::PARAM, "#{key}#{EQUALS}#{value}")

      freeze
    end
  end
end
