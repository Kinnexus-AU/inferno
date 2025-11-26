# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/read_test'

module KinnexusTestKit
  module KinnexusV001
    class KinnexusBodyHeightReadTest < Inferno::Test
      include InfernoSuiteGenerator::ReadTest

      title '(SHALL) Server returns correct Observation resource from Observation read interaction'
      description 'A server SHALL support the Observation read interaction.'

      id :kinnexus_v001_kinnexus_body_height_read_test

      def self.demodata
        @demodata ||= InfernoSuiteGenerator::Generator::IGDemodata.new(
          YAML.load_file(File.join(File.dirname(__dir__), 'demodata.yml'), aliases: true)
        )
      end

      def resource_type
        'Observation'
      end

      def scratch_resources
        scratch[:kinnexus_body_height_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
