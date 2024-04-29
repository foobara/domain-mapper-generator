require "pathname"

require_relative "domain_mapper_config"

module Foobara
  module Generators
    module DomainMapperGenerator
      class GenerateDomainMapper < Foobara::Generators::Generate
        class MissingManifestError < RuntimeError; end

        possible_error MissingManifestError

        inputs DomainMapperConfig

        def execute
          add_initial_elements_to_generate

          each_element_to_generate do
            generate_element
          end

          paths_to_source_code
        end

        attr_accessor :manifest_data

        def base_generator
          Generators::DomainMapperGenerator
        end

        # TODO: delegate this to base_generator
        def templates_dir
          # TODO: implement this?
          # :nocov:
          "#{__dir__}/../templates"
          # :nocov:
        end

        def add_initial_elements_to_generate
          elements_to_generate << domain_mapper_config
        end

        def domain_mapper_config
          @domain_mapper_config ||= DomainMapperConfig.new(inputs)
        end
      end
    end
  end
end
