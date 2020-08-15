require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#password=" do 
    example "文字列を代入した場合、password_digestの長さが60文字になる" do 
      user = User.new 
      user.password = "catalks"
      expect(user.password_digest).to be_kind_of(String)
      expect(user.password_digest.size).to eq(60)
    end
    example "nilを代入した場合、password_digestはnilとなる" do 
      user = User.new(password_digest: "a")
      user.password = nil 
      expect(user.password_digest).to be_nil 
    end
  end
  
  describe "バリデーション" do 
    example "usernameが11文字なら無効" do 
      user = build(:user, username: "abcdefghijh")
      expect(user).not_to be_valid
    end  
    
    example "他のユーザーのメールアドレスと重複した場合は無効" do 
      user1 = create(:user)
      user2 = build(:user, email: user1.email)
      expect(user2).not_to be_valid
    end 
  end
end
