import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { EmprestimoService } from '../emprestimo-service';
import { Emprestimo } from '../emprestimo';

@Component({
  selector: 'app-cadastrar-emprestimo',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './cadastrar-emprestimo.html',
  styleUrls: ['./cadastrar-emprestimo.css']
})
export class CadastrarEmprestimo {
  nomePessoa: string = '';
  tituloLivro: string = '';
  dataPrevistaDevolucao: string = '';

  constructor(private emprestimoService: EmprestimoService) {}

  onSubmit(): void {
    const novo: Emprestimo = {
      nomePessoa: this.nomePessoa,
      tituloLivro: this.tituloLivro,
      dataPrevistaDevolucao: this.dataPrevistaDevolucao,
      devolvido: false
    };
    this.emprestimoService.adicionar(novo);
    this.nomePessoa = '';
    this.tituloLivro = '';
    this.dataPrevistaDevolucao = '';
  }
}
