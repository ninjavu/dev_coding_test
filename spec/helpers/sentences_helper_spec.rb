# frozen_string_literal: true

RSpec.describe SentencesHelper, type: :helper do
  describe '#annotated_content' do
    context 'when single entity' do
      let(:entity) do
        Entity.new(name: 'Apple', entity_type: 'ORG')
      end

      it 'annotates 1 word within sentence correctly' do
        result = helper.annotated_content('fdfdfdf Apple', [entity])
        expect(result).to include(/span/).exactly(2).times
      end

      it "doesn't annotate if word merged with other word in sentence" do
        result = helper.annotated_content('fdfdfdfApple', [entity])
        expect(result).to include(/span/).exactly(0).times
      end

      it 'annotates 2 words within sentence correctly' do
        result = helper.annotated_content('fdfdfdf Apple Apple', [entity])
        expect(result).to include(/span/).exactly(4).times
      end

      it 'annotates 2 words within sentence correctly if 1 word is merged' do
        result = helper.annotated_content('fdfdfdf Apple Appletest', [entity])
        expect(result).to include(/span/).exactly(2).times
      end

      it "doesn't annotates words with special chars inside" do
        result = helper.annotated_content('fdfdfdf Apple App@le', [entity])
        expect(result).to include(/span/).exactly(2).times
      end

      it 'annotates words with special chars outside' do
        result = helper.annotated_content('test Apple Apple, @Apple xApple App.le Appl@e Apple@', [entity])
        expect(result).to include(/span/).exactly(8).times
      end

      it 'annotates words with extra spaces' do
        result = helper.annotated_content("test Apple \n \n      Apple       , @Apple                 ", [entity])
        expect(result).to include(/span/).exactly(6).times
      end
    end

    context 'when multiple entities' do
      let(:entities) do
        [
          Entity.new(name: 'Apple', entity_type: 'ORG'),
          Entity.new(name: 'Facebook', entity_type: 'ORGG'),
          Entity.new(name: 'Alphabet', entity_type: 'ORGGG')
        ]
      end

      it 'annotates words within sentence correctly' do
        result = helper.annotated_content('fdfdfdf Apple Facebook Alphabet', entities)
        expect(result).to include(/span/).exactly(6).times
      end

      it 'annotates words with rigt types' do
        result = helper.annotated_content('fdfdfdf Apple Facebook Alphabet', entities)
        expect(result).to include(/\ORG\b/).exactly(1).times
        expect(result).to include(/\ORGG\b/).exactly(1).times
        expect(result).to include(/\ORGGG\b/).exactly(1).times
      end

      it 'annotates recursive words corretly' do
        result = helper.annotated_content('fdfdfdf Apple Apple Facebook Facebook Alphabet Alphabet', entities)
        expect(result).to include(/span/).exactly(12).times
      end
    end
  end
end
