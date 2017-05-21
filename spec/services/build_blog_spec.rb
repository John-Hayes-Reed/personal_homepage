require 'rails_helper'

describe BuildBlog, type: :service do
  subject { described_class.call }
  it { is_expected.to be_a Blog }
  it { is_expected.not_to be_persisted }
  it { is_expected.to respond_to :subscriptions }
end