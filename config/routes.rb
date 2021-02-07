Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'books#top'
  # 嘘でもルートがきちんとした文法で書かれていないとbashもちゃんと動かなかった　controllerを削除することもできない
  get 'top' => 'books#top'
  
  get '/books' => 'books#index'

  post '/books' => 'books#create'

  # url for form_with on books.html
  # get 'booklists' => 'books#books'

  get '/books/:id' => 'books#show', as: 'book'

  get '/books/:id/edit' => 'books#edit', as: 'edit_book'

  patch '/:id' => 'books#update', as: 'update_book'

  delete '/books/:id' => 'books#destroy', as: 'destroy_book'
# failure 1 expected url /book.1
end
