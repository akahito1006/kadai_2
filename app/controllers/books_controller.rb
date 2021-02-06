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
    ## データをデータベースに保存するためのsaveメソッド実行
    if @book.save
    # # books画面へリダイレクトする、サクセスメッセージを表示させる
      redirect_to booklist_path(@book.id), notice: 'Book was successfully created.'
    else
      @books = Book.all
      render :books
    end
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
    redirect_to booklist_path(book.id), notice: 'Book was successfully updated.'
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path, notice: 'Book was successfully destroyed.'
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
