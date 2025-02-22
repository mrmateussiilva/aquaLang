# Aqua Lang

Aqua Lang é uma linguagem de programação funcional inspirada em Python, com sintaxe simplificada por indentação e foco em concorrência usando fibers e channels. Aqua oferece imutabilidade por padrão, pipelines e pattern matching para facilitar o desenvolvimento de código limpo e expressivo.

## **✨ Recursos Principais**
- **Sintaxe Limpa:** Blocos definidos por indentação, sem chaves `{}`.
- **Imutabilidade por Padrão:** Variáveis declaradas com `let` são constantes, enquanto `mut` permite mutabilidade.
- **Funções de Primeira Classe:** Funções podem ser passadas como argumentos e retornadas de outras funções.
- **Currying:** Suporte nativo para currying, permitindo composição elegante de funções.
- **Pattern Matching:** Correspondência de padrões poderosa e expressiva.
- **Concorrência:** Uso de fibers e channels para execução paralela.
- **Pipelines:** Operador `|>` para composição fluida de funções.
- **Tipagem Estática:** Tipos explícitos, com inferência de tipos em tempo de compilação.

## **📦 Exemplo de Código**
```aqua
# Declaração de variáveis
let nome = "Aqua Lang"
mut idade = 25

# Função com indentação
fn saudacao(nome: str)
    print("Olá, " + nome)

saudacao(nome)

# Pattern Matching
fn verifica(x)
    match x
        0      => print("Zero")
        1..10  => print("Entre 1 e 10")
        "aqua" => print("É a Aqua!")
        _      => print("Outro valor")

verifica(5)

# Pipeline
let resultado = [1, 2, 3, 4]
    |> map(fn (x) -> x * 2)
    |> filter(fn (x) -> x > 4)
    |> reduce(fn (acc, x) -> acc + x, 0)

print(resultado)  # Saída: 14
```

## **🚀 Instalação do Interpretador**
1. Instale o [Zig](https://ziglang.org/download/).
2. Clone o repositório:
```bash
git clone https://github.com/seu-usuario/aqua-lang.git
cd aqua-lang
```
3. Compile o interpretador:
```bash
zig build-exe aqua.zig
```

## **💻 Executando Código Aqua**
Crie um arquivo `exemplo.aqua` com o seguinte conteúdo:
```aqua
print "Olá, Aqua!"
print "Isso é só o começo."
```
Execute o interpretador:
```bash
./aqua exemplo.aqua
```
Saída:
```
Olá, Aqua!
Isso é só o começo.
```

## **🛠️ Estrutura de um Programa Aqua**
Um programa em Aqua segue uma estrutura simples:
1. **Declaração de Variáveis:** `let` para constantes, `mut` para variáveis mutáveis.
2. **Funções:** Definidas com `fn`, blocos delimitados por indentação.
3. **Controle de Fluxo:** `if`, `elif`, `else` e `match` para padrões complexos.
4. **Concorrência:** `spawn` para execução paralela e `channel` para comunicação segura.

Exemplo de concorrência:
```aqua
fn trabalho()
    print("Iniciando trabalho...")
    sleep(1000)
    print("Trabalho concluído!")

spawn trabalho()
```

## **🛠️ Roadmap**
- [x] Suporte a print e variáveis
- [x] Pattern Matching
- [x] Pipelines
- [ ] Suporte a expressões matemáticas
- [ ] Estruturas de dados avançadas (listas, dicionários)
- [ ] Concorrência completa com channels
- [ ] Módulos e imports
- [ ] Suporte a testes nativos

## **🤝 Contribuindo**
Quer contribuir? Siga os passos abaixo:
1. Faça um fork do repositório.
2. Crie um branch para sua funcionalidade:
```bash
git checkout -b minha-feature
```
3. Faça as alterações, adicione testes, e envie um pull request!

## **📜 Licença**
Este projeto está licenciado sob a [MIT License](LICENSE).

