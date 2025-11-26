# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/search_test'
require 'inferno_suite_generator/core/group_metadata'
require 'inferno_suite_generator/utils/helpers'

module KinnexusTestKit
  module KinnexusV001
    class AllergyIntoleranceCategorySearchTest < Inferno::Test
      include InfernoSuiteGenerator::SearchTest

      title '(SHALL) Server returns valid results for AllergyIntolerance search by category'
      description %(
A server SHALL support searching by
category on the AllergyIntolerance resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[Kinnexus Server CapabilityStatement](https://kinnexus.org/CapabilityStatement/kinnexus-responder)

      )

      id :kinnexus_v001_allergy_intolerance_category_search_test

      def self.demodata
        @demodata ||= InfernoSuiteGenerator::Generator::IGDemodata.new(
          YAML.load_file(File.join(File.dirname(__dir__), 'demodata.yml'), aliases: true)
        )
      end

      def self.properties
        @properties ||= InfernoSuiteGenerator::SearchTestProperties.new(
          resource_type: 'AllergyIntolerance',
          search_param_names: ['category'],
          possible_status_search: true
        )
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:allergy_intolerance_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
