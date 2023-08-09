class BooksController < ApplicationController
  def create
    @lists = Book.all
    # データを受け取り新規登録するためのインスタンス作成
    @list = Book.new(list_params)
    # データをデータベースに保存するためのsaveメソッド実行
    if @list.save
      # フラッシュメッセージを定義し、詳細画面へリダイレクト
      flash[:notice] = "Book was successfully created."
      # 詳細画面へリダイレクト
      redirect_to books_path(@list.id)
    else
      flash[:alert] = "error:Failed to create. Fill in the blanks."
      render :index
      
    end
  end
  
  def destroy
    list = Book.find(params[:id])  # データ（レコード）を1件取得
    list.destroy  # データ（レコード）を削除
    flash[:notice] = "Book was successfully destroyed."
    redirect_to "/books" # 投稿一覧画面へリダイレクト  
  end
  
  def index
    @lists = Book.all
    # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
    @list = Book.new  
  end

  def show
    @list = Book.find(params[:id])  
  end

  def edit
    @list = Book.find(params[:id])
  end
  
  def update
    @list = Book.find(params[:id])
    if @list.update(list_params)
      # フラッシュメッセージを定義し、indexへリダイレクト
       flash[:notice] = "Book was successfully updated."
       redirect_to books_path(@list.id)  
    else
       flash[:alert] = "error:Failed to update. Fill in the blanks."
        render :edit
    end
    
    
  end
  
  private
  # ストロングパラメータ
  def list_params
    params.require(:book).permit(:title, :body)
  end
end

