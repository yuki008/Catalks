require "rails_helper"

describe Authenticator do 
  describe "#authenticate" do 
    example "passwordが正しい場合、trueを返す" do 
      u = build(:user)
      expect(Authenticator.new(u).authenticate("abcdef")).to be_truthy 
    end
    
    example "passwordが間違っていた場合、falseを返す" do 
      u = build(:user)
      expect(Authenticator.new(u).authenticate("dog")).to be_falsey 
    end
    
    example "userが停止状態の場合でもtrueを返す" do 
      u = build(:user, suspended: true)
      expect(Authenticator.new(u).authenticate("abcdef")).to be_truthy
    end
  end
end