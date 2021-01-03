require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe 'attributes' do
    it 'has a name and username' do
      guest = Guest.new
      expect(guest.name).to eq('guest_user')
      expect(guest.username).to eq('guest_username')
    end

    it 'has no food restrictions' do
      guest = Guest.new
      expect((guest.restriction_list).length).to eq(0)
      expect(guest.restriction_list).to eq([])
    end
  end
end
