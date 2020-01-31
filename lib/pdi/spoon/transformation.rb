# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require_relative 'level'

module PDI
  class Spoon
    # This class serves as the input for executing a transformation through Pan.
    class Transformation
      acts_as_hashable

      attr_reader :level,
                  :name,
                  :params,
                  :repository

      def initialize(
        level: Level::BASIC,
        name:,
        params: {},
        repository:
      )
        raise ArgumentError, 'name is required'       if name.to_s.empty?
        raise ArgumentError, 'repository is required' if repository.to_s.empty?

        @level      = Level.const_get(level.to_s.upcase.to_sym)
        @name       = name.to_s
        @params     = params || {}
        @repository = repository.to_s

        freeze
      end

      def to_args
        base_args + param_args
      end

      private

      def base_args
        [
          Arg.new(Arg::Key::REP, repository),
          Arg.new(Arg::Key::TRANS, name),
          Arg.new(Arg::Key::LEVEL, level)
        ]
      end

      def param_args
        params.map { |key, value| Param.new(key, value) }
      end
    end
  end
end
