import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-catalogo-filmes',
  standalone: true,
  imports: [FormsModule],
  templateUrl: './catalogo-filmes.html',
  styleUrl: './catalogo-filmes.css',
})
export class CatalogoFilmes {
  // 1. Lista com pelo menos cinco filmes
  filmes: string[] = [
    'Interestelar',
    'O Poderoso Chefão',
    'Matrix',
    'Inception (A Origem)',
    'O Senhor dos Anéis: O Retorno do Rei'
  ];

  // 2. Variável para armazenar o filme selecionado
  filmeSelecionado: string = '';

  // 3. Variável para receber o nome de um novo filme
  novoFilme: string = '';

  // 4. Variável booleana para indicar se o filme foi marcado como favorito
  isFavorito: boolean = false;

  // 5. Contador de visualizações
  visualizacoes: number = 0;

  // Método para selecionar um filme e reiniciar favorito/visualizações
  selecionarFilme(filme: string): void {
    this.filmeSelecionado = filme;
    this.isFavorito = false;
    this.visualizacoes = 0;
  }

  // Método para adicionar um novo filme à lista
  adicionarFilme(): void {
    const nome = this.novoFilme.trim();
    if (nome) {
      this.filmes.push(nome);
      this.novoFilme = ''; // Limpa o campo
    }
  }

  // Método para alternar entre favorito e não-favorito
  alternarFavorito(): void {
    this.isFavorito = !this.isFavorito;
  }

  // Método para incrementar o contador de visualizações
  aumentarVisualizacoes(): void {
    this.visualizacoes++;
  }
}
