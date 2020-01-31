# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require_relative 'spoon/kitchen_error'
require_relative 'spoon/options'
require_relative 'spoon/pan_error'
require_relative 'spoon/param'
require_relative 'spoon/parser'
require_relative 'spoon/result'

module PDI
  # This class is the main wrapper for PDI's pan and kitchen scripts.
  class Spoon
    DEFAULT_KITCHEN_SCRIPT = 'kitchen.sh'
    DEFAULT_PAN_SCRIPT     = 'pan.sh'

    attr_reader :dir, :kitchen_script, :pan_script

    def initialize(
      dir:,
      kitchen_script: DEFAULT_KITCHEN_SCRIPT,
      pan_script: DEFAULT_PAN_SCRIPT
    )
      assert_required(:dir, dir)
      assert_required(:kitchen_script, kitchen_script)
      assert_required(:pan_script, pan_script)

      @dir            = dir.to_s
      @kitchen_script = kitchen_script.to_s
      @pan_script     = pan_script.to_s
      @executor       = Executor.new
      @parser         = Parser.new

      freeze
    end

    def version
      args = [
        kitchen_path,
        Arg.new(Arg::Key::VERSION)
      ]

      result       = executor.run(args)
      version_line = parser.version(result.out_and_err)

      Result.new(result, version_line)
    end

    def run_transformation(options)
      options = Options.make(options)

      args = [
        pan_path
      ] + options.transformation_args

      result = executor.run(args)

      raise(PanError, result.code) if result.code != 0

      Result.new(result, result.code)
    end

    def run_job(options)
      options = Options.make(options)

      args = [
        pan_path
      ] + options.job_args

      result = executor.run(args)

      raise(KitchenError, result.code) if result.code != 0

      Result.new(result, result.code)
    end

    private

    attr_reader :executor, :parser

    def kitchen_path
      File.join(dir, kitchen_script)
    end

    def pan_path
      File.join(dir, pan_script)
    end

    def assert_required(name, value)
      raise ArgumentError, "#{name} is required" if value.to_s.empty?
    end
  end
end
