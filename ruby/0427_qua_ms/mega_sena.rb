class MegaSena
	
	def jogo_normal(qtd_jogos)
		mega = (1..60).to_a
		
		mistura_numeros(mega, qtd_jogos)

		total(qtd_jogos)
	end
	
	def jogo_esperto(qtd_jogos)
		mega = [04, 05, 07, 12, 13, 16, 17, 23, 24, 29, 30, 32, 33, 37, 38, 41, 42, 43, 47, 49, 50, 51, 53, 54, 58, 59]
		
		mistura_numeros(mega, qtd_jogos)

		total(qtd_jogos)
	end

	
	def jogo_mais_esperto(qtd_jogos)
		range_normal = (1..60).to_a.shuffle
		range_seleto = [04, 05, 07, 12, 13, 16, 17, 23, 24, 29, 30, 32, 33, 37, 38, 41, 42, 43, 47, 49, 50, 51, 53, 54, 58, 59].shuffle
		diff_range = range_normal - range_seleto
		
		qtd_jogos.times do
			mega = range_seleto.shuffle[0..3] + diff_range.shuffle[0..1]
			p mega[0..5].sort.map {|n| n < 10 ? "0#{n}" : "#{n}" }.join(' - ')
		end
		total(qtd_jogos)
	end

	def mistura_numeros(mega, qtd_jogos)
		qtd_jogos.times do
			mega = mega.shuffle
			p mega[0..5].sort.map {|n| n < 10 ? "0#{n}" : "#{n}" }.join(' - ')
		end
		
	end
	
	def total(qtd_jogos)
		puts '========================================='
		puts "TOTAL A PAGAR R$ #{qtd_jogos*3.5}"
		puts '========================================='
	end

end

meu_jogo = MegaSena.new
meu_jogo.jogo_normal(4)
# meu_jogo.jogo_esperto(2)
# meu_jogo.jogo_mais_esperto(2)