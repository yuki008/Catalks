require "rails_helper"

describe "自分のアカウント管理", "ログイン前" do 
  let(:args) do 
    {
      host: "b9a7c10dbb604dfb8c432b684abf1653.vfs.cloud9.ap-northeast-1.amazonaws.com",
      controller: "accounts"
    }
  end
  
  describe "#show" do 
    example "ログインフォームへリダイレクトする" do 
      get url_for(args.merge(action: :show))
      expect(response).to redirect_to(sign_in_url)
    end
  end
end

describe "アカウント管理" do 
  before do 
    post session_url,
    params: {
      login_form: {
        email: user.email,
        password: "abcdef"
      }
    }
  end

  describe "情報表示" do 
    let(:user) { create(:user) } 
  
    example "アカウント停止をセットされた場合、強制ログアウトする。" do
      user.update_column(:suspended, true)
      get account_url 
      expect(response).to redirect_to(root_url)
    end
  end
end