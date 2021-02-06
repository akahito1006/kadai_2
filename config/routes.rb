Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'books#top'
  # 嘘でもルートがきちんとした文法で書かれていないとbashもちゃんと動かなかった　controllerを削除することもできない
  get 'top' => 'books#top'
  
  get 'books' => 'books#books'

  post 'book' => 'books#create'

  # url for form_with on books.html
  # get 'booklists' => 'books#books'

  get '/book.:id' => 'books#show', as: 'booklists'
  # as: booklist"S" is already used on form_with and rails will be aborted,
  # or just booklist will now work fine
  get '/books/:id/edit' => 'books#edit', as: 'edit_book'

  patch '/:id' => 'books#update', as: 'update_booklist'

  delete '/book.:id' => 'books#destroy', as: 'destroy_booklist'
# failure 1 expected url /book.1
end
