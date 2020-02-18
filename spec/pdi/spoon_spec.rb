# frozen_string_literal: true

#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

describe Pdi::Spoon do
  let(:mocks_dir) { %w[spec mocks spoon] }
  let(:dir)       { File.join(*mocks_dir) }

  describe '#run' do
    context 'transformations' do
      let(:options) do
        {
          repository: 'somewhere',
          name: 'something',
          type: :transformation
        }
      end

      context 'when code is 0' do
        it 'returns correct stdout, stderr and code' do
          script = 'return_code.sh 0'

          subject = described_class.new(
            dir: dir,
            kitchen: script,
            pan: script
          )

          result = subject.run(options)

          expect(result.out).to  eq("output to stdout\n")
          expect(result.err).to  eq("output to sterr\n")
          expect(result.code).to eq(0)
        end
      end

      [1, 2, 3, 7, 8, 9].each do |code|
        context "when code is #{code}" do
          specify 'returns correct stdout, stderr and code' do
            script = "return_code.sh #{code}"

            subject = described_class.new(
              dir: dir,
              kitchen: script,
              pan: script
            )

            expected = described_class::PanError

            expect { subject.run(options) }.to raise_error(expected)
          end
        end
      end
    end
  end

  describe '#run' do
    context 'jobs' do
      let(:options) do
        {
          repository: 'somewhere',
          name: 'something',
          type: :job
        }
      end

      context 'when code is 0' do
        it 'returns correct stdout, stderr and code' do
          script = 'return_code.sh 0'

          subject = described_class.new(
            dir: dir,
            kitchen: script,
            pan: script
          )

          result = subject.run(options)

          expect(result.out).to  eq("output to stdout\n")
          expect(result.err).to  eq("output to sterr\n")
          expect(result.code).to eq(0)
        end
      end

      [1, 2, 7, 8, 9].each do |code|
        context "when code is #{code}" do
          specify 'returns correct stdout, stderr and code' do
            script = "return_code.sh #{code}"

            subject = described_class.new(
              dir: dir,
              kitchen: script,
              pan: script
            )

            expected = described_class::KitchenError

            expect { subject.run(options) }.to raise_error(expected)
          end
        end
      end
    end

    describe '#version' do
      subject do
        described_class.new(
          dir: dir,
          kitchen: script,
          pan: script
        )
      end

      context 'when code is 0' do
        let(:script) { 'version.sh' }

        it 'returns parsed version line' do
          result = subject.version
          expected = [
            '2020/01/30 13:31:04 - Pan - Kettle version 6.1.0.1-196,',
            'build 1, build date : 2016-04-07 12.08.49'
          ].join(' ')

          expect(result.value).to eq(expected)
        end
      end

      context 'when code is not 0' do
        let(:script) { 'return_code.sh 1' }

        it 'raises KitchenError' do
          expected = described_class::KitchenError

          expect { subject.version }.to raise_error(expected)
        end
      end
    end
  end
end
