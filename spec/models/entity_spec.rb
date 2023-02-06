# frozen_string_literal: true

RSpec.describe Entity, type: :model do
  describe 'associations' do
    it { should belong_to(:sentence) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:entity_type) }

    it {
      should validate_uniqueness_of(:entity_type).scoped_to(:sentence_id)
                                                 .with_message('has already been taken')
                                                 .case_insensitive
    }

    it { should_not allow_value('test@test').for(:name) }
    it { should_not allow_value('test!test').for(:entity_type) }
  end
end
