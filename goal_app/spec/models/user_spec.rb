# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User do
  describe 'password encryption' do
    it 'does not save passwords to the database' do
      User.create!(username: 'Josh', password: 'asdfghjk')
      user = User.find_by_username('Josh')
      expect(user.password).not_to be('abcdef')
    end
  
    it 'encrypts the password using BCrypt' do
      expect(BCrypt::Password).to receive(:create)
      User.new(username: 'Josh', password: 'asdfghjk')
    end
  end
  
  describe 'session token' do 
    it 'assigns a session_token if one is not given' do
      josh = User.create(username: 'Josh', password: 'asdfgjk')
    end  
  end
  
  describe '::find_by_credentials' do
    it 'checks for users by inputed credentials' do
      josh = User.create(username: 'Josh', password: 'asdfgjk')
      expect(User.find_by_credentials('Josh', 'asdfgjk')).to eq(josh)
    end
  end
  
  it { should validate_length_of(:password).is_at_least(6) }
  it { should validate_presence_of(:username)}
  it { should validate_presence_of(:password_digest) }
  # it { should have_many(:comments).class_name(:Comment) }  
  
end
