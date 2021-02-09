require 'rails_helper'

RSpec.describe User, type: :model do
    let(:new_user) { User.new }
    describe 'resistration' do
        context 'proper result' do
            it 'create user properly' do
                user = FactoryBot.build(:test_user)
                expect(user).to be_valid
                user.save
                saved_user = User.find(1);
                expect(saved_user.name).to eq('test user')
                expect(saved_user.email).to eq('test@test.com')
                expect(saved_user.password).to eq('12345678')
            end
        end
        context 'error result' do
            it 'cannot save data' do
                expect(new_user.save).to be_falsey
            end
            it 'blank in compulsory input' do
                expect(new_user).not_to be_valid
                expect(new_user.errors[:name]).to include(I18n.t('errors.messages.blank'))
                expect(new_user.errors[:email]).to include(I18n.t('errors.messages.blank'))
                expect(new_user.errors[:email]).to include(I18n.t('errors.messages.invalid'))
                expect(new_user.errors[:password]).to include(I18n.t('errors.messages.blank'))
            end
            it 'registered with existed email address' do
                user1 = FactoryBot.create(:test_user)
                user2 = FactoryBot.build(:test_user, name: 'test user2')
                expect(user2).not_to be_valid
                expect(user2.errors[:email]).to include(I18n.t('errors.messages.taken'))
                expect(user2.save).to be_falsey
            end
        end
    end
end
