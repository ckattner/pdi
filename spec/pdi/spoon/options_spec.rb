# frozen_string_literal: true

#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

describe PDI::Spoon::Options do
  describe '#to_args' do
    let(:params) do
      {
        key1: 'value1',
        key2: 'value2',
        key3: 'value with spaces'
      }
    end

    let(:repository) { 'some repo' }

    let(:name) { 'some_transformation' }

    subject do
      described_class.new(
        params: params,
        repository: repository,
        name: name
      )
    end

    it 'wraps any args with spaces inside double quotes' do
      args             = subject.transformation_args
      args_with_spaces = args.select { |a| a.to_s.include?(' ') }

      raise ArgumentError, 'no examples to assert!' if args_with_spaces.empty?

      args_with_spaces.each do |arg|
        actual = arg.to_s

        expect(actual).to start_with('"')
        expect(actual).to end_with('"')
      end
    end

    it 'includes each option' do
      expected = [
        '"-rep:some repo"',
        '-trans:some_transformation',
        '-level:Basic',
        '-param:key1=value1',
        '-param:key2=value2',
        '"-param:key3=value with spaces"'
      ]

      expected_set = Set[*expected]
      actual_set   = Set[*subject.transformation_args.map(&:to_s)]

      expect(actual_set).to eq(expected_set)
    end
  end
end
