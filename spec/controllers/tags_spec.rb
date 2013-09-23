require 'spec_helper'

describe TagsController do

  # describe "show/rails" do #=>
  #   it "should render the projects for a tag" do
  #     get :show, id: 'rails'

  #     tags = Tags.where(name: 'rails')

  #     assigns[:repos].should include(['rails/rails', 'ruby-samples/rails', 'trains/rails'])
  #     response.should be_successful
  #     expect(response).to render_template('tags/show')
  #   end
  # end

  describe 'show/rubyguy/faker' do
    it "should render the projects for a tag containing a full name of a repository" do
      right_tag = FactoryGirl.create(:github_repo_tag, name: 'rubyguy::faker')
      right_tag.repositories << FactoryGirl.create(:repo)
      right_tag.save

      get :show, user: 'rubyguy', repo: 'faker'

      assigns[:tag].should == right_tag
      assigns[:repos].first.tags.should include(right_tag)

      response.should be_successful
      expect(response).to render_template('tags/show')
    end
  end

end