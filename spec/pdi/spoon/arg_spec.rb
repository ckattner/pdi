# frozen_string_literal: true

#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

describe PDI::Spoon::Arg do
  let(:key)   { :param }
  let(:value) { 'v1' }
  let(:value_with_space) { 'v 1' }

  describe '#initialize' do
    subject { described_class.new(key, value) }

    it 'requires a key' do
      expect { described_class.new('') }.to raise_error(ArgumentError)
    end

    it 'sets key' do
      expect(subject.key).to eq(key)
    end

    it 'sets value' do
      expect(subject.value).to eq(value)
    end
  end

  describe '#to_s' do
    it 'works without a value' do
      subject  = described_class.new(key)
      expected = "-#{key}"

      expect(subject.to_s).to eq(expected)
    end

    it 'works with a value (with no space)' do
      subject  = described_class.new(key, value)
      expected = "-#{key}:#{value}"

      expect(subject.to_s).to eq(expected)
    end

    it 'works with a value (with a space)' do
      subject  = described_class.new(key, value_with_space)
      expected = "\"-#{key}:#{value_with_space}\""

      expect(subject.to_s).to eq(expected)
    end
  end

  describe 'equality' do
    let(:subject2) { described_class.new(key, value) }

    subject { described_class.new(key, value) }

    specify '#hash compares key and value' do
      expect(subject.hash).to eq(subject2.hash)
    end

    specify '#== compares #to_s values' do
      expect(subject).to eq(subject2)
    end

    specify '#eql? compares #to_s values' do
      expect(subject).to eql(subject2)
    end
  end
end
