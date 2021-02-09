require 'rails_helper'

RSpec.describe "Users", type: :request do
  # @test_user = FactoryBot.create(:test_user)
  
  describe "proper result" do
    context 'resistration page' do
      it 'successfull resister user' do
        get signup_path
        expect(response).to be_success
        expect(response).to have_http_status '200'
        post users_path, params: { user: FactoryBot.attributes_for(:test_user) }
        follow_redirect!
        expect(response.body).to include "ユーザー登録が完了しました"
      end
    end
    context 'login page' do
      it 'successfully login with valid attirbutes' do
        get login_form_path
        expect(response).to be_success
        expect(response).to have_http_status '200'
        test_user = FactoryBot.build(:test_user)
        test_user.save
        post login_path, params: FactoryBot.attributes_for(:test_login_user)
        follow_redirect!
        expect(response.body).to include "ログインしました"
      end
    end
  end
end
