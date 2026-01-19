require 'rails_helper'

RSpec.describe Script, type: :model do
  describe 'associations' do
    # Add associations when they exist
  end

  describe 'validations' do
    # Add validations when they exist
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:script)).to be_valid
    end
  end

  describe 'database columns' do
    it { should have_db_column(:key).of_type(:string) }
    it { should have_db_column(:value).of_type(:jsonb) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'jsonb value column' do
    it 'stores hash values correctly' do
      script = create(:script, value: { 'foo' => 'bar', 'nested' => { 'key' => 'value' } })
      expect(script.value).to eq({ 'foo' => 'bar', 'nested' => { 'key' => 'value' } })
    end

    it 'defaults to an empty hash' do
      script = Script.create!(key: 'test-key')
      expect(script.value).to eq({})
    end

    it 'can store complex data structures' do
      complex_value = {
        'scripts' => ['script1.js', 'script2.js'],
        'config' => {
          'enabled' => true,
          'timeout' => 5000
        }
      }
      script = create(:script, value: complex_value)
      expect(script.reload.value).to eq(complex_value)
    end
  end
end
