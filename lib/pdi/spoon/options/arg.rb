# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Pdi
  class Spoon
    class Options
      # This class can form Pentaho-specific command-line arguments.
      class Arg
        COLON         = ':'
        DOUBLE_QUOTE  = '"'
        EMPTY         = ''
        HYPHEN        = '-'
        SPACE         = ' '

        module Key
          JOB     = :job
          LEVEL   = :level
          PARAM   = :param
          REP     = :rep
          TRANS   = :trans
          VERSION = :version
        end

        attr_reader :key, :value

        def initialize(key, value = '')
          raise ArgumentError, 'key is required' if key.to_s.empty?

          @key   = Key.const_get(key.to_s.upcase.to_sym)
          @value = value.to_s

          freeze
        end

        def to_s
          separator = value.to_s.empty? ? EMPTY : COLON
          wrapper   = wrap?(key, value) ? DOUBLE_QUOTE : EMPTY
          prefix    = HYPHEN

          "#{wrapper}#{prefix}#{key}#{separator}#{value}#{wrapper}"
        end

        def hash
          [key, value].hash
        end

        def ==(other)
          other.instance_of?(self.class) &&
            key == other.key &&
            value == other.value
        end
        alias eql? ==

        private

        def wrap?(key, value)
          key.to_s.include?(SPACE) || value.to_s.include?(SPACE)
        end
      end
    end
  end
end
