# frozen_string_literal: true

#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

describe PDI::Spoon::Param do
  let(:key)   { 'k1' }
  let(:value) { 'v1' }
  let(:value_with_space) { 'v 1' }

  describe '#to_s' do
    it 'works without a value' do
      subject  = described_class.new(key)
      expected = "-param:#{key}="

      expect(subject.to_s).to eq(expected)
    end

    it 'works with a value (with no space)' do
      subject  = described_class.new(key, value)
      expected = "-param:#{key}=#{value}"

      expect(subject.to_s).to eq(expected)
    end

    it 'works with a value (with a space)' do
      subject  = described_class.new(key, value_with_space)
      expected = "\"-param:#{key}=#{value_with_space}\""

      expect(subject.to_s).to eq(expected)
    end
  end
end
