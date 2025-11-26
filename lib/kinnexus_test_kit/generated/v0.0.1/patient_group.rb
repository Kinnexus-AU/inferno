# frozen_string_literal: true

require 'inferno_suite_generator/core/ig_demodata'
require_relative 'patient/patient_read_test'
require_relative 'patient/patient_validation_test'
require_relative 'patient/patient_must_support_test'

module KinnexusTestKit
  module KinnexusV001
    class PatientGroup < Inferno::TestGroup
      title 'Patient Tests'
      short_description 'Verify support for the server capabilities required by the Kinnexus Patient.'
      description %(
  # Background

The Kinnexus Patient sequence verifies that the system under test is
able to provide correct responses for Patient queries. These queries
must contain resources conforming to the Kinnexus Patient as
specified in the Kinnexus v0.0.1 Implementation Guide.

# Testing Methodology


## Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Patient resources found in the first test for these
elements.

## Profile Validation
Each resource returned from the first search is expected to conform to
the [Kinnexus Patient](https://kinnexus.org/StructureDefinition/KinnexusPatient). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

## Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.

      )

      id :kinnexus_v001_patient
      run_as_group

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'patient', 'metadata.yml'), aliases: true))
      end

      test from: :kinnexus_v001_patient_read_test
      test from: :kinnexus_v001_patient_validation_test
      test from: :kinnexus_v001_patient_must_support_test
    end
  end
end
