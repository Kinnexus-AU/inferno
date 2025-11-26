# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/search_test'
require 'inferno_suite_generator/core/group_metadata'
require 'inferno_suite_generator/utils/helpers'

module KinnexusTestKit
  module KinnexusV001
    class KinnexusSmokingStatusCodeSearchTest < Inferno::Test
      include InfernoSuiteGenerator::SearchTest

      title '(SHALL) Server returns valid results for Observation search by code'
      description %(
A server SHALL support searching by
code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[Kinnexus Server CapabilityStatement](https://kinnexus.org/CapabilityStatement/kinnexus-responder)

      )

      id :kinnexus_v001_kinnexus_smoking_status_code_search_test

      def self.demodata
        @demodata ||= InfernoSuiteGenerator::Generator::IGDemodata.new(
          YAML.load_file(File.join(File.dirname(__dir__), 'demodata.yml'), aliases: true)
        )
      end

      def self.properties
        @properties ||= InfernoSuiteGenerator::SearchTestProperties.new(
          fixed_value_search: true,
          resource_type: 'Observation',
          search_param_names: ['code'],
          token_search_params: ['code']
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
