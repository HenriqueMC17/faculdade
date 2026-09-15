# 📘 Base de Conhecimento e Guia de Estudos para a Prova
**Componente Curricular:** Desenvolvimento Web Front-End (Facens)  
**Professor:** Prof. Dr. Fabrício Tonetto Londero  

---

## 🎯 1. Visão Geral das Avaliações

| Avaliação | Peso | Conteúdo Principal |
|---|---|---|
| **AC1 (Avaliação Continuada 1)** | 15% | Fundamentos Web, JavaScript Puro (DOM & Eventos) e Introdução ao Angular (CLI, Estrutura, Componentes, Rotas, Data Binding, `@Input` / `@Output`) |
| **AC2 (Avaliação Continuada 2)** | 30% | Diretivas Estruturais (`@if`, `@for`, `@switch`) e de Atributo (`ngClass`, `ngStyle`), Formulários e Validações |
| **AG (Avaliação Geral)** | 10% | Teste de Progresso institucional |
| **AF (Avaliação Final)** | 45% | Todo o conteúdo integrado: Angular, Services (`HttpClient`), APIs RESTful com Node.js e MongoDB |

---

## 🟡 PARTE 1: JavaScript Puro (DOM, Eventos e Validações)

As listas de exercícios da Aula 01 cobram a base de manipulação de DOM e lógica que o Angular abstrai. O professor costuma pedir lógica de formulários e interação de nós.

### 1.1. Seleção de Elementos e Manipulação
```javascript
// Seletores principais
const botao = document.getElementById('meuBotao');
const campos = document.querySelectorAll('input[type="text"]');

// Alterando conteúdo e atributos
elemento.innerText = "Novo texto";
elemento.innerHTML = "<strong>Texto em negrito</strong>";
campo.value = "Novo valor";
campo.disabled = true; // Desabilita o campo
campo.type = campo.type === "password" ? "text" : "password"; // Mostrar/ocultar senha
```

### 1.2. Manipulação de Estilos e Classes
```javascript
// Estilo inline direto
elemento.style.backgroundColor = "blue";
elemento.style.fontSize = "20px";
elemento.style.display = "none"; // Ocultar

// Classes CSS
elemento.classList.add('ativo');
elemento.classList.remove('inativo');
elemento.classList.toggle('selecionado');
```

### 1.3. Criação e Remoção Dinâmica de Elementos (Questão clássica de prova!)
```javascript
// Criar linha em tabela ou item em lista
const tr = document.createElement('tr');
const tdNome = document.createElement('td');
tdNome.innerText = "João";
tr.appendChild(tdNome);

// Botão de remoção
const btnRemover = document.createElement('button');
btnRemover.innerText = "Remover";
btnRemover.onclick = function() {
    tr.remove(); // ou tabela.removeChild(tr);
};
tr.appendChild(btnRemover);

tabela.appendChild(tr);
```

### 1.4. Eventos Fundamentais
* `click`: clique do mouse em botões/elementos.
* `mouseover` / `mouseout`: passar o cursor sobre links/divs.
* `input` / `keyup`: digitação em tempo real (ex: contador de caracteres até 140).
* `change`: alteração em selects, checkboxes e radio buttons.
* `submit`: disparo do formulário (`event.preventDefault()` evita recarregar a página).

---

## 🔴 PARTE 2: Angular CLI e Estrutura de Projeto

### 2.1. Comandos Essenciais da CLI
* `npm install -g @angular/cli`: Instala a CLI globalmente.
* `ng version`: Verifica as versões do Angular, Node e TypeScript instaladas.
* `ng new NomeDoProjeto`: Cria um novo projeto Angular interativo (pergunta sobre Rotas e formato CSS).
* `ng serve`: Compila e sobe o servidor de desenvolvimento em `http://localhost:4200` com live reload.
* `ng generate component nome` ou `ng g c nome`: Gera os arquivos do componente (`.ts`, `.html`, `.css`, `.spec.ts`).
* `ng build`: Compila para produção na pasta `/dist`.

### 2.2. O papel de cada arquivo na estrutura Angular
* **`package.json`**: Metadados do projeto, scripts (`ng serve`, `ng build`) e lista de dependências externas.
* **`angular.json`**: Configurações de compilação, assets, caminhos de estilos globais (`styles.css`).
* **`tsconfig.json`**: Configurações do compilador TypeScript.
* **`src/index.html`**: O único HTML carregado pelo navegador (SPA), contendo a tag `<app-root></app-root>`.
* **`src/main.ts`**: Ponto de entrada da aplicação (onde o bootstrap da aplicação acontece).
* **`src/app/`**: Onde reside todo o código funcional (componentes, rotas, serviços).

---

## 🔵 PARTE 3: Roteamento (Routing) no Angular

O Angular cria Single Page Applications (SPAs) onde a página nunca é completamente recarregada.

### 3.1. Configuração das Rotas (`app.routes.ts`)
```typescript
import { Routes } from '@angular/router';
import { Home } from './home/home';
import { Sobre } from './sobre/sobre';
import { Login } from './login/login';

export const routes: Routes = [
  { path: '', component: Home },
  { path: 'sobre', component: Sobre },
  { path: 'login', component: Login },
  { path: '**', redirectTo: '' } // Rota curinga (404)
];
```

### 3.2. Exibição e Navegação no Template Principal (`app.html`)
* **`routerLink`**: Deve ser usado no lugar de `href=""` para não forçar o recarregamento da página.
* **`<router-outlet></router-outlet>`**: Marcador onde o componente da rota atual é renderizado dinamicamente.

```html
<nav>
  <a routerLink="">Home</a> |
  <a routerLink="/sobre">Sobre</a> |
  <a routerLink="/login">Login</a>
</nav>

<router-outlet></router-outlet>
```

---

## 🟣 PARTE 4: Os 4 Tipos de Data Binding (Cai com certeza!)

O Data Binding é a ponte que conecta a lógica TypeScript à interface HTML.

```
                  TypeScript (Lógica)
                   /        ^        \
       Interpolação /          \ Event  \ Property
       {{ valor }} /            \ (click)\ [src]
                  v              \        v
                   Interface do Usuário (HTML)
                         <--------->
                    Two-Way [(ngModel)]
```

| Tipo | Sintaxe | Direção | Exemplo de Uso |
|---|---|---|---|
| **Interpolação** | `{{ variavel }}` | TS ➔ HTML | `<p>Olá, {{ nome }}!</p>` |
| **Property Binding** | `[propriedade]="valor"` | TS ➔ HTML | `<img [src]="urlFoto">`, `<button [disabled]="!formValido">` |
| **Event Binding** | `(evento)="metodo()"` | HTML ➔ TS | `<button (click)="salvar()">Salvar</button>` |
| **Two-Way Binding** | `[(ngModel)]="variavel"` | TS 🔄 HTML | `<input [(ngModel)]="usuario.email">` *(requer `FormsModule`)* |

> ⚠️ **Atenção para Prova:** Para utilizar `[(ngModel)]`, é obrigatório importar o `FormsModule` no decorador `@Component`:
```typescript
import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [FormsModule],
  templateUrl: './login.html',
  styleUrl: './login.css'
})
export class Login {
  email: string = '';
}
```

---

## 🟢 PARTE 5: Comunicação entre Componentes (`@Input` e `@Output`)

Em uma arquitetura componentizada, os componentes precisam trocar dados com baixo acoplamento.

### 5.1. `@Input()`: Pai envia para o Filho
* O filho declara que aceita receber uma propriedade com `@Input()`.
* O pai passa a informação via **Property Binding `[propriedade]="valorDoPai"`**.

**No Componente Filho:**
```typescript
import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-filho',
  standalone: true,
  template: `<p>Mensagem recebida do pai: {{ mensagem }}</p>`
})
export class ComponenteFilho {
  @Input() mensagem: string = '';
}
```

**No Componente Pai:**
```typescript
// No pai.ts:
mensagemDoPai = "Olá, meu filho!";

// No pai.html:
<app-filho [mensagem]="mensagemDoPai"></app-filho>
```

---

### 5.2. `@Output()` e `EventEmitter`: Filho notifica o Pai
* O filho cria um evento com `@Output() nomeEvento = new EventEmitter<Tipo>();`.
* O filho emite o evento via `this.nomeEvento.emit(dados)`.
* O pai captura via **Event Binding `(nomeEvento)="metodoDoPai($event)"`**.

**No Componente Filho:**
```typescript
import { Component, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'app-filho',
  standalone: true,
  template: `<button (click)="notificarPai()">Enviar para o Pai</button>`
})
export class ComponenteFilho {
  @Output() eventoFilho = new EventEmitter<string>();

  notificarPai() {
    this.eventoFilho.emit("Mensagem vinda do filho!");
  }
}
```

**No Componente Pai:**
```typescript
// No pai.ts:
textoRecebido = '';
receberAviso(msg: string) {
  this.textoRecebido = msg;
}

// No pai.html:
<app-filho (eventoFilho)="receberAviso($event)"></app-filho>
<p>Valor no Pai: {{ textoRecebido }}</p>
```

---

## 🟠 PARTE 6: Diretivas Estruturais e Não Estruturais (Aula 04)

### 6.1. O que são Diretivas?
Instruções que o Angular aplica a nós do DOM para alterar aparência, estrutura ou comportamento.

### 6.2. Estruturais vs Não Estruturais
* **Estruturais**: Adicionam, removem ou recriam elementos no DOM (ex: `@if`, `@for`, `@switch` ou `*ngIf`, `*ngFor`).
* **Não Estruturais (de Atributo)**: Não alteram a estrutura do DOM, apenas mudam propriedades, classes ou estilos de elementos já existentes (ex: `ngClass`, `ngStyle`).

---

### 6.3. Diretivas Estruturais: Sintaxe Moderna (Angular 17+) vs Clássica

#### A) Condicional (`@if` vs `*ngIf`)
* **Moderna (sem import extra):**
```html
@if (usuarioLogado) {
  <p>Bem-vindo ao sistema!</p>
} @else {
  <p>Faça seu login.</p>
}
```
* **Clássica (requer `CommonModule`):**
```html
<p *ngIf="usuarioLogado">Bem-vindo ao sistema!</p>
<p *ngIf="!usuarioLogado">Faça seu login.</p>
```

#### B) Repetição (`@for` vs `*ngFor`)
* **Moderna:**
```html
<ul>
  @for (produto of produtos; track produto.id) {
    <li>{{ $index }} - {{ produto.nome }} (R$ {{ produto.preco }})</li>
  } @empty {
    <li>Nenhum produto cadastrado.</li>
  }
</ul>
```
* **Clássica:**
```html
<ul>
  <li *ngFor="let produto of produtos; let i = index">
    {{ i }} - {{ produto.nome }}
  </li>
</ul>
```

#### C) Seleção Múltipla (`@switch` vs `*ngSwitch`)
* **Moderna:**
```html
@switch (tipo) {
  @case ('eletronico') { <span>Aparelho Eletrônico</span> }
  @case ('livro') { <span>Livro Físico</span> }
  @default { <span>Outro item</span> }
}
```
* **Clássica:**
```html
<div [ngSwitch]="tipo">
  <p *ngSwitchCase="'eletronico'">Aparelho Eletrônico</p>
  <p *ngSwitchCase="'livro'">Livro Físico</p>
  <p *ngSwitchDefault>Outro item</p>
</div>
```

---

### 6.4. Diretivas de Atributo: `ngClass` e `ngStyle`

#### A) `ngClass` (Classes CSS Dinâmicas)
Aplica classes dependendo de condições booleanas ou variáveis:
```html
<!-- Objeto com chave (nome da classe) e valor (booleano) -->
<p [ngClass]="{ 'badge-sucesso': emEstoque, 'badge-perigo': !emEstoque }">
  Status do Produto
</p>
```

#### B) `ngStyle` (Estilos CSS Inline Dinâmicos)
Aplica estilos CSS dinâmicos:
```html
<p [ngStyle]="{ 'color': corEscolhida, 'font-size.px': tamanhoFonte }">
  Texto com estilo customizado
</p>
```
*(Também é possível usar Property Binding direto: `[style.color]="corEscolhida"` ou `[class.ativo]="estaAtivo"`).*

---

## 💡 7. Perguntas e Pegadinhas Típicas de Prova

1. **Qual a diferença entre SPA e páginas tradicionais?**
   - Na SPA, o servidor entrega um único arquivo `index.html` e os scripts JS. As mudanças de tela acontecem trocando componentes no DOM via JavaScript e Roteamento (`<router-outlet>`), sem recarregar toda a página do servidor.
2. **Qual a diferença entre `href` e `routerLink` no Angular?**
   - O `href` força o navegador a recarregar toda a página (quebrando a experiência SPA). O `routerLink` intercepta a navegação e faz o Angular renderizar o novo componente internamente sem recarregar a página.
3. **Qual módulo é obrigatório para usar `[(ngModel)]`?**
   - O `FormsModule` (importado de `@angular/forms`).
4. **Qual a diferença entre Diretiva Estrutural e de Atributo?**
   - A **estrutural** altera a árvore do DOM adicionando ou removendo elementos (`@if`, `@for`, `*ngIf`, `*ngFor`). A **de atributo** altera a aparência ou comportamento de um elemento existente no DOM (`ngClass`, `ngStyle`, `disabled`).
5. **Para que servem o `@Input()` e o `@Output()`?**
   - `@Input()` recebe dados passados pelo componente pai.
   - `@Output()` emite eventos customizados (`EventEmitter`) para notificar o componente pai sobre ações executadas no filho.
6. **O que é o `$event` no Event Binding?**
   - É o objeto contendo as informações enviadas pelo evento disparado (ex: o valor digitado, dados do clique ou o valor emitido pelo `@Output`).
