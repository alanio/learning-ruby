=begin
	REVISANDO A CRIAÇÃO DE UM PROJETO RAILS COMO TODO NA VERSAO 4.2.6
	REVISANDO RELACIONAMENTOS, GEM FFAKER
	PAGINANDO COM KAMINARI
	LAYOUT DA PAGINAÇÃO DO KAMINARI COM BOOTSTRAP
=end



#criar projeto definindo a versão do rails e o banco
rails _4.2.6_ new portal -d mysql

=begin
	#gambiara pra não precisar de internet: copiar esses arquivos de um projeto existente
	copiar gemfile do ruby_store
	copiar GemFile.lock do ruby_store
=end

#rodar bundle
bundle install

#bd
host: 127.0.0.1 #no mac, ou < host: localhost > no linux
rake db:create #criar banco
rake db:migrate #atualizar banco    obs: probleminha no simple_form

#bootstrap
# dica do terinal: comando para procurar ultimos comandos no terminal
	history | grep install #nesse caso, procurando ultimos comandos digitados com o termo 'install'

#setar bootstrap com less 
rails g bootstrap:install less

#simple_form padrao bootstrap
rails g simple_form:install --bootstrap

#gerar layout básico com o bootstrap
rails g bootstrap:layout application

#deixar em portugues
	config>initializers>inflections.rb # ver na internet inflections pt br

#criar rota no routes.rb
root 'paginas#principal'

#cria controller, nesse caso com a action principal
rails g controller paginas principal

#criar model usuario
rails g scaffold usuarios nome email senha genero:integer #ja cria o resources e controller

#eliminar arquivo scaffold.scss em 
	app/assets/stylesheets/

#atualiza banco
rake db:migrate

#cria layout para resources usuarios
rails g bootstrap:themed usuarios

#baixar pasta lib do projeto https://github.com/seyhunak/twitter-bootstrap-rails
#e jogar dentro da lib do projeto para poder editar o simple_form_for e não precisar
#apagar erros span e alterar as classes do simple_form
#se nao, apagar erros span do _form.html.erb; mudar pra 'form-vertical'; colocar inputs numa <div class 'form-actions'>, e o submit em uma <div clas='form-inputs'>

#parar, reiniciar servidor

#criar models editoria
rails g scaffold editorias nome status:boolean

#apagar app/assets/stylesheet/scaffold.scss

#atualiza banco
rake db:migrate

#cria layout para resources editorias
rails g bootstrap:themed editorias

#incluir path no application.html.erb(layout)

#apagar erros span do _form.html.erb, mudar pra 'form-vertical', alterar para <div class form-actions>, form-inputs

#no _form de usuario, definir o tipo de botao do genero fazendo a collection
#collection: [['Mesculino', 1],['Feminino', 0]] prompt 'Selecione'
=begin
	 <%= f.input :genero, as: :radio_buttons, collection: [['Masculino', 1], ['Feminino', 0]] %>
=end


#criar model marcador
rails g scaffold marcadores nome

#apagar app/assets/stylesheet/scaffold.scss

#atualiza banco
rake db:migrate

#cria layout para resources marcadores
rails g bootstrap:themed marcadores

#incluir path no menu do application.html.erb(layout)
#substituir link_to por menu_item
=begin
	<li><%= menu_item "Markers", markers_path  %></li>
=end

#apagar erros span do _form.html.erb, mudar pra vertical, alterar para <div class form-actions>, form-inputs

#criar models noticias, primeiro campos sao os relacionamentos, usuario (no singular) :belongs_to (ou) :references
rails g scaffold noticias usuario:belongs_to editoria:references titulo subtitulo conteudo:text data_publicacao:datetime imagem status:boolean

#apagar app/assets/stylesheet/scaffold.scss

#atualiza banco
rake db:migrate

#cria layout para resources marcadores
rails g bootstrap:themed noticias

#incluir path de noticias (noticias_path [na duvida, roda <rake routes> pra saber ver os path's] no application.html.erb(layout)
	substituir link_to por menu_item

#apagar erros span do _form.html.erb, mudar pra vertical, alterar para <div class form-actions>, form-inputs

#substituir tipo do botao de staus no _form de posts
=begin
	<%= f.input :status, as: :radio_buttons, collection: [['Enabled', true],['Disabled',false]] %>
=end


### RELACIONAMENTOS
#no _form de noticias
=begin
	<%= f.input :usuario_id, as: :select, collection: Usuario.all.map{|u| [u.nome, u.id] }, prompt: 'Selecione usuário' %>
=end


#adicionar campo email ()
=begin
	<%= f.input :usuario_id, as: :select, collection: Usuario.all.map{|u| ["#{u.nome} - {u.email}", u.id] }, prompt: 'Selecione usuário'
=end


#no model user.rb, adicionar/indicar relacionamento
has_many :posts

#agora, no _form.html.erb de noticias, o relacionamento nao sera mais com f.input
=begin
	<%= f.association :usuario, as: :select, collection: Usuario.all.map{|u| ["#{u.nome} - {u.email}", u.id] }, prompt: 'Selecione usuário'
=end


#na view show de posts, pegar nome em vez de id
=begin
	<dd><%= @post.user.name  %></dd>
=end

#na view index de post, retirar campos de conteudo, subtitulo, imagem para deixar mais limpo
#na view show de post, validar usuario e editoria
=begin
	<%= @noticias.usuario.nome if @noticia.usuario.present? %>
	<%= @noticias.editoria.nome if @noticia.editoria.present? %>
=end

#ou
=begin
	<%= @noticia.usuario.try(:nome) %>
	<%= @noticia.editoria.try(:nome) %>
=end

#mais indicado (correto), validar no model noticia.rb
validates :usuario_id, :editoria_id, presence: true

#no rails 3
validates_presence_of :usuario_id, :editoria_id

#usar ffaker
#adicionar no gemfile: 'ffaker'
bundle install

#no seeds.rb
Usuario.create(
	nome: 'sadsa',
	email: 'asdda',
	senha: 'sadsa',
	genero: 'sadas'
)

#rodar o seeds.rb pra popular o banco
rake db:seed

#agora, popular através do seeds.rb usando ffaker
#no seeds.rb:
require 'ffaker'
100.times.do 
	Usuario.create(
		nome: FFaker::NameBR.name,
		email: FFaker::Internet.email,
		senha: 'sadsaasa',
		genero: [0, 1].shuffle.
	)
end

#fazer paginação com a gem kaminari
#adiciona no gemfile: 'kaminari'
#parar servidor e rodar:
bundle install

#reiniciar servidor

#na action index do controller de usuarios
@usuarios = Usuario.page(params[:page]).per(5)

#na view index de usuarios, no fim do arquivo para ficar abaixo dos registros em uma <div class="text-center">
=begin
	<%= paginate @usuarios %>
=end


#indicar quantidade de objetos exibidos, e o total. Ex. Exibindo 87 de 90
=begin
	<%= page_entries_info @usuarios %> 
=end


#acrescentar layout na paginacao com bootstrap

rails g kaminari:views dafault

rails g kaminari:views bootstrap3

#agora nao precisa usar o per(5) no controller

# pra configurar o numero de registros exibidos, gerar arquivo de configuracao do kaminari
rails g kaminari:config

#e mudar o padrão de exibição de 25 objetos do kaminari -> config/initializers/kaminari_config.rb
#restart no seridor


#selecionando usuarios na view _form de notcias
#antes de configurar relacioamento, usando f.input
=begin
	<%= f.input :usuario_id, as: :select, collection: Usuario.all.map{|e| [e.nome, e.id] }, prompt: 'Selecione usuario' %>
=end

#depois de configurar relacioamento usando f.association :usuario
=begin
	<%= f.association :usuario, as: :select, collection: Usuario.all.map{|e| [e.nome, e.id] }, prompt: 'Selecione usuario' %>
=end

#alterar para ordenar lista de usuarios no _form.html.erb de noticias exibindo email na selecao
#antes de configurar relacioamento usando f.input
=begin
	<%= f.input :usuario_id, as: :select, collection: Usuario.all.order(name: :asc).map{|u| ["#{u.nome} - {u.email}", u.id] }, prompt: 'Selecione usuario'
=end

#depois de configurar relacioamento f.association
=begin
	<%= f.association :usuario, as: :select, collection: Usuario.all.order(name: :asc).map{|e| [e.nome, e.id] }, prompt: 'Selecione usuario' %>
=end

#fazer relacionamento noticias e marcadores com base nas tabelas ja existentes
rails g migration create_marcadores_noticias marcador:belongs_to noticia:belongs_to

#atualiza bd
rake db:migrate

#no seeds.rb

require 'ffaker'
100.times do 
	Usuario.create(
		nome: FFaker::NameBR.name,
		email: FFaker::Internet.email,
		senha: 'sadsaasa',
		genero: [0, 1].shuffle.first
	)
end

editorias = Editoria.create!([
	{nome: 'Politica'},
	{nome: 'Economia'}
])

marcadores = Marcador.create!([
	{nome: 'Crise tal'},
	{nome: 'skjbcsd'}

])

10.times do |i|
	Noticias.create!(
		usuario_id: Usuario.all.shuffle.first.id, #ou usuario_id: Usuario.all.order('RAND()').first.id,
		usuario_id: Usuario.all.order('RAND()').first.id,
		editoria_id: Editoria.all.order('RAND()').first,
		titulo: "Titulo #{i}",
		subtitulo: "subTitulo #{i}",
		conteudo: "lorem ipsum",
		data_publicaco: Time.now,
		status: true
	)
end

#o comando rake db:seed popula o banco e se rodado de novo
#apenas inclui no banco o que estiver no seeds.rb que não estiver no banco, não reseta

#pra resetar o banco populado
rake db:reset #apaga o banco, recria, e roda o seeds.rb


#### relacionamento muitos pra muitos em marcadores e noticia
	#no model noticia.rb
	has_and_belongs_to_many :marcadores

	#model marcadores.rb
	has_and_belongs_to_many :noticias

#no _form.html.erb de noticias exibir marcadores no form
=begin
	<%= f.association :marcadores, as: :check_boxes, collection: Marcador.all.order(nome: :asc).map {|m| [m.nome, m.id]} %>
=end


#atera pra fazer collection no _form.html.erb de noticias
f.association :marcadores, as: :check_boxes, collection: Marcador.all.order(nome: :asc).map{|m| [m.nome, m.id]}, prompt "selecione marcador"

#problema, check box nao esta salvando
#no strong parameters(params) no controller, adicionar {:marcador_ids => []}


