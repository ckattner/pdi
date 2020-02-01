# frozen_string_literal: true

#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

describe PDI::Spoon::PanError do
  describe 'initialization' do
    [1, 2, 3, 7, 8, 9].each do |code|
      specify "code #{code} should have message" do
        execution = PDI::Executor::Result.new('', code, '', 123)
        expect(described_class.new(execution).message).not_to eq('Unknown')
      end
    end

    [-1, 0, 4, 5, 6, 10, 11].each do |code|
      specify "code #{code} should not have message" do
        execution = PDI::Executor::Result.new('', code, '', 123)
        expect(described_class.new(execution).message).to eq('Unknown')
      end
    end
  end
end
