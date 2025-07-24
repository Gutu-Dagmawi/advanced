require 'rails_helper'

RSpec.describe User do
  context 'when invalid or incomplete arguments are given' do
    it 'is invalid if email is not supplied' do
      user = User.new(password: "password123")
      expect(user).to_not be_valid
    end
    it 'is invalid if password is not given' do
      user = User.new(email: "test@bitscollege.edu.et")
      expect(user).to_not be_valid
    end
    it 'is invalid if email is not unique' do
      user1 = User.create!(email: "test@bitscollege.edu.et", password: "password123")
      user2 = User.new(email: "test@bitscollege.edu.et", password: "password123")
      expect(user2).to_not be_valid
    end
    it 'is invalid if password length is less than 6' do
      user = User.new(email: "test@bitscollege.edu.et", password: "short")
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it 'is invalid if email is given in the wrong format' do
      user = User.new(email: "@boom.123", password: "password123")
      expect(user).to_not be_valid
    end
  end
end
