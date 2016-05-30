#criando campo em uma tabela 
rails generate migration add_column_status_to_categories

#escrever no .md do github
### 1) Titulo Maior
* Subtitulo
'''
	ruby
'''

#scaffold cria o CRUD, 
rails g scaffold Post title content:text status:boolean
#scaffold adiciona posts nas rotas(resourses)
#cria migration

rake db:migrate
#cria a tabela no banco de dados

rake db:seed
#popular banco de dados de acordo com o arquivo seeds.rb