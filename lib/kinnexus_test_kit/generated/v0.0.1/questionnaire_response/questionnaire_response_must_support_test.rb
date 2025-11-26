# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/must_support_test'

module KinnexusTestKit
  module KinnexusV001
    class QuestionnaireResponseMustSupportTest < Inferno::Test
      include InfernoSuiteGenerator::MustSupportTest

      title 'All must support elements are provided in the QuestionnaireResponse resources returned'
      description %(
        Kinnexus Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the Kinnexus Server Capability
        Statement. This test will look through the QuestionnaireResponse resources
        found previously for the following must support elements:


      )

      id :kinnexus_v001_questionnaire_response_must_support_test

      def resource_type
        'QuestionnaireResponse'
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:questionnaire_response_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
