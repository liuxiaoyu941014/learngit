class ArticlesController < ApplicationController
    http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]
    def index
        @articles = Article.all
      end
    def show
        @article = Article.find(params[:id])

        # user = User.new do |u|
        # u.name = "David"
        # u.occupation = "Code Artist"
        # end
        @user =Article.new
        @user.title = "David3"
        @user.text = "Code Artist11"
        @user.save
    end
    def new 
        @article = Article.new

    # user = Article.new do |u|
    # u.title = "David5"
    # u.text = "Code Artist"
    end
   
    def edit
        @article = Article.find(params[:id])
        # article =Article.find_by() 
    end

  
    def create
        @article = Article.new(article_params)
        # binding.pry
        # user = Article.new do |u|
        #   u.title = "David5"
        #   u.text = "Code Artist"
       
        if @article.save
          redirect_to @article
        else
          render 'new'
        end
      end

      def update
        @article = Article.find(params[:id])
       
        if @article.update(article_params)
          redirect_to @article
        else
          render 'edit'
        end
      end
      
   def destroy
    @article = Article.find(params[:id])
    @article.destroy
   
    redirect_to articles_path
  end
   
  private
    def article_params
      params.require(:article).permit(:title, :text)
    end
end
