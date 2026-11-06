# Introdução

Este repositório contém a documentação técnica e as evidências práticas da atividade de **Testes Caixa Cinza** aplicada a uma API de autenticação. O teste caixa cinza é uma técnica híbrida que utiliza o conhecimento parcial da estrutura interna do sistema (como rotas de endpoints, headers, payload em JSON e banco de dados) combinada com validações baseadas na perspectiva do usuário final.

# Objetivo da Atividade

O objetivo principal desta prática é compreender e aplicar testes funcionais em um ambiente de autenticação real, utilizando ferramentas modernas de mercado. Através da configuração de um backend as a service (BaaS) no Supabase e da orquestração de requisições HTTP no Postman Desktop, busca-se validar códigos de status, fluxos de segurança, respostas JSON e o comportamento de rotas críticas da aplicação.

---

# Configuração do Supabase

O **Supabase** foi utilizado para prover a infraestrutura de backend e o banco de dados PostgreSQL relacional.

* **Criação do Projeto:** Um novo projeto foi provisionado no painel oficial do Supabase.
* **Autenticação:** O provedor de acesso por **E-mail e Senha** foi devidamente habilitado no módulo de *Authentication*.
* **Criação de Usuário de Teste:** Foi cadastrado um usuário válido (ex: `teste@qa.com`) para servir como massa de dados para o "Caminho Feliz".
* **Credenciais Obtidas:** Foram coletadas a URL base do projeto (*Project URL*) e a chave pública de acesso (*anon / public API Key*).

> **Evidências:** As capturas de tela do painel do Supabase, da aba de autenticação e dos dados do usuário criado estão armazenadas na pasta `/prints/` do repositório.

---

# Configuração do Postman

O **Postman Desktop** foi utilizado como o cliente HTTP padrão para a execução e automação dos testes de API.

* **Workspace:** Foi criado um Workspace dedicado (`Atividade-QA`) para isolar o ambiente acadêmico/profissional.
* **Environment:** Foi configurado um ambiente específico (`Supabase-Env`) para gerenciar as variáveis de forma segura, evitando a exposição de chaves sensíveis no código.
* **Variáveis Mapeadas:**
  * `base_url`: URL raiz do projeto Supabase.
  * `api_key`: Chave pública de acesso (*anon/public*).
  * `email`: E-mail do usuário de teste.
  * `password`: Senha correspondente ao usuário de teste.

> **Evidências:** Os prints demonstrando o Workspace, o Environment e as variáveis ativas encontram-se no diretório `/prints/`, e a collection exportada está em `/postman/`.

---

# Configuração das Requisições

A requisição de autenticação foi modelada para simular o comportamento de um cliente interagindo com o serviço de segurança.

* **Método HTTP:** `POST`
* **Endpoint Utilizado:** `{{base_url}}/auth/v1/token?grant_type=password`

### Exemplo de Header Obrigatório

| Header | Valor |
| :--- | :--- |
| `apikey` | `{{api_key}}` |
| `Content-Type` | `application/json` |

### Exemplo do Body JSON

```json
{
  "email": "{{email}}",
  "password": "{{password}}"
}
```

> **Evidências:** As telas detalhando as abas *Headers* e *Body (raw/JSON)* configuradas no Postman estão salvas na pasta `/prints/`.

---

# Execução dos Testes

Foram executados 5 cenários obrigatórios de testes caixa cinza para validar tanto o comportamento de sucesso quanto as barreiras de validação e segurança da API.

### Tabela de Cenários

| Cenário | Entrada Utilizada | Resultado Esperado | Resultado Obtido | Status |
| :--- | :--- | :--- | :--- | :--- |
| **Login Válido** | Credenciais corretas | Status 200 + `access_token` | `200 OK` (Sessão gerada) | OK |
| **Senha Incorreta** | E-mail certo, senha errada | Erro de autenticação (400) | `400 Bad Request` (`invalid_grant`) | OK |
| **Usuário Inexistente** | E-mail não cadastrado | Acesso negado (400) | `400 Bad Request` (`invalid_grant`) | OK |
| **Campos Vazios** | Body JSON com strings vazias | Erro de validação (400) | `400 Bad Request` (Validação) | OK |
| **Credenciais Inválidas** | E-mail sem formatação "@" | Erro de sintaxe (400) | `400 Bad Request` (Formato inválido) | OK |

> **Evidências:** Os prints contendo as respostas em formato JSON, os códigos de status HTTP e os tokens retornados de cada cenário estão arquivados em `/prints/`.

---

# Registro dos Testes

Os testes executados foram formalmente registrados em uma planilha de controle de Quality Assurance (QA).

* **Metodologia de Registro:** Cada teste executado manualmente no Postman teve seu tempo de resposta, status code e corpo de retorno mapeados na planilha de acompanhamento.
* **Importância da Documentação:** O registro assegura a rastreabilidade dos testes e serve como contrato de comportamento para os desenvolvedores corrigirem eventuais falhas.
* **Análise de Resiliência:** A API do Supabase demonstrou alta estabilidade e conformidade com as regras de segurança padrão de mercado, blindando o sistema contra entradas malformadas.

> **Evidências:** A planilha preenchida em formato tabular encontra-se na pasta `/planilha/`.

---

# Resultados Obtidos

* **Códigos de Status:** A aplicação respondeu rigorosamente com `200 OK` para requisições bem-sucedidas e `400 Bad Request` para entradas inválidas, mantendo uma resposta padronizada sem expor falhas estruturais do banco de dados.
* **Payload de Retorno:** No cenário de sucesso, a API retornou o objeto de sessão completo contendo o token de acesso criptografado em formato JWT (*access_token*), o *refresh_token* e o tempo de expiração.

---

# Conclusão

* **Execução Prática:** A integração entre o Postman e o Supabase ocorreu de forma fluida após o ajuste correto das variáveis de ambiente e dos cabeçalhos HTTP.
* **Aprendizados:** O uso de testes de caixa cinza permitiu compreender com clareza como os pontos de contato (endpoints) validam o payload antes de processar as regras de negócio internas.
* **Próximos Passos:** Como melhoria contínua, sugere-se a implementação de testes automatizados na aba *Scripts* do Postman para validar as asserções de status code e token de forma automática a cada nova alteração de código.