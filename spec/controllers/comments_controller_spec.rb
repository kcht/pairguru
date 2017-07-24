require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  describe "when adding a comment" do
    subject(:create_comment) do
      post :create, params: { comment: {
        title: comment[:title],
        content: comment[:content],
        movie_id: comment[:movie_id],
        user_id: comment[:user_id]
      }, movie_id: movie.id }
    end

    let(:comment) { { title: "xxx", content: "yyyyyyyyy", movie_id: movie.id, user_id: 1 } }
    context "when the user is logged in" do
      let(:user) { FactoryGirl.create(:user, id: 1) }
      before(:each) do
        sign_in user
      end

      let(:movie) { FactoryGirl.create(:movie) }

      context "when this is the first comment for the movie" do
        it "comment is created" do
          expect { create_comment }.to change{ Comment.count }.from(0).to(1)
        end
      end

      context "when this movie already has comments" do
        let(:movie) { FactoryGirl.create(:movie) }

        context "when user comments for the first time" do
          before do
            FactoryGirl.create(:comment, movie_id: movie.id, user_id: 2, title: "existing")
          end

          it "comment is created" do
            expect { create_comment }.to change { Comment.count }.from(1).to(2)
          end
        end

        context "when user comments for the second time" do
          before do
            FactoryGirl.create(:comment, movie_id: movie.id, user_id: 1, title: "existing")
          end

          it "comment is updated" do
            expect { create_comment }.not_to change { Comment.count }
            expect(Comment.find_by(movie_id: movie.id, user_id: 1).title).to eq("existing")
          end
        end
      end
    end
  end
end
