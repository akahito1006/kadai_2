class BooksController < ApplicationController
  def books
    @books = Book.all
  end
  
  def new
    @book = Book.new
  end
  
  def create
    # データ新規登録するためのインスタンス作成
    book = Book.new(book_params)
    ## データをデータベースに保存するためのsaveメソッド実行
    book.save
    # # books画面へリダイレクトする
    redirect_to booklist_path(book.id)
  end
  
  def show
    @book = Book.find(params[:id])
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    book = Book.find(params[:id])
    book.update(book_params)
    redirect_to booklist_path(book.id)
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  
  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
    # １．エラー解決　require(:book)を削除 なんで？空だから？
    # ２．編集できない不具合　require(:book)を復元　なんで？patchルートだから？
  end
  
end
