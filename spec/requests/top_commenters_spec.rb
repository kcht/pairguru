require "rails_helper"

describe "Top commenters requests", type: :request do
  describe "movies list" do
    subject { visit "/top_commenters" }

    context "when there are some comments in last 7 days" do
      context "for less than 10 users" do
        let!(:user1) { FactoryGirl.create(:user, :with_comments, comment_count: 5) }
        let!(:user2) { FactoryGirl.create(:user, :with_comments, comment_count: 2) }
        let!(:user3) { FactoryGirl.create(:user, :with_comments, comment_count: 3) }

        it "displays right title" do
          subject
          expect(page).to have_selector("h1", text: "Top commenters from last 7 days")
        end

        it "displays right number of results" do
          subject
          expect(page).to have_selector("tr", count: 3)
        end

        it "contains required results" do
          subject
          expect(page).to have_selector("td", text: user1.email)
          expect(page).to have_selector("td", text: user2.email)
          expect(page).to have_selector("td", text: user3.email)
        end
      end

      context "for more than 10 users" do
        let!(:user_without_comments) { FactoryGirl.create(:user, email: "no@comment.pl") }

        before do
          10.times do
            FactoryGirl.create(:user, :with_comments, comment_count: 1)
          end
        end

        it "displays right number of results" do
          subject
          expect(page).to have_selector("tr", count: 10)
        end

        it "contains only required results" do
          subject
          expect(page).not_to have_selector("td", text: "no@comment.pl")
        end
      end
    end

    context "when no comments in last 7 days" do
      it "displays right title" do
        subject
        expect(page).to have_selector("h1", text: "No comments in last 7 days")
      end
    end
  end
end
