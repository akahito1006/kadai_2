class BooksController < ApplicationController
  def top
  end
  
  def books
    @books = Book.all
    @book = Book.new
    # booksｱｸｼｮﾝにnewを統合、books ルートで一覧取得と空のモデルの両方が必要のため
    # そうしないと空のモデルの代入が行われず、createｱｸｼｮﾝによってparamsで:idにbookが代入されてしまい
    # ActionController::ParameterMissing　が出る
  end

  # def new
  #   @book = Book.new
  # end
  # newアクションがどこにもルーティングされていなかった
  # ActionController::ParameterMissing　が出た原因となった
  # 新規投稿のform_withでは、ページがロードされた時にまず最初にcreateとは別で空のモデルが入っていなければいけない
  
  def create
    # データ新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    # _error_messages.html.erbに引数を渡すため、ローカルでなくインスタンス引数@として定義する
    ## データをデータベースに保存するためのsaveメソッド実行
    if @book.save
    # このアクション内では@bookを使っていく、ということ
    # # books画面へリダイレクトする、サクセスメッセージを表示させる
      redirect_to booklists_path(@book.id), notice: 'Book was successfully created.'
    else
      @books = Book.all
      # 一覧表示のための引
      render 'books'
    end
  end
  
  def show
    @book = Book.find(params[:id])
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to booklists_path(@book.id), notice: 'Book was successfully updated.'
    else
      render 'edit'
    end 
  end
  
  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      redirect_to books_path, notice: 'Book was successfully destroyed.'
    else
      render 'books'
    end
  end
  
  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
    
    # １．エラー解決　require(:book)を削除 なんで？空だから？
    # ２．編集できない不具合　require(:book)を復元　なんで？patchルートだから？
    # ３．requireがあると新規投稿ができない、ないと編集ができない　？？？
    # ４．
  end
  
end
