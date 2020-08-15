require "rails_helper"

describe "新規登録" do 
  let(:params_hash) { attributes_for(:user) } 
  
  
  example "投稿一覧にリダイレクトする" do 
    post users_url, params: { user: params_hash } 
    expect(response).to redirect_to(articles_url)
  end
  
  example "例外(ActionController::ParameterMissing)になる" do 
    expect { post users_path }.to raise_error(ActionController::ParameterMissing)
  end
  
end

describe "更新" do 
  
  before do 
    post session_url,
      params: {
        login_form: {
          email: user.email,
          password: "abcdef" 
        }
      }
  end
  
  let(:user) { create(:user) } 
  let(:params_hash) { attributes_for(:user) } 
  
  example "usernameの変更" do 
    params_hash.merge!(username: "ねこ次郎")
    patch account_url(user),
      params: { user: params_hash }
    user.reload
    expect(user.username).to eq("ねこ次郎")
  
  end
end

