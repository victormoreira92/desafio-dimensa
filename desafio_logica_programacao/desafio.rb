def extrair_diamantes(expressao)
  pilha = []
  diamantes = 0
  expressao = expressao.gsub('.', '')
  expressao.each_char do |char|
    if char == '<'
      pilha.push('<')
    elsif char == '>'
      if pilha.any? && pilha.last == '<'
        pilha.pop
        diamantes += 1
      end
    end
  end

  diamantes
end

expressao = "<<.<<..>><>><.>.>.<<.>.<.>>>><>><>>"
quantidade_diamantes = extrair_diamantes(expressao)

puts "Quantidade de diamantes extraídos: #{quantidade_diamantes}"
