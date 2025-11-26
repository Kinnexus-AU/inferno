# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/reference_resolution_test'

module KinnexusTestKit
  module KinnexusV001
    class KinnexusBodyHeightReferenceResolutionTest < Inferno::Test
      include InfernoSuiteGenerator::ReferenceResolutionTest

      title 'MustSupport references within Observation resources are valid'
      description %(
        This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding Kinnexus profile.

        Elements which may provide external references include:

        * Observation.subject
      )

      id :kinnexus_v001_kinnexus_body_height_reference_resolution_test

      def resource_type
        'Observation'
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:kinnexus_body_height_resources] ||= {}
      end

      run do
        perform_reference_resolution_test(scratch_resources[:all], {})
      end
    end
  end
end
