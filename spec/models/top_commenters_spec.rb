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

  # context 'test movies with comments' do
  #   let!(:movie) { FactoryGirl.create(:movie, :with_comments, comments_count: 2)}
  # end

  context "when multiple comments" do
    before do
      (1..10).each do |user_id|
        FactoryGirl.create(:user, id: user_id)
        if user_id == 1
          3.times do
            FactoryGirl.create(:comment, user_id: user_id)
          end
        elsif user_id == 2
          3.times do
            FactoryGirl.create(:comment, user_id: user_id)
          end
        else
          FactoryGirl.create(:comment, user_id: user_id)
        end
      end
    end

    it "returns 10 results" do
      result = top_commenters
      expect(result).not_to be_empty
      expect(result.size).to eq( {1=>3, 2=>3, 3=>1, 4=>1, 5=>1, 6=>1, 7=>1, 8=>1, 9=>1, 10=>1})
    end

    it "first result is as expected" do
      result = top_commenters
      expect(result.first.id).to eq(1)
      expect(result.first.count).to eq(3)
    end
  end
end
