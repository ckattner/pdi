# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module PDI
  class Pan
    # This class knows how to parse the output of a Pan#version call.
    class VersionParser
      NEW_LINE = "\n"

      def parse(string)
        string.to_s
              .chomp
              .split(NEW_LINE)
              .last
              .to_s
      end
    end
  end
end
