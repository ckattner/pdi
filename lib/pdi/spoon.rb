# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require_relative 'spoon/options'
require_relative 'spoon/parser'
require_relative 'spoon/result'

module Pdi
  # This class is the main wrapper for Pdi's pan and kitchen scripts.
  class Spoon
    DEFAULT_KITCHEN = 'kitchen.sh'
    DEFAULT_PAN     = 'pan.sh'

    attr_reader :args, :dir, :kitchen, :pan

    def initialize(
      args: [],
      dir:,
      kitchen: DEFAULT_KITCHEN,
      pan: DEFAULT_PAN
    )
      assert_required(:dir, dir)
      assert_required(:kitchen, kitchen)
      assert_required(:pan, pan)

      @args           = Array(args)
      @dir            = dir.to_s
      @kitchen        = kitchen.to_s
      @pan            = pan.to_s
      @executor       = Executor.new
      @parser         = Parser.new

      freeze
    end

    # Returns a Spoon::Result instance when PDI returns error code 0 or else raises
    # a KitchenError since Kitchen was used to run the version command.
    def version
      final_args = [kitchen_path] + args + [Options::Arg.new(Options::Arg::Key::VERSION)]

      result       = executor.run(final_args)
      version_line = parser.version(result.out)

      raise(KitchenError, result) if result.code != 0

      Result.new(result, version_line)
    end

    # Returns an Executor::Result instance when PDI returns error code 0 or else raises
    # a PanError (transformation) or KitchenError (job).
    def run(options)
      options    = Options.make(options)
      final_args = [pan_path] + args + options.to_args

      executor.run(final_args).tap do |result|
        raise(options.error_constant, result) if result.code != 0
      end
    end

    private

    attr_reader :executor, :parser

    def kitchen_path
      File.join(dir, kitchen)
    end

    def pan_path
      File.join(dir, pan)
    end

    def assert_required(name, value)
      raise ArgumentError, "#{name} is required" if value.to_s.empty?
    end
  end
end
