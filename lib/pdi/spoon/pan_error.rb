# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Pdi
  class Spoon
    # This class subclasses Ruby's StandardError and provides a mapping to custom Pan
    # specific error codes to messages.
    # You can find the list of errors in Pentaho's documentation site, for example:
    # https://help.pentaho.com/Documentation/8.0/Products/Data_Integration/Command_Line_Tools
    class PanError < StandardError
      MESSAGES = {
        '1' => 'Errors occurred during processing',
        '2' => 'An unexpected error occurred during loading / running of the transformation',
        '3' => 'Unable to prepare and initialize this transformation',
        '7' => "The transformation couldn't be loaded from XML or the Repository",
        '8' => 'Error loading steps or plugins (error in loading one of the plugins mostly)',
        '9' => 'Command line usage printing'
      }.freeze

      attr_reader :execution

      def initialize(execution)
        @execution = execution

        message = MESSAGES[execution.code.to_s] || 'Unknown'

        super(message)
      end
    end
  end
end
