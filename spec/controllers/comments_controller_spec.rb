require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe 'when adding a comment' do
    subject(:create_comment) do
      post :create, params: { comment: {
          title: comment[:title],
          content: comment[:content],
          movie_id: comment[:movie_id],
          user_id: comment[:user_id]
      }, movie_id: movie.id}
    end

    before do
      # allow_any_instance_of(described_class).to receive(:current_user).and_return ( current_user )
      user = double('user')
      allow(user).to receive(:id) { 1 }
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end
    context 'when the user is not logged in' do

    end

    let(:comment) { {title: 'x', content: 'y', movie_id: movie.id, user_id: 1 } }
    context 'when the user is logged in' do
      let(:movie) { FactoryGirl.create(:movie) }

      context 'when this is the first comment for the movie' do

        it 'comment is created' do
          expect{ create_comment }.to change{Comment.count}.from(0).to(1)
        end
      end

      context 'when this movie already has comments' do
        let(:movie) { FactoryGirl.create(:movie) }


        context 'when user comments for the first time' do
          before do
            FactoryGirl.create(:comment, movie_id: movie.id, user_id: 2)
          end

          it 'comment is created' do
            expect{ create_comment }.to change{Comment.count}.from(1).to(2)
          end
        end
        
        context 'when user comments for the second time' do
          before do
            FactoryGirl.create(:comment, movie_id: movie.id, user_id: 1)
          end

          it 'comment is updated' do
            expect{ create_comment }.not_to change{Comment.count}
            expect(Comment.find_by(movie_id: movie.id, user_id: 1).title).to eq(comment[:title])
          end
        end
      end
    end
  end
end