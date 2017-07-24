require "rails_helper"

describe "Movies requests", type: :request do
  describe "movies list" do
    it "displays right title" do
      visit "/movies"
      expect(page).to have_selector("h1", text: "Movies")
    end
  end

  describe "comments list" do
    subject {visit "/movies/#{movie.id}"}

    let(:movie) {FactoryGirl.create(:movie, :with_comments, comment_count: 5)}

    it "displays right title" do
      subject
      expect(page).to have_selector("h1", text: movie.title)
    end

    context "when movie doesn't have comments" do
      let!(:movie) {FactoryGirl.create(:movie)}

      it "displays right header for comment section" do
        subject
        expect(page).to have_selector("h3", text: "There are no comments for this movie yet...")
      end
    end

    context "when movie has comments" do
      it "displays right header for comment section" do
        subject
        expect(page).to have_selector("h3", text: "Comments for this movie")
      end
    end
  end
end
