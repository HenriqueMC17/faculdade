# AC1 - Catálogo Simples de Filmes (Angular)

Projeto desenvolvido de acordo com todos os requisitos da avaliação de Desenvolvimento Web Front-End.

## 🎯 Mapeamento dos Requisitos e Critérios de Pontuação

### 1. Componente Criado
* **Nome:** `CatalogoFilmes`
* **Localização no Projeto:** `src/app/CatalogoFilmes/` (integrado ao `OiMundo`) e arquivos avulsos em `Prova/AC1/`.

### 2. TypeScript (`catalogo-filmes.ts`) - (1 Ponto)
* ✅ **Lista com pelo menos cinco filmes:** `filmes: string[] = ['Interestelar', 'O Poderoso Chefão', 'Matrix', 'Inception (A Origem)', 'O Senhor dos Anéis: O Retorno do Rei']`
* ✅ **Variável para armazenar o filme selecionado:** `filmeSelecionado: string = ''`
* ✅ **Variável para receber o nome do novo filme:** `novoFilme: string = ''`
* ✅ **Variável booleana de favorito:** `isFavorito: boolean = false`
* ✅ **Contador de visualizações:** `visualizacoes: number = 0`
* ✅ **Reinicialização ao trocar de filme:** O método `selecionarFilme()` reseta `isFavorito = false` e `visualizacoes = 0`.

### 3. HTML (`catalogo-filmes.html`) - (1 Ponto)
* ✅ Exibição de filmes com `@for (filme of filmes; track $index)`.
* ✅ Seleção ao clicar no filme com `(click)="selecionarFilme(filme)"`.
* ✅ Exibição condicional com `@if (filmeSelecionado) { ... } @else { ... }`.
* ✅ Campo de texto com `[(ngModel)]="novoFilme"` e botão "Adicionar".
* ✅ Desabilitação do botão com `[disabled]="!novoFilme.trim()"`.
* ✅ Botão alternando entre "Adicionar aos favoritos" e "Remover dos favoritos".
* ✅ Botão para incrementar visualizações com `(click)="aumentarVisualizacoes()"`.
* ✅ Exibição das visualizações com interpolação `{{ visualizacoes }}`.
* ✅ Alteração dinâmica de estilo/classe de favorito: `[class.favorito]="isFavorito"`.

### 4. Apresentação Visual com CSS próprio - (1 Ponto)
* ✅ Design moderno estruturado em cards, listas estilizadas, botões com feedback visual e badges de status.

### 5. Os Quatro Tipos de Data Binding Implementados - (2 Pontos)
1. **Interpolação:** `{{ filme }}`, `{{ filmeSelecionado }}`, `{{ visualizacoes }}`
2. **Property Binding:** `[disabled]="!novoFilme.trim()"`, `[class.favorito]="isFavorito"`, `[class.selecionado]="filme === filmeSelecionado"`
3. **Event Binding:** `(click)="selecionarFilme(filme)"`, `(click)="adicionarFilme()"`, `(click)="alternarFavorito()"`, `(click)="aumentarVisualizacoes()"`
4. **Two-Way Binding:** `[(ngModel)]="novoFilme"` (requer `FormsModule` importado)

---

## 🚀 Como Executar

No terminal, dentro da pasta do projeto Angular:

```bash
cd "c:\Dev\faculdade\Desenvolvimento Web Front-End\Angular\OiMundo"
npm start
# ou
ng serve
```

Abra no navegador em: `http://localhost:4200/catalogo` (ou direto na raiz `http://localhost:4200/`).
