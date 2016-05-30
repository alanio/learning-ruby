class Pessoa
	#atributos da classe
	#nome
	#email

	attr_accessor :primeiro_nome, :sobrenome, :email
	attr_reader :cpf

	def initialize(cpf, primeiro_nome=nil, sobrenome=nil, email=nil)
		@cpf = cpf
		@primeiro_nome = primeiro_nome
		@sobrenome = sobrenome
		@email = email		
	end

	
end
