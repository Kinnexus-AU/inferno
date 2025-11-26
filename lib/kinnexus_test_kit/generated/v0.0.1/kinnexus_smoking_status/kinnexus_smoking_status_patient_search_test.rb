# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/search_test'
require 'inferno_suite_generator/core/group_metadata'
require 'inferno_suite_generator/utils/helpers'

module KinnexusTestKit
  module KinnexusV001
    class KinnexusSmokingStatusPatientSearchTest < Inferno::Test
      include InfernoSuiteGenerator::SearchTest

      title '(SHALL) Server returns valid results for Observation search by patient'
      description %(
A server SHALL support searching by
patient on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

This test verifies that the server supports searching by reference using
the form `patient=[id]` as well as `patient=Patient/[id]`. The two
different forms are expected to return the same number of results. Kinnexus requires that both forms are supported by Kinnexus responders.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of Kinnexus v0.0.1.

[Kinnexus Server CapabilityStatement](https://kinnexus.org/CapabilityStatement/kinnexus-responder)

      )

      id :kinnexus_v001_kinnexus_smoking_status_patient_search_test
      input :patient_ids,
            title: 'Patient IDs',
            description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements',
            default: 'baratz-toni, irvine-ronny-lawrence, italia-sofia, howe-deangelo, hayes-arianne, baby-banks-john, banks-mia-leanne'

      def self.demodata
        @demodata ||= InfernoSuiteGenerator::Generator::IGDemodata.new(
          YAML.load_file(File.join(File.dirname(__dir__), 'demodata.yml'), aliases: true)
        )
      end

      def self.properties
        @properties ||= InfernoSuiteGenerator::SearchTestProperties.new(
          first_search: true,
          resource_type: 'Observation',
          search_param_names: ['patient'],
          test_reference_variants: true,
          test_post_search: true
        )
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:kinnexus_smoking_status_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
