# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require_relative 'pan/error'
require_relative 'pan/transformation'
require_relative 'pan/version_parser'

module PDI
  class Pan
    VersionResult   = Struct.new(:executor, :value)
    TransformResult = Struct.new(:executor)

    attr_reader :path

    def initialize(path)
      raise ArgumentError, 'path is required' if path.to_s.empty?

      @path           = path.to_s
      @executor       = Executor.new
      @version_parser = VersionParser.new

      freeze
    end

    def version
      args = [
        path,
        Arg.new(Arg::Key::VERSION)
      ]

      result       = executor.run(args)
      version_line = version_parser.parse(result.out_and_err)

      VersionResult.new(result, version_line)
    end

    def transform(transformation)
      transformation = Transformation.make(transformation)

      args = [
        path
      ] + transformation.to_args

      result = executor.run(args)

      raise(Error, result.code) if result.code != 0

      TransformResult.new(result)
    end

    private

    attr_reader :executor, :version_parser
  end
end
