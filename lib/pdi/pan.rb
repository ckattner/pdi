# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require_relative 'pan/error'
require_relative 'pan/transformation'

module PDI
  # This class is the main wrapper for PDI's pan script.
  class Pan
    attr_reader :path

    def initialize(path)
      raise ArgumentError, 'path is required' if path.to_s.empty?

      @path     = path.to_s
      @executor = Executor.new
      @parser   = Parser.new

      freeze
    end

    def version
      args = [
        path,
        Arg.new(Arg::Key::VERSION)
      ]

      result       = executor.run(args)
      version_line = parser.version(result.out_and_err)

      Result.new(result, version_line)
    end

    def transform(transformation)
      transformation = Transformation.make(transformation)

      args = [
        path
      ] + transformation.to_args

      result = executor.run(args)

      raise(Error, result.code) if result.code != 0

      Result.new(result, result.code)
    end

    private

    attr_reader :executor, :parser
  end
end
