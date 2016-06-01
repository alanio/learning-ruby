require 'ffaker'
require 'active_support/all'


def idade(data_nascimento)
	begin
		birthday = Date.parse(data_nascimento)
		age = Date.today.year - birthday.year
		age -= 1 if birthday > Date.today.years_ago(age) 
		age
	rescue Exception => e
		e
	end
end


end
#puts Date.current

#LETRA A
funcionarios = {
	matricula_01: {nome: FFaker::NameBR.name, data_nascimento: '1988-11-20', cpf:  '0',data_admissao: '2016-05-04'	},
	matricula_02: {nome: FFaker::NameBR.name, data_nascimento: '1976-11-20', cpf:  '1',data_admissao: '2015-05-04'	},
	matricula_03: {nome: FFaker::NameBR.name, data_nascimento: '1974-11-20', cpf:  '2',data_admissao: '2014-05-04'	},
	matricula_04: {nome: FFaker::NameBR.name, data_nascimento: '1974-11-20', cpf:  '3',data_admissao: '2013-05-04'	},
	matricula_05: {nome: FFaker::NameBR.name, data_nascimento: '1964-11-20', cpf:  '4',data_admissao: '2012-05-04'	},
	matricula_06: {nome: FFaker::NameBR.name, data_nascimento: '1989-11-20', cpf:  '5',data_admissao: '2011-05-04'	},
	matricula_07: {nome: FFaker::NameBR.name, data_nascimento: '1990-11-20', cpf:  '6',data_admissao: '2010-05-04'	},
	matricula_08: {nome: FFaker::NameBR.name, data_nascimento: '1992-11-20', cpf:  '7',data_admissao: '2009-05-04'	},
	matricula_09: {nome: FFaker::NameBR.name, data_nascimento: '1987-11-20', cpf:  '8',data_admissao: '2008-05-04'	},
	matricula_10: {nome: FFaker::NameBR.name, data_nascimento: '2015-05-04', cpf:  '9',data_admissao: '2007-05-04'}
}

#p funcionarios

#LETRA B relatorio
funcionarios
	.sort_by{|key, value| value[:nome]} 
	.each do |matricula, dados|
	#p "#{matricula}: #{dados[:nome]}"
end

#LETRA C
funcionarios
	.sort_by{|key, value| value[:data_nascimento]} 
	.each do |matricula, dados|
	#p "#{matricula}: #{dados[:nome]} | Data de Nascimento: #{dados[:data_nascimento]} | Idade: #{idade(dados[:data_nascimento])}"
end

#LETRA D
funcionarios
	.sort_by{|key, value| value[:data_admissao]} 
	.each do |matricula, dados|
	p "#{matricula}: #{dados[:nome]} | CPF: #{dados[:cpf]} | Admissão: #{dados[:data_admissao]}"
end

