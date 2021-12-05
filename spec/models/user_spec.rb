require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user, email: 'dringledrang@dev.test') }

  it "works with gravatar" do
    expect(user.gravatar_url).to eq 'https://www.gravatar.com/avatar/5c2b43e9871c1b95af3a13af8f0eb76f'
  end
end
