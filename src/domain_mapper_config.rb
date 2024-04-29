require "English"

module Foobara
  module Generators
    module DomainMapperGenerator
      class DomainMapperConfig < Foobara::Model
        attributes do
          name :string, :required
          description :string, :allow_nil
        end

        def module_path
          @module_path ||= name.split("::")
        end
      end
    end
  end
end
