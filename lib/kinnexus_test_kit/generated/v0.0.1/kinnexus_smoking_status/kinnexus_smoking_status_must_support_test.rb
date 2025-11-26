# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/must_support_test'

module KinnexusTestKit
  module KinnexusV001
    class KinnexusSmokingStatusMustSupportTest < Inferno::Test
      include InfernoSuiteGenerator::MustSupportTest

      title 'All must support elements are provided in the Observation resources returned'
      description %(
        Kinnexus Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the Kinnexus Server Capability
        Statement. This test will look through the Observation resources
        found previously for the following must support elements:

        * Observation.category
        * Observation.code.coding.code
        * Observation.dataAbsentReason
        * Observation.effective[x]
        * Observation.status
        * Observation.subject
        * Observation.value[x]
      )

      id :kinnexus_v001_kinnexus_smoking_status_must_support_test

      def resource_type
        'Observation'
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:kinnexus_smoking_status_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
