# frozen_string_literal: true

#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

describe PDI::Pan do
  let(:mocks_dir) { %w[spec mocks pan] }

  let(:transformation) do
    {
      repository: 'somewhere',
      name: 'something'
    }
  end

  describe '#transform' do
    context 'when code is 0' do
      it 'returns correct stdout, stderr and code' do
        path   = File.join(*mocks_dir, 'return_0.sh')
        pan    = described_class.new(path)
        result = pan.transform(transformation)

        expect(result.executor.out_and_err).to eq("output to stdout\noutput to sterr\n")
        expect(result.executor.code).to        eq(0)
      end
    end

    [1, 2, 3, 7, 8, 9].each do |code|
      context "when code is #{code}" do
        specify 'returns correct stdout, stderr and code' do
          path = File.join(*mocks_dir, "return_#{code}.sh")
          pan = described_class.new(path)
          expect { pan.transform(transformation) }.to raise_error(described_class::Error)
        end
      end
    end
  end

  describe '#version' do
    let(:path) { File.join('spec', 'mocks', 'pan', 'version.sh') }

    subject { described_class.new(path) }

    it 'returns parsed version line' do
      result = subject.version
      expected = [
        '2020/01/30 13:31:04 - Pan - Kettle version 6.1.0.1-196,',
        'build 1, build date : 2016-04-07 12.08.49'
      ].join(' ')

      expect(result.value).to eq(expected)
    end
  end
end
