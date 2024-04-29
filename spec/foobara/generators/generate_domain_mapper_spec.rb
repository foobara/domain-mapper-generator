RSpec.describe Foobara::Generators::DomainMapperGenerator::GenerateDomainMapper do
  let(:name) { "SomePrefix::SomeOrg" }

  let(:inputs) do
    {
      name:,
      description: "whatever"
    }
  end
  let(:command) { described_class.new(inputs) }
  let(:outcome) { command.run }
  let(:result) { outcome.result }

  it "generates a domain mapper" do
    expect(outcome).to be_success

    domain_mapper_file = result["src/some_prefix/some_org.rb"]
    expect(domain_mapper_file).to include("module SomeOrg")
    expect(domain_mapper_file).to include("module SomePrefix")
  end
end
