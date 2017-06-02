module V1
  RSpec.describe ExerciseResource do
    let :creatable_fields do
      [:title, :unit]
    end

    subject do
      described_class.new Exercise, {}
    end

    it "has the correct creatable fields" do
      expect(described_class.creatable_fields({}).sort).to eq creatable_fields.sort
    end

    it "has the correct updatable fields" do
      expect(described_class.updatable_fields({}).sort).to eq creatable_fields.sort
    end

    it "has the correct fetchable fields" do
      expect(subject.fetchable_fields.sort).to eq (creatable_fields + [:id, :sentences, :created_at, :updated_at]).sort
    end
  end
end
