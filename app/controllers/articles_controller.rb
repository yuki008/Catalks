class ArticlesController < ApplicationController
  
  layout "sign_in"
  before_action :authorize_user, except: [:index]
  
  def index
    @articles = Article.all 
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new 
  end

  def edit
     @article = Article.find(params[:id])
     if @article.user != current_user
       flash.alert = "不正なアクセスをしています"
       redirect_to :articles 
     end
  end
  
  def create 
    @article = Article.new(article_params)
    @article.user_id = current_user.id 
    if @article.save
      flash.notice = "投稿内容を登録しました。"
      redirect_to (article_path(@article))
    else 
      flash.now.alert = "投稿内容を登録できませんでした。"
      render action: "new"
    end
  end
  
  def update 
    @article = Article.find(params[:id])
    @article.assign_attributes(article_params)
    if @article.save 
      flash.notice = "投稿内容を更新しました。"
      redirect_to @article
    else 
      render action: "edit"
    end
  end
  
  def destroy 
    article = Article.find(params[:id])
    article.destroy!
    flash.notice = "投稿を削除しました。"
    redirect_to :articles
  end
  
  private def authorize_user
    unless current_user
      flash.alert = "ログインしてください。"
      redirect_to :sign_in
    end
  end
  
  private def article_params
    params.require(:article).permit(:title, :body, :image)
  end
end
