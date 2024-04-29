module Foobara
  module Generators
    module DomainMapperGenerator
      module Generators
        class DomainMapperGenerator < Foobara::FilesGenerator
          class << self
            def manifest_to_generator_classes(manifest)
              case manifest
              when DomainMapperConfig
                [
                  Generators::DomainMapperGenerator
                ]
              else
                # :nocov:
                raise "Not sure how build a generator for a #{manifest}"
                # :nocov:
              end
            end
          end

          def template_path
            ["src", "domain_mapper.rb.erb"]
          end

          def target_path
            *path, file = module_path.map { |part| Util.underscore(part) }

            file = "#{file}.rb"

            ["src", *path, file]
          end

          alias domain_mapper_config relevant_manifest

          def templates_dir
            "#{__dir__}/../../templates"
          end
        end
      end
    end
  end
end
