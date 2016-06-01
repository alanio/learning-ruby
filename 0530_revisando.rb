=begin
	REVISANDO A CRIAÇÃO DE UM PROJETO RAILS COMO TODO NA VERSAO 4.2.6
	REVISANDO RELACIONAMENTOS, GEM FFAKER
	PAGINANDO COM KAMINARI
	LAYOUT DA PAGINAÇÃO DO KAMINARI COM BOOTSTRAP
=end



#criar projeto definindo a versão e o banco
rails _4.2.6_ new portal -d mysql

=begin
	#gambiara pra não precisar de internet: copiar esses arquivos de um projeto existente
	copiar gemfile do ruby_store
	copiar GemFile.lock do ruby_store
=end

#rodar bundle
bundle install

#bd
host: 127.0.0.1 #no linux, pode ser localhost
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

#eliminar arquivo scaffold.css em 
	app/assets/stylesheets/

#atualiza banco
rake db:migrate

#cria layout para model usuario
rails g bootstrap:themed usuarios

#clonar pasta lib seyhunak no git hube e jogar dentro da lib do projeto

#apagar erros span do _form.html.erb; mudar pra vertical; alterar para; div class form-actions, form-inputs

#criar models editoria
rails g scaffold editorias nome status:boolean

#atualiza banco
rake db:migrate

#cria layout para model editoria
rails g bootstrap:themed editorias

#incluir path no application.html.erb(layout)

#apagar erros span do _form.html.erb, mudar pra vertical, alterar para <div class form-actions>, form-inputs

#//no _form de editoria
#//collection: [[asd, true],[ass. false]] prompt


#criar model marcador
rails g scaffold marcadores nome

#atualiza banco
rake db:migrate

#cria layout para model marcador
rails g bootstrap:themed marcadores

#incluir path no menu do application.html.erb(layout)
	substituir link_to por menu_item

#apagar erros span do _form.html.erb, mudar pra vertical, alterar para <div class form-actions>, form-inputs


#criar models noticias, primeiro campos sao os relacionamentos, usuario (no singular) :belongs_to (ou) :references
rails g scaffold noticias usuario:belongs_to editoria:references titulo subtitulo conteudo:text data_publicacao:datetime imagem status:boolean

#atualiza banco
rake db:migrate

#cria layout para model marcador
rails g bootstrap:themed noticias

#incluir path de noticias (noticias_path [na duvida, roda <rake routes> pra saber ver os path's] no application.html.erb(layout)
	substituir link_to por menu_item

#apagar erros span do _form.html.erb, mudar pra vertical, alterar para <div class form-actions>, form-inputs

#substituir tipo do status 
as: :radio_buttons, collection: [['Publicado',true],['Nao publicado', false]]

#alterar layout do genero app/views/users/_form.html.erb
=begin
	<%= f.input :genero, as: :radio_buttons, collection: [['Masculino',1],['feminino',2]] %>
=end
 

#relacionamentos
=begin
	<%= f.input :usuario_id, as: :select, collection: Usuario.all.map{|u| [u.nome, u.id] }, prompt: 'Selecione usuário'
=end


#adicionar campo email
=begin
	<%= f.input :usuario_id, as: :select, collection: Usuario.all.map{|u| ["#{u.nome} - {u.email}", u.id] }, prompt: 'Selecione usuário'
=end


#no model user.rb, adicionar/indicar relacionamento
has_many :posts

#agora, no _form.html.erb o relacionamento nao sera mais com f.input
=begin
	<%= f.association :usuario, as: :select, collection: Usuario.all.map{|u| ["#{u.nome} - {u.email}", u.id] }, prompt: 'Selecione usuário'
=end


#na view show de posts, pegar nome em vez de id
noticias.usuario.nome

#na view index de post, retirar campos de conteudo, subtitulo, imagem para deixar mais limpo
#na view show, validar usuario e editoria
=begin
	<%=noticias.usuario.nome if noticia.usuario.present? %>
	<%=noticias.editoria.nome if noticia.editoria.present? %>
=end

#ou
=begin
	<%= @noticia.usuario.try(:nome) %>
=end

#mais indicado (correto), validar no model noticia.rb
validates :usuario_id, :editoria_id, presence: true

#no rails 3
validates_presence_of :usuario_id, :editoria_id

#usar ffaker
#adicionar no gemfile: 'ffaker'
#parar servidor e rodar:
bundle install

#reiniciar servidor

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

#na action index do controller
@usuarios = Usuario.page(params[:page]).per(5)

#na view de usuarios
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

#gerar arquivo de configuracao do kaminari
rails g kaminari:config

#se quiser mudar o padrão de exibição de 25objetos do kaminari -> config/initializers/kaminari.rb

#exibir usuários no _form.html.erb da view users
=begin
	<%= f.input :usuario_id, as: :select, collection: Usuario.all.map{|e| [e.nome, e.id] }, prompt: 'Selucione usuario' %>
=end

#ordenar lista de usuarios no _form.html.erb da view users
=begin
	<%= f.input :usuario_id, as: :select, collection: Usuario.all.order('NOME ASC').map{|u| ["#{u.nome} - {u.email}", u.id] }, prompt: 'Selecione usuario'
=end


#fazer relacionamento noticias e marcadores com base nas tabelas ja existentes
rails g migrate create_marcadores_noticias marcador:belongs_to noticia:belongs_to

#atualiza bd
rake db:migrate

#no seeds.rb

require 'ffaker'
100.times.do 
	Usuario.create(
		nome: FFaker::NameBR.name,
		email: FFaker::Internet.email,
		senha: 'sadsaasa',
		genero: [0, 1].shuffle.first
	)
end

editorias = Editoria.create!(
	{nome: 'Politica'},
	{nome: 'Economia'}
)

marcadores = Marcador.create!([
	{nome: 'Crise tal'},
	{nome: 'skjbcsd'}

])

10.times do |i|
	Noticias.create!(
		usuario_id: usu. all.shuffle.first.id, ou
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


#### realcionamento muitos pra muitos em marcadores e noticia
	#no model noticia.rb
	has_and_belongs_to_many: marcadores

	#em marcadores.rb
	has_and_belongs_to_many: noticias

#no _form.html.erb
f.association: marcadores #cria campo select com os marcadores

#faz a collection no _form.html.erb
f.association: marcadores, as: :check_boxes, collection: Marcador.all.order(nome: :asc).map{|m| [m.nome, m.id]}, prompt "selecione marcador"

#problema, check box nao esta salvando
#no strong parameters(params) no controller, adicionar :{:marcador_ids => []}
