# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module PDI
  class Spoon
    # This class subclasses Ruby's StandardError and provides a mapping to custom Pentaho
    # specific error codes to messages.
    class PanError < StandardError
      MESSAGES = {
        '1' => 'Errors occurred during processing',
        '2' => 'An unexpected error occurred during loading / running of the transformation',
        '3' => 'Unable to prepare and initialize this transformation',
        '7' => "The transformation couldn't be loaded from XML or the Repository",
        '8' => 'Error loading steps or plugins (error in loading one of the plugins mostly)',
        '9' => 'Command line usage printing'
      }.freeze

      attr_reader :code

      def initialize(code)
        @code = code

        message = MESSAGES[code.to_s] || 'Unknown'

        super(message)
      end
    end
  end
end
