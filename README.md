# 🚀 GEMINI: Technical Architecture & Career Asset Governance

> **Sistema Operacional Executivo — Agente Sênior Full Stack**
> Este repositório (HenriqueMC17/faculdade) não é apenas um conjunto de exercícios acadêmicos; é um **Ativo Digital de Engenharia** focado em alavancagem técnica, escalabilidade e design limpo.

---

## 🏛️ 1. Visão de Produto e Roadmap

O objetivo deste ecossistema é consolidar o conhecimento teórico da faculdade em padrões de mercado **State-of-the-Art**. Cada disciplina é tratada como um domínio de negócio separado, seguindo os princípios de **Bounded Contexts**.

### 📂 Estrutura de Domínios

- **`banco-de-dados/`**: Engenharia de Persistência, Otimização de Queries (Performance by Default) e Modelagem E-R.
- **`linguagens-de-programacao/`**: Exploração de paradigmas (Imperativo, Funcional, Reativo) com foco em Tipagem Estrita.
- **`lógica-algoritmos-e-programação-orientada-a-objetos/`**: Aplicação rigorosa de **SOLID**, **Design Patterns** e **Clean Code**.
  - **`exercicios/`**:
    - **`Aula_2/`**: Exemplo de login e operadores básicos.
    - **`Aula_7/`**: Associações de classes complexas (`Pessoa`, `Socio`, `Dependente`, `ContaComum`, `Funcionario`).
    - **`dao/`**: Padrão Data Access Object genérico com JPA/EntityManager.
    - **`reports/`**: Geração de relatórios PDF estruturados com iTextPDF.
    - **`[34 Exercícios Core]/`**: Implementações robustas em Java de algoritmos clássicos, jogos (como Jogo da Velha), simulações (álbum de figurinhas, oficina de poções) e conceitos fundamentais de POO (polimorfismo de veículos/reprodutores de mídias, encapsulamento, herança).

---

## 🛠️ 2. Stack Tecnológica & Padrões

Seguimos a constituição estabelecida nas **MASTER RULES (SSOT)**:

- **Core**: HTML/JS para aplicações web, com foco em Vanilla para controle total.
- **Logic**: TypeScript/JavaScript/Python (dependendo da disciplina), sempre visando o **Secure by Design**.
- **Database**: SQL Puro e ORMs modernos (Prisma/TypeORM) quando aplicável, focando em **Querying Resilience**.

---

## 📐 3. Princípios Arquiteturais (P0 Standards)

Todo código commitado neste repo deve honrar o modelo: **Código → Arquitetura → Produto → Ativo**.

1. **Clean Architecture**: Blindagem da lógica de domínio contra detalhes de infraestrutura.
2. **SOLID & DRY**: Centralização de lógicas repetitivas, evitando acoplamento precoce (Rule of Three).
3. **Fail Fast**: Implementação de *Guard Clauses* e validação rigorosa de inputs (Zero Trust Base).
4. **Screaming Architecture**: A estrutura de pastas deve revelar a intenção do domínio, não o framework utilizado.

---

## ⚙️ 4. Fluxo de Trabalho (Workflow)

Operamos em uma mentalidade de **Deep Work** e **Execução Consistente**.

- **Git Governance**: Commits semânticos no padrão `feat|fix|refactor|chore|test|docs`.
- **CI/CD Local**: Uso de linters, formatadores e testes unitários (Padrão AAA) antes de cada integração com a branch principal.
- **Documentação Contínua**: O `GEMINI.md` e os arquivos `.md` de cada pasta são a **Single Source of Truth**.

---

## 🛡️ 5. Segurança & Performance

- **Zero Secrets**: Proibido hard-coding de credenciais. Uso estrito de `.env` (ignorado pelo Git).
- **Performance by Default**: Medir antes de otimizar. Foco em Core Web Vitals (LCP, CLS, INP) em projetos front-end.
- **Sanitização Universal**: Todo input externo é considerado hostil até que seja validado por Schemas (Zod/Pydantic).

---

## 📈 6. Métricas de Sucesso

O sucesso deste projeto é medido pela **Eficiência de Retorno Constante**: a capacidade de reutilizar componentes e lógicas em projetos reais de mercado, transformando o aprendizado acadêmico em ativos de alta performance.

---

**Status Operacional**: 🟢 Ativo | **Versão**: 1.0.0
**Mantenha o Workspace Limpo**: Destrua arquivos soltos, aplique documentação contínua.
