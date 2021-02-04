Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'books#top'
  get 'top' => 'books#top'
  
  get 'books' => 'books#books'
  
  post '/:id' => 'books#create'
  # url for form_with on books.html
  get 'booklists' => 'books#books'
  
  get '/:id' => 'books#show', as: 'booklist'
  # as: booklist"S" is already used on form_with and rails will be aborted,
  # or just booklist will now work fine
  get '/:id/edit' => 'books#edit', as: 'edit_booklist'

  patch '/:id' => 'books#update', as: 'update_booklist'
  
  delete '/:id' => 'books#destroy', as: 'destroy_booklist'
end
