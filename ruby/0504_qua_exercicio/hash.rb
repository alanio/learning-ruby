curso_ruby_on_rails = {
	:professor => {nome: "Elias", idade: 38},
	:alunos => {
		:aluno_01 => {nome: "Marcelino", idade: 27},
		:aluno_02 => {nome: "Mateus", idade: 27},
		:aluno_03 => {nome: "Raphael", idade: 27},
		:aluno_05 => {nome: "Nelson", idade: 19},
		:aluno_06 => {nome: "João", idade: 23},
		:aluno_07 => {nome: "Alanio", idade: 27},
		:aluno_08 => {nome: "Jefferson", idade: 22},
		:aluno_09 => {nome: "Marcos", idade: 29},
		:aluno_10 => {nome: "Felipe", idade: 22},
		:aluno_11 => {nome: "Romulo", idade: 29},
		:aluno_12 => {nome: "Itao", idade: 25},
		:aluno_13 => {nome: "Lucas", idade: 27},
		:aluno_14 => {nome: "Tomaz", idade: 23}
	}
}

puts "Alunos:"
curso_ruby_on_rails[:alunos].sort_by {|key, value| value[:nome]}.each do |matricula, dados|
	puts "#{matricula}) Nome: #{dados[:nome]}, Idade: #{dados[:idade]}"	
end