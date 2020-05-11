# frozen_string_literal: true

#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

describe Pdi::Executor do
  let(:script)      { File.join('spec', 'mocks', 'spoon', 'sleep.sh') }
  let(:one_second)  { 1 }
  let(:return_code) { 33 }

  describe '#run' do
    context 'with a timeout' do
      # do not make these too high, bugs could cause the entire script to still be executed without
      # killing it so these high values could draw out results.
      let(:thirty_seconds) { 30 }

      subject { described_class.new(timeout_in_seconds: one_second) }

      # This will run a script that will take 30 seconds to process, but by limiting the
      # timeout using the #run argument, it should raise an error after one second.
      it 'times out and kills process after 1 second' do
        args = [script, thirty_seconds]

        expect { subject.run(args) }.to raise_error(Timeout::Error)
      end
    end

    context 'without a timeout' do
      it 'returns right exit status as code' do
        args = [script, one_second, return_code]

        result = subject.run(args)

        expect(result.code).to eq(return_code)
      end

      it 'returns right standard output and error as out' do
        args = [script, one_second, return_code]

        result = subject.run(args)

        expect(result.out).to eq("std_out\nerr_out\nafter_sleep\n")
      end
    end
  end
end
