require "rails_helper"

RSpec.describe CommentsHelper, type: :helper do
  describe "#formatted_comments_datetime" do
    subject(:formatted_date_time) { helper.formatted_comment_datetime(date) }

    context "when date is nil" do
      let(:date) { nil }

      it { is_expected.to be nil }
    end

    context "with valid date" do
      let(:date) { "Sun, 23 Jul 2017 15:31:49 UTC +00:00".to_datetime }
      let(:expected_result) { "23 July 2017 at 15:31" }
      it { expect(formatted_date_time).to eq(expected_result) }
    end
  end

  describe "#current_user_comment" do
    subject(:current_user_comment) do
      helper.current_user_comment(movie)
    end

    before do
      allow(helper).to receive(:current_user).and_return current_user
    end

    let!(:movie) { FactoryGirl.create(:movie) }
    let!(:comment) { FactoryGirl.create(:comment, movie_id: movie.id, user_id: 20) }

    context "when user has not commented on this movie" do
      let(:current_user) { FactoryGirl.create(:user, id: 50) }

      it { is_expected.to be nil }
    end

    context "when user has already commented on this movie" do
      let(:current_user) { FactoryGirl.create(:user, id: 20) }

      it { is_expected.to eq(comment) }
    end
  end
end
