require 'rails_helper'

RSpec.describe ContentCast, type: :model do
  describe 'Associações' do
    it { should belong_to(:content) }
    it { should belong_to(:cast) }
  end
end
