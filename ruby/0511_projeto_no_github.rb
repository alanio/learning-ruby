# no routes.rb

#criando requisicao
resources :categories

#definindo a home
root 'pages#home' #erro pq nao tem controller pages

=begin  nos controllers  =end

#trocar adaptador de BD -> config->daf.ymlj