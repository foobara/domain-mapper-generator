module Foobara
  module Generators
    module DomainMapperGenerator
      module Generators
        class GemfileGenerator < DomainMapperGenerator
          def applicable?
            gemfile_contents !~ /^\s*gem\s*["']foobara-domain-mapper-generator\b/
          end

          def template_path
            "Gemfile"
          end

          def target_path
            "Gemfile"
          end

          def generate(_elements_to_generate)
            match = gemfile_contents.match(/^gem /)

            if match
              new_entry = 'gem "foobara-domain-mapper-generator", github: "foobara/domain-mapper-generator"'
              "#{match.pre_match}\n#{new_entry}\n#{match}#{match.post_match}"
            else
              # TODO: maybe print a warning and return the original Gemfile
              # :nocov:
              raise "Not sure how to inject foobara-domain-mapper-generator into the Gemfile"
              # :nocov:
            end
          end

          def gemfile_contents
            File.read(template_path)
          end
        end
      end
    end
  end
end
