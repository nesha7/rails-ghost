require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    # Add associations when they exist
  end

  describe 'validations' do
    subject { build(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:user)).to be_valid
    end

    it 'has a valid admin factory' do
      expect(build(:user, :admin)).to be_valid
    end
  end

  describe '#admin?' do
    context 'when user role is admin' do
      let(:user) { create(:user, role: 'admin') }

      it 'returns true' do
        expect(user.admin?).to be true
      end
    end

    context 'when user role is not admin' do
      let(:user) { create(:user, role: 'user') }

      it 'returns false' do
        expect(user.admin?).to be false
      end
    end

    context 'when user role is nil' do
      let(:user) { create(:user, role: nil) }

      it 'returns false' do
        expect(user.admin?).to be false
      end
    end
  end

  describe 'devise modules' do
    it 'includes database_authenticatable' do
      expect(User.devise_modules).to include(:database_authenticatable)
    end

    it 'includes registerable' do
      expect(User.devise_modules).to include(:registerable)
    end

    it 'includes recoverable' do
      expect(User.devise_modules).to include(:recoverable)
    end

    it 'includes rememberable' do
      expect(User.devise_modules).to include(:rememberable)
    end

    it 'includes validatable' do
      expect(User.devise_modules).to include(:validatable)
    end
  end
end
