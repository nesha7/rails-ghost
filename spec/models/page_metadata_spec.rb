require 'rails_helper'

RSpec.describe PageMetadata, type: :model do
  describe 'associations' do
    # Add associations when they exist
  end

  describe 'validations' do
    subject { build(:page_metadata) }

    it { should validate_presence_of(:slug) }
    it { should validate_uniqueness_of(:slug) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:page_metadata)).to be_valid
    end
  end

  describe 'database columns' do
    it { should have_db_column(:slug).of_type(:string) }
    it { should have_db_column(:meta_title).of_type(:string) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'slug uniqueness' do
    let!(:existing_metadata) { create(:page_metadata, slug: 'test-slug') }

    it 'does not allow duplicate slugs' do
      duplicate_metadata = build(:page_metadata, slug: 'test-slug')
      expect(duplicate_metadata).not_to be_valid
      expect(duplicate_metadata.errors[:slug]).to include('has already been taken')
    end
  end

  describe 'slug presence' do
    it 'requires a slug' do
      metadata = build(:page_metadata, slug: nil)
      expect(metadata).not_to be_valid
      expect(metadata.errors[:slug]).to include("can't be blank")
    end
  end
end
