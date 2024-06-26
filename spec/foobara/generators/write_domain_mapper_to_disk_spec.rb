RSpec.describe Foobara::Generators::DomainMapperGenerator::WriteDomainMapperToDisk do
  let(:command) { described_class.new(inputs) }
  let(:outcome) { command.run }
  let(:result) { outcome.result }
  let(:errors) { outcome.errors }
  let(:inputs) do
    {
      domain_mapper_config:,
      output_directory:
    }
  end
  let(:domain_mapper_config) do
    {
      name:,
      description: "whatever"
    }
  end
  let(:name) { "SomePrefix::SomeOrg::DomainMappers::SomeOtherDomain::SomeMapper" }
  let(:output_directory) { "#{__dir__}/../../../tmp/domain_mapper_test_suite_output" }

  before do
    # rubocop:disable RSpec/AnyInstance
    allow_any_instance_of(described_class).to receive(:git_commit).and_return(nil)
    allow_any_instance_of(described_class).to receive(:rubocop_autocorrect).and_return(nil)
    # rubocop:enable RSpec/AnyInstance
  end

  around do |example|
    FileUtils.mkdir_p output_directory

    FileUtils.cp "#{__dir__}/../../fixtures/fake_project/.ruby-version", output_directory
    FileUtils.cp "#{__dir__}/../../fixtures/fake_project/Gemfile", output_directory

    Dir.chdir output_directory do
      example.run
    end
  end

  after do
    FileUtils.rm_rf output_directory
  end

  describe "#run" do
    it "contains generated domain mapper" do
      expect(outcome).to be_success

      expect(command.paths_to_source_code.keys).to include(
        "src/some_prefix/some_org/domain_mappers/some_other_domain/some_mapper.rb"
      )
    end
  end

  describe "#output_directory" do
    context "with no output directory" do
      let(:inputs) do
        {
          domain_mapper_config:
        }
      end

      it "writes files to the current directory" do
        command.cast_and_validate_inputs
        expect(command.output_directory).to eq(".")
      end
    end
  end

  describe ".generator_key" do
    subject { described_class.generator_key }

    it { is_expected.to be_a(String) }
  end
end
