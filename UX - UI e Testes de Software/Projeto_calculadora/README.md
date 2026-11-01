# Projeto Calculadora — FinancApp

> Projeto academico desenvolvido com foco em Qualidade de Software, Testes, Refatoracao, Documentacao e Versionamento.

---

## 1. Identificacao do Projeto

**Projeto:** Projeto Calculadora
**Contexto:** FinancApp
**Aluno:** Henrique Monteiro Cardoso
**RA:** 250878
**Curso:** Analise e Desenvolvimento de Sistemas
**Disciplina:** UX - UI e Testes de Software
**Professor:** Daniel Domingos Akira de Sa Pimentel Ohata
**Semestre:** 2026.2

---

## 2. Visao Geral

O projeto consiste no desenvolvimento de um modulo de calculos matematicos basicos em Java para a startup ficticia **FinancApp**.

O modulo foi desenvolvido com o objetivo de ser utilizado futuramente em funcionalidades de controle financeiro, como:

- orcamento mensal;
- divisao de despesas;
- projecoes financeiras;
- calculos auxiliares.

Alem do funcionamento correto das operacoes, o projeto aplica praticas de qualidade de software relacionadas a:

- testes;
- tratamento de erros;
- refatoracao;
- documentacao;
- versionamento;
- manutencao de codigo.

---

## 3. Problema

Durante o desenvolvimento da aplicacao FinancApp, foi identificada a necessidade de criar um modulo matematico reutilizavel.

Entretanto, a equipe definiu que o modulo nao deveria apenas funcionar corretamente, mas tambem apresentar:

- codigo legivel;
- testes automatizados;
- tratamento de falhas;
- documentacao tecnica;
- controle de versoes;
- facilidade de manutencao.

O desafio consiste, portanto, em desenvolver uma solucao funcional e ao mesmo tempo aplicar boas praticas de Engenharia de Software.

---

## 4. Objetivo

### 4.1 Objetivo Geral

Desenvolver uma calculadora em Java aplicando praticas de qualidade, testes, documentacao, refatoracao e versionamento.

### 4.2 Objetivos Tecnicos

- implementar operacoes matematicas basicas;
- tratar entradas invalidas;
- impedir divisao por zero;
- desenvolver testes automatizados;
- refatorar o codigo sem alterar seu comportamento;
- documentar classes e metodos com JavaDoc;
- gerar documentacao HTML;
- utilizar Git e GitHub;
- organizar commits e branches;
- manter documentacao tecnica no README.

---

## 5. Escopo Funcional

A aplicacao oferece as seguintes operacoes:

| ID   | Funcionalidade       | Descricao                        | Status |
| ---- | -------------------- | -------------------------------- | ------ |
| RF01 | Soma                 | Soma dois numeros inteiros       | OK     |
| RF02 | Subtracao            | Subtrai dois numeros inteiros    | OK     |
| RF03 | Multiplicacao        | Multiplica dois numeros inteiros | OK     |
| RF04 | Divisao              | Divide dois numeros inteiros     | OK     |
| RF05 | Validacao de divisao | Impede divisao por zero          | OK     |
| RF06 | Operacao invalida    | Trata operadores nao suportados  | OK     |

---

## 6. Requisitos Nao Funcionais

| ID    | Categoria      | Requisito                                                  |
| ----- | -------------- | ---------------------------------------------------------- |
| RNF01 | Qualidade      | O codigo deve possuir organizacao e legibilidade           |
| RNF02 | Testabilidade  | As operacoes devem possuir testes automatizados            |
| RNF03 | Manutencao     | O codigo deve permitir refatoracao sem alteracao funcional |
| RNF04 | Documentacao   | Classes e metodos devem possuir JavaDoc                    |
| RNF05 | Versionamento  | O projeto deve utilizar Git e GitHub                       |
| RNF06 | Confiabilidade | Erros nao devem interromper inesperadamente a execucao     |

---

## 7. Tecnologias Utilizadas

| Tecnologia | Versao     | Utilizacao                   |
| ---------- | ---------- | ---------------------------- |
| Java       | 26.0.2     | Desenvolvimento              |
| JDK        | 26.0.2     | Compilacao e JavaDoc         |
| Git        | 2.x        | Controle de versao           |
| GitHub     | —         | Repositorio remoto           |
| JavaDoc    | Nativo JDK | Geracao de documentacao HTML |

---

## 8. Estrutura do Projeto

```text
projeto_calculadora/
│
├── src/
│   └── calculadora/
│       └── Calculadora.java          # Classe principal — logica de calculo
│
├── test/
│   └── calculadora/
│       └── TesteCalculadora.java     # Classe de testes unitarios
│
├── docs/
│   └── index.html                    # Documentacao JavaDoc gerada
│
├── images/
│   ├── testes/                       # Prints da execucao dos testes
│   ├── javadoc/                      # Prints da documentacao JavaDoc
│   └── refatoracao/                  # Prints da branch de refatoracao
│
├── out/                              # Bytecode compilado (nao versionado)
├── README.md                         # Este arquivo
└── .gitignore                        # Arquivos ignorados pelo Git
```

---

## 9. Explicacao das Operacoes

O metodo principal da calculadora e:

```java
public double calc(int a, int b, String op)
```

| Operacao      | Operador | Exemplo              | Resultado         |
| ------------- | -------- | -------------------- | ----------------- |
| Soma          | `+`    | `calc(10, 5, "+")` | `15.0`          |
| Subtracao     | `-`    | `calc(10, 5, "-")` | `5.0`           |
| Multiplicacao | `*`    | `calc(10, 5, "*")` | `50.0`          |
| Divisao       | `/`    | `calc(10, 5, "/")` | `2.0`           |
| Divisao/zero  | `/`    | `calc(10, 0, "/")` | `NaN` (tratado) |
| Op. invalida  | `%`    | `calc(10, 5, "%")` | `NaN` (tratado) |

### Tratamento de Erros

- **Divisao por zero:** retorna `Double.NaN` e exibe mensagem de erro. A execucao nao e interrompida.
- **Operador invalido:** retorna `Double.NaN` e exibe mensagem de erro. A execucao nao e interrompida.
- **Operador nulo:** retorna `Double.NaN` e exibe mensagem de erro. A execucao nao e interrompida.

---

## 10. Como Executar

### Compilar

```bash
javac -d out -encoding UTF-8 src/calculadora/Calculadora.java test/calculadora/TesteCalculadora.java
```

### Executar a Calculadora

```bash
java -cp out calculadora.Calculadora
```

### Executar os Testes

```bash
java -cp out calculadora.TesteCalculadora
```

### Gerar Documentacao JavaDoc

```bash
javadoc -d docs -sourcepath "src;test" -subpackages calculadora -encoding UTF-8 -charset UTF-8 -author -version
```

---

## 11. Testes Unitarios

A classe `TesteCalculadora` cobre os seguintes cenarios:

| Grupo             | Quantidade   | Cenarios Cobertos                                 |
| ----------------- | ------------ | ------------------------------------------------- |
| Soma              | 3            | Positivos, com negativo, com zero                 |
| Subtracao         | 3            | Resultado positivo, negativo e zero               |
| Multiplicacao     | 3            | Positivos, por zero, com negativo                 |
| Divisao           | 3            | Exata, decimal, zero dividido                     |
| Divisao por zero  | 2            | Erro tratado, retorno NaN                         |
| Operacao invalida | 3            | Operadores %, ^ e null                            |
| **Total**   | **17** | **Todos os cenarios obrigatorios cobertos** |

### Prints da Execucao dos Testes

> Adicione aqui as capturas de tela apos executar os testes.
> Caminho sugerido: `images/testes/`

---

## 12. Documentacao JavaDoc

A documentacao foi gerada com:

```bash
javadoc -d docs -sourcepath "src;test" -subpackages calculadora -encoding UTF-8 -charset UTF-8 -author -version
```

Acesse: `docs/index.html`

### Prints da Documentacao JavaDoc

> Adicione aqui as capturas de tela da documentacao JavaDoc.
> Caminho sugerido: `images/javadoc/`

---

## 13. Refatoracao

### Branch: `Refatoracao`

Na branch `Refatoracao`, foram aplicadas as seguintes tecnicas:

| Tecnica                   | Descricao                                                   |
| ------------------------- | ----------------------------------------------------------- |
| Extracao de metodos       | Cada operacao foi separada em metodo privado dedicado       |
| Melhoria de legibilidade  | Nomes de variaveis e metodos mais descritivos e expressivos |
| Simplificacao condicional | Uso de `switch` em vez de cadeia de `if-else`           |
| Organizacao logica        | Codigo dividido em secoes com comentarios delimitadores     |
| Documentacao              | JavaDoc completo em todas as classes, metodos e atributos   |

Apos a refatoracao, todos os 17 testes foram executados novamente e continuam passando.

### Prints da Refatoracao

> Adicione aqui as capturas de tela da branch Refatoracao.
> Caminho sugerido: `images/refatoracao/`

---

## 14. Versionamento

### Branches

| Branch          | Descricao                                             |
| --------------- | ----------------------------------------------------- |
| `main`        | Versao inicial funcional do projeto                   |
| `Refatoracao` | Codigo refatorado com tecnicas de qualidade aplicadas |

### Historico de Commits

| Commit | Descricao                                                    |
| ------ | ------------------------------------------------------------ |
| 1      | `init: estrutura inicial do projeto_calculadora`           |
| 2      | `feat: implementacao da classe Calculadora com operacoes`  |
| 3      | `feat: implementacao dos testes unitarios`                 |
| 4      | `docs: adicao de JavaDoc e comentarios tecnicos`           |
| 5      | `docs: geracao da documentacao HTML com javadoc`           |
| 6      | `chore: adicao de .gitignore e README.md`                  |
| 7      | `refactor: extracao de metodos e melhoria de legibilidade` |

---

## 15. Repositorio

**Link:** https://github.com/seu-usuario/projeto_calculadora

> Substitua pelo link real apos publicar no GitHub.

---

## 16. Autor

**Nome:** Henrique Monteiro Cardoso
**RA:** 250878
**Curso:** Analise e Desenvolvimento de Sistemas
**Disciplina:** UX - UI e Testes de Software
**Professor:** Daniel Domingos Akira de Sa Pimentel Ohata
**Semestre:** 2026.2
