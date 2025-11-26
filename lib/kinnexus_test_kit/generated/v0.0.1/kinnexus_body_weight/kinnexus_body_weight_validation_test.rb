# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/validation_test'

module KinnexusTestKit
  module KinnexusV001
    class KinnexusBodyWeightValidationTest < Inferno::Test
      include InfernoSuiteGenerator::ValidationTest

      id :kinnexus_v001_kinnexus_body_weight_validation_test
      title 'Observation resources returned during previous tests conform to the Kinnexus Body Weight'
      description %(
This test verifies resources returned from the first search conform to
the [Kinnexus Body Weight](https://kinnexus.org/StructureDefinition/KinnexusBodyWeight).
If at least one resource from the first search is invalid, the test will fail.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )
      output :dar_code_found, :dar_extension_found

      def resource_type
        'Observation'
      end

      def scratch_resources
        scratch[:kinnexus_body_weight_resources] ||= {}
      end

      def filter_set
        []
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'https://kinnexus.org/StructureDefinition/KinnexusBodyWeight',
                                '0.1.0',
                                skip_if_empty: true)
      end
    end
  end
end
