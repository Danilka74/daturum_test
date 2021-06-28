require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'creation' do
    it 'can be created' do
      user = create(:user)

      expect(User.count).to eq 1
    end
  end
end
