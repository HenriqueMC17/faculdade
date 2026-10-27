import { Component } from '@angular/core';
import { CadastrarEmprestimo } from './cadastrar-emprestimo/cadastrar-emprestimo';
import { ListaEmprestimos } from './lista-emprestimos/lista-emprestimos';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [CadastrarEmprestimo, ListaEmprestimos],
  styleUrl: './app.css',
  templateUrl: './app.html',
})
export class AppComponent {
  title = 'Sistema de Empréstimo de Livros';
}
