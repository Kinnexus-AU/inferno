# frozen_string_literal: true

require 'base64'
require 'inferno/dsl/oauth_credentials'
require 'inferno_suite_generator/utils/helpers'
require_relative '../../version'

require_relative 'patient_group'
require_relative 'kinnexus_body_height_group'
require_relative 'kinnexus_body_weight_group'
require_relative 'kinnexus_smoking_status_group'
require_relative 'allergy_intolerance_group'
require_relative 'encounter_group'
require_relative 'immunization_group'
require_relative 'related_person_group'
require_relative 'questionnaire_response_group'

module KinnexusTestKit
  module KinnexusV001
    class KinnexusTestSuite < Inferno::TestSuite
      title 'Kinnexus v0.0.1'
      description %(
        The Kinnexus Test Kit tests systems for their conformance to the [Kinnexus Implementation Guide](https://kinnexus.org/ImplementationGuide/fhir.kinnexus).

        HL7® FHIR® resources are validated with the Java validator using
        https://tx.dev.hl7.org.au/fhir as the terminology server.
      )
      version VERSION

      VERSION_SPECIFIC_MESSAGE_FILTERS = [].freeze

      def self.metadata
        @metadata ||= YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true)[:groups].map do |raw_metadata|
          Generator::GroupMetadata.new(raw_metadata)
        end
      end

      fhir_resource_validator do
        igs '/home/igs/0.0.1.tgz'
        message_filters = [
          "The value provided ('xml') was not found in the value set 'MimeType'",
          "The value provided ('json') was not found in the value set 'MimeType'",
          "The value provided ('ttl') was not found in the value set 'MimeType'"
        ] + VERSION_SPECIFIC_MESSAGE_FILTERS

        cli_context do
          txServer ENV.fetch('TX_SERVER_URL', 'https://tx.dev.hl7.org.au/fhir')
          disableDefaultResourceFetcher false
        end

        exclude_message do |message|
          Helpers.is_message_exist_in_list(message_filters, message.message)
        end

        perform_additional_validation do |resource, _profile_url|
          ProvenanceValidator.validate(resource) if resource.instance_of?(FHIR::Provenance)
        end
      end

      links [
        {
          label: 'Report Issue',
          url: 'https://github.com'
        },
        {
          label: 'Source Code',
          url: 'https://github.com'
        },
        {
          label: 'Implementation Guide',
          url: 'https://github.com'
        }
      ]

      id :kinnexus_v001

      input :url,
            title: 'FHIR Endpoint',
            description: 'URL of the FHIR endpoint',
            default: ''
      input :smart_credentials,
            title: 'OAuth Credentials',
            type: :oauth_credentials,
            optional: true
      input :header_name,
            title: 'Header name',
            optional: true
      input :header_value,
            title: 'Header value',
            optional: true

      fhir_client do
        url :url
        oauth_credentials :smart_credentials
        headers Helpers.get_http_header(header_name, header_value)
      end

      group do
        title 'Kinnexus FHIR API'
        id :kinnexus_v001_fhir_api

        group from: :kinnexus_v001_patient

        group from: :kinnexus_v001_kinnexus_body_height

        group from: :kinnexus_v001_kinnexus_body_weight

        group from: :kinnexus_v001_kinnexus_smoking_status

        group from: :kinnexus_v001_allergy_intolerance

        group from: :kinnexus_v001_encounter

        group from: :kinnexus_v001_immunization

        group from: :kinnexus_v001_related_person

        group from: :kinnexus_v001_questionnaire_response
      end
    end
  end
end
