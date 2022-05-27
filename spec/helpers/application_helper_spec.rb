require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "full_title" do
    it "exist full_title" do
      expect(helper.full_title('Solidus T-Shirt')).to eq('Solidus T-Shirt - BIGBAG Store')
    end

    it "is full_title blank" do
      expect(helper.full_title('')).to eq('BIGBAG Store')
    end

    it "is full_title nil" do
      expect(helper.full_title(nil)).to eq('BIGBAG Store')
    end
  end
end
