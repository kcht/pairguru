require 'rails_helper'

RSpec.describe CommentsHelper, type: :helper do
  describe '#formatted_comments_datetime' do
    subject(:formatted_date_time) { helper.formatted_comment_datetime(date) }

    context 'when date is nil' do
      let(:date) {nil}

      it { is_expected.to be nil }
    end

    context 'with valid date' do
      let(:date) { 'Sun, 23 Jul 2017 15:31:49 UTC +00:00'.to_datetime }
      let(:expected_result) {'23 July 2017 at 15:31' }
      it { expect(formatted_date_time).to eq(expected_result) }
    end
  end

end