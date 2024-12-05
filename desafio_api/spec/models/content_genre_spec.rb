require 'rails_helper'

RSpec.describe ContentGenre, type: :model do
  describe 'Associações' do
    it { should belong_to(:content) }
    it { should belong_to(:genre) }
  end
end
