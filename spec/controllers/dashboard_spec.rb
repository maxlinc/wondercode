require 'spec_helper'

describe DashboardController do

  context 'unauthenticated' do
    describe "GET 'index'" do
      it "should be successful" do
        get 'index'
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context 'authenticated do' do
    describe "GET 'index'" do
      it "should be successful" do
        @user = FactoryGirl.create(:user)
        sign_in @user
        get 'index'
        expect(response).to render_template('dashboard/index')
      end
    end
  end
end