require_relative "generate_domain_mapper"

module Foobara
  module Generators
    module DomainMapperGenerator
      class WriteDomainMapperToDisk < Foobara::Generators::WriteGeneratedFilesToDisk
        class << self
          def generator_key
            "domain-mapper"
          end
        end

        depends_on GenerateDomainMapper

        inputs do
          domain_mapper_config DomainMapperConfig, :required
          # TODO: should be able to delete this and inherit it
          output_directory :string
        end

        def execute
          generate_file_contents
          write_all_files_to_disk
          run_post_generation_tasks

          stats
        end

        def output_directory
          inputs[:output_directory] || default_output_directory
        end

        def default_output_directory
          "."
        end

        def generate_file_contents
          # TODO: just pass this in as the inputs instead of the domain mapper??
          # TODO: move chdir up to FilesGenerator project
          self.paths_to_source_code = run_subcommand!(GenerateDomainMapper, domain_mapper_config.attributes)
        end

        def run_post_generation_tasks
          Dir.chdir output_directory do
            bundle_install
            rubocop_autocorrect
          end
        end

        def bundle_install
          puts "bundling..."

          Bundler.with_unbundled_env do
            run_cmd_and_return_output("bundle install")
          end
        end

        def rubocop_autocorrect
          # :nocov:
          run_cmd_and_return_output("bundle exec rubocop --no-server -A")
          # :nocov:
        end
      end
    end
  end
end
