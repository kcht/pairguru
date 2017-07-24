require "rails_helper"

RSpec.describe User do
  subject(:top_commenters) { described_class.top_commenters_from_last_week }
  context "when no comments in last 7 days" do
    before do
      3.times do
        FactoryGirl.create(:comment, updated_at: 7.days.ago, user_id: 1)
      end
      FactoryGirl.create(:user, id: 1)
    end
    it "top commenters is empty" do
      expect(top_commenters).to be_empty
    end
  end

  context "when multiple comments" do
    let!(:user1) { FactoryGirl.create(:user, :with_comments, comment_count: 4, id: 1) }
    let!(:user2) { FactoryGirl.create(:user, :with_comments, comment_count: 3, id: 2) }
    let!(:user3) { FactoryGirl.create(:user, :with_comments, comment_count: 2, id: 3) }

    before do
      (4..11).each do |user_id|
        FactoryGirl.create(:user, :with_comments, comment_count: 1, id: user_id)
      end
    end

    it "returns 10 results" do
      result = top_commenters
      expect(result).not_to be_empty
      expect(result.size).to eq( {1=>4, 2=>3, 3=>2, 4=>1, 5=>1, 6=>1, 7=>1, 8=>1, 9=>1, 10=>1})
    end

    it "first result is as expected" do
      result = top_commenters
      expect(result.first.id).to eq(1)
      expect(result.first.count).to eq(4)
    end
  end
end
