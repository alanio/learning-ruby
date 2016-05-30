#projeto
rails _4.2.6_ new portal -d mysql

copiar gemfile do ruby_store

copiar GemFile.lock do ruby_store

bundle install

#bd
host: 127.0.0.1
rake db:create
rake db:migrate #erro no simple_form

#bootstrap
history | grep install# ver
rails g bootstrap:install less
rails g simple_form:install --bootstrap

#usar gerador bootstrap
rails g bootstrap:layout application

#deixar em portugues
arquivo config>initializers>inflections.rb# ver na internet inflections pt br

criar rota no routes
root 'paginas#princippal'

#cria controller
rails g controller paginas principal

#criar models
rails g scaffold usuarios nome email senha genero:integer
#ja cria o resources e controller

eliminar arquivo scaffold.css

#atualiza banco
rake db:migrate

rails g bootstrap:themed usuarios

pasta lib, clonar seyhunak:git hub, jogar dentro da lib

apagar erros span do _form.html.erb, mudar pra vertical, alterar para div class form-actions, form-inputs

#criar models editoria
rails g scaffold editorias nome status:boolean

rake db:migrate

rails g bootstrap:themed editorias

incluir path no application.html.erb(layout)

apagar erros span do _form.html.erb, mudar pra vertical, alterar para <div class form-actions>, form-inputs

#
collection: [[asd, true],[ass. false]] prompt


#criar models editoria
rails g scaffold marcadores nome

rake db:migrate

rails g bootstrap:themed marcadores

incluir path no menu do application.html.erb(layout)
	substituir link_to por menu_item

apagar erros span do _form.html.erb, mudar pra vertical, alterar para <div class form-actions>, form-inputs


#criar models noticias, relacionamentos primeiro, usuario no singula:belongs_to ou :references
rails g scaffold noticias usuario:belongs_to editoria:references titulo subtitulo conteudo:text data_publicacao:datetime imagem status:boolean

rake db:migrate

rails g bootstrap:themed noticias

incluir path no application.html.erb(layout)#menu_item

apagar erros span do _form.html.erb, mudar pra vertical, alterar para <div class form-actions>, form-inputs

substituir tipo do status - - as: :radio_buttons, collection: [['Publicado',true],['nao publicado', false]]

#alterar genero
#<%= f.input :genero, as: :radio_buttons, collection: [['Masculino',1],['feminino',2]] %>

#relacionamentos
<%= f.input :usuario_id, as: :select, collection: Usuario.all.map{|u| [u.nome, u.id] }, prompt: 'Selcione suusario'
add email<%= f.input :usuario_id, as: :select, collection: Usuario.all.map{|u| ["#{u.nome} - {u.email}", u.id] }, prompt: 'Selcione suusario'

no model usuario
has_many :noticias

nao e mais f.input
sera :association

#
<%= f.association :usuario, as: :select, collection: Usuario.all.map{|u| ["#{u.nome} - {u.email}", u.id] }, prompt: 'Selcione suusario'

#na view show de noticias, pegar nome em vez de id
noticias.usuario.nome

no index tira conteudo, subtitulo, imagem

no show
validar usuario e editoria
#<%=noticias.usuario.nome if noticia.usuario.present?%>

if noticia.editoria.present?

ou
@noticia.usuario.try(:nome)
@noticia.usuario.try(:nome)

mais correto
#no model
validates :usuario_id, :editoria_id, presence: true

no rails 3
validates_presence_of :usuario_id, :editoria_id

#usar ffaker
adiciona no gemfile 'ffaker'

parar servidor
bundle install

restart server

#no seeds.rb
Usuario.create(
	nome: 'sadsa',
	email: 'asdda',
	senha: 'sadsa',
	genero: 'sadas'
)

rake db:seed

agora usando ffaker

require 'ffaker'
100.times.do 
	Usuario.create(
		nome: FFaker::NameBR.name,
		email: FFaker::Internet.email,
		senha: 'sadsaasa',
		genero: [0, 1].shuffle.
	)
end

barra de rolagem enorme

#usando gem kaminari

adiciona no gemfile 'kaminari'

parar servidor
bundle install

restart server

na action index do controller
	@usuarios = Usuario.page(params[:page]).per(5)

na view de usuarios
#<%= paginate @usuarios %>

#<%= page_entries_info @usuarios %> mostra 87 de 90

paginacao no bootstrap

rails g kaminari:views dafault

rails g kaminari:views bootstrap3

agora nao precisa usar o per()

rails g kaminari:config

ordenar lista de usuarios
#<%= f.input :usuario_id, as: :select, collection: Usuario.all.order('NOME ASC').map{|u| ["#{u.nome} - {u.email}", u.id] }, prompt: 'Selcione suusario'

####
#<%= f.input :usuario_id, as: :select, collection: Usuario.all..map{|e| [e.nome, e.id] }, prompt: 'Selcione usario'

fazer relacionamento noticias e marcadores
so precisa ter as tabelas
rails g migrate create_table_marcadores_noticias marcador:belongs_to noticia:belongs_to

rake db:migrate

no seeds

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

se rodar seed de novo, ele apenas adiciona 

rake db:reset

apaga tudo, roda de novo, e roda seed

realcionamento muitos pra muitos em marcadores e noticia

no model noticia
has_and_belongs_to_many: marcadores

em marcadores
has_and_belongs_to_many: noticias

no _form
association: marcadores #cria campo select com mais de um

faz a collection

f.association: marcadores, as: :check_boxes, collection: Marcador.all.order(nome: :asc).map{|m| [m.nome, m.id]}, prompt "selcione marcador"

problema, check box nao esta salvando
no strong parameters(params) no controller, adicionar :{:marcador_ids => []}