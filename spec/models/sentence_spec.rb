# frozen_string_literal: true

RSpec.describe Sentence, type: :model do
  describe 'associations' do
    it { should have_many(:entities) }
  end

  describe 'validations' do
    it { should validate_presence_of(:content) }
    it { should validate_uniqueness_of(:content).with_message('has already been taken') }
  end
end
