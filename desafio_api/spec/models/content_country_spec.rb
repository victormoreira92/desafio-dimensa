require 'rails_helper'

RSpec.describe ContentCountry, type: :model do
  describe 'Associações' do
    it { should belong_to(:content) }
    it { should belong_to(:country) }
  end
end
