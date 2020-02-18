# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require_relative 'kitchen_error'
require_relative 'options/level'
require_relative 'options/param'
require_relative 'pan_error'

module Pdi
  class Spoon
    # This class serves as the input for executing a transformation or job through Pan or Kitchen.
    class Options
      acts_as_hashable

      module Type
        JOB            = :job
        TRANSFORMATION = :transformation
      end

      TYPES_TO_ERRORS = {
        Type::JOB => KitchenError,
        Type::TRANSFORMATION => PanError
      }.freeze

      TYPES_TO_KEYS = {
        Type::JOB => Arg::Key::JOB,
        Type::TRANSFORMATION => Arg::Key::TRANS
      }.freeze

      attr_reader :level,
                  :name,
                  :params,
                  :repository,
                  :type

      def initialize(
        level: Level::BASIC,
        name:,
        params: {},
        repository:,
        type:
      )
        raise ArgumentError, 'name is required'       if name.to_s.empty?
        raise ArgumentError, 'repository is required' if repository.to_s.empty?
        raise ArgumentError, 'type is required'       if type.to_s.empty?

        @level      = constant(Level, level)
        @name       = name.to_s
        @params     = params || {}
        @repository = repository.to_s
        @type       = constant(Type, type)

        freeze
      end

      def to_args
        base_args + param_args
      end

      def error_constant
        TYPES_TO_ERRORS.fetch(type)
      end

      private

      def key
        TYPES_TO_KEYS.fetch(type)
      end

      def base_args
        [
          Arg.new(Arg::Key::REP, repository),
          Arg.new(key, name),
          Arg.new(Arg::Key::LEVEL, level)
        ]
      end

      def param_args
        params.map { |key, value| Param.new(key, value) }
      end

      def constant(constant, value)
        constant.const_get(value.to_s.upcase.to_sym)
      end
    end
  end
end
