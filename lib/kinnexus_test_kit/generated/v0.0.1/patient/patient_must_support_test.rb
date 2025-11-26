# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/must_support_test'

module KinnexusTestKit
  module KinnexusV001
    class PatientMustSupportTest < Inferno::Test
      include InfernoSuiteGenerator::MustSupportTest

      title 'All must support elements are provided in the Patient resources returned'
      description %(
        Kinnexus Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the Kinnexus Server Capability
        Statement. This test will look through the Patient resources
        found previously for the following must support elements:

        * Patient.address
        * Patient.birthDate
        * Patient.communication
        * Patient.communication.language
        * Patient.communication.preferred
        * Patient.extension:genderIdentity
        * Patient.extension:indigenousStatus
        * Patient.extension:individualPronouns
        * Patient.gender
        * Patient.identifier
        * Patient.name
        * Patient.name.family
        * Patient.name.given
        * Patient.name.text
        * Patient.name.use
        * Patient.telecom
        * Patient.telecom.system
        * Patient.telecom.use
        * Patient.telecom.value
      )

      id :kinnexus_v001_patient_must_support_test

      def resource_type
        'Patient'
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:patient_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
