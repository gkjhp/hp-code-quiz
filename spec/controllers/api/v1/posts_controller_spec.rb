require "rails_helper"

RSpec.describe Api::V1::PostsController do
  let(:author) { create(:user) }
  let(:respondent) { create(:user) }
  let!(:thread) { create(:post, user: author, created_at: 2.days.ago) }
  let!(:post1) { create(:post, user: respondent, parent: thread, created_at: 15.minutes.ago)}
  let!(:post2) { create(:post, user: author, parent: thread, created_at: 5.minutes.ago)}
  let!(:new_thread) { create(:post, user: respondent) }

  describe "GET #index" do
    before do
      get :index
    end

    it "gets the threads" do
      parsed = JSON.parse(response.body)
      expect(parsed.first['replies'].first['post']['content']).to eq post1.content
      expect(parsed.first['replies'].first['author']['id']).to eq respondent.id
      expect(parsed.last['post']['content']).to eq new_thread.content
      expect(parsed.last['author']['id']).to eq respondent.id
    end
  end
end
