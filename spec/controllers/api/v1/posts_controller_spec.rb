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

  describe "POST #create" do
    let(:params) { { content: 'sassy talk', parent_id: nil } }

    before do
      allow(controller).to receive_messages current_api_user: author
    end

    it "makes a new post by default" do
      expect { post :create, params: params }.to change { Post.count }.by(1)
    end

    context "making a response" do
      let(:params) { { content: "You couldn't be more wrong", parent_id: thread.id } }

      it "adds to the thread" do
        expect { post :create, params: params }.to change { Post.count }.by(1)
        expect(thread.responses.last.content).to eq params[:content]
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      allow(controller).to receive_messages current_api_user: author
    end

    it "archives a post if you own it" do
      expect { delete :destroy, params: { id: post2.id } }.to change { post2.reload.archived_at }
    end

    it "will not archive posts you don't own" do
      expect { delete :destroy, params: { id: post1.id } }.not_to change { post1.reload.archived_at }
    end
  end
end
