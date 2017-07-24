require "rails_helper"

RSpec.describe Comment, type: :model do
  let(:extremely_long) do
    Faker::Lorem.sentence(1200, true)
  end

  it { is_expected.to allow_value("valid content :)").for(:content) }
  it { is_expected.not_to allow_value(nil).for(:content) }
  it { is_expected.not_to allow_value("").for(:content) }
  it { is_expected.not_to allow_value("ok").for(:content) }
  it { is_expected.not_to allow_value(extremely_long).for(:content) }

  it { is_expected.to allow_value("valid title :)").for(:title) }
  it { is_expected.not_to allow_value(nil).for(:title) }
  it { is_expected.not_to allow_value("").for(:title) }
  it { is_expected.to allow_value("ok").for(:title) }
  it { is_expected.not_to allow_value(extremely_long).for(:title) }
end
