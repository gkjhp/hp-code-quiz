require "rails_helper"

RSpec.describe Post, type: :model do
  let(:author) { create(:user) }
  let(:respondent) { create(:user) }
  let(:thread) { create(:post, user: author, created_at: 2.days.ago) }
  let(:post1) { create(:post, user: respondent, parent: thread, created_at: 15.minutes.ago)}
  let(:post2) { create(:post, user: author, parent: thread, created_at: 5.minutes.ago)}
  let(:new_thread) { create(:post, user: respondent) }

  it "has responses" do
    expect(thread.responses).not_to include thread
    expect(thread.responses).not_to include new_thread
  end

  it "can archive" do
    expect { thread.archive! }.to change { thread.archived_at }
    thread.reload
    expect(thread.archived_at).to be > 1.second.ago
  end

  it "can't get reassigned to a new thread: controller's problem"
end
