import { Component, EventEmitter, Output } from '@angular/core';
import { FormsModule, NgForm } from '@angular/forms';
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

  @Output() emprestimoAdicionado = new EventEmitter<void>();

  constructor(private emprestimoService: EmprestimoService) {}

  onSubmit(form?: NgForm): void {
    if (!this.nomePessoa || !this.tituloLivro || !this.dataPrevistaDevolucao) {
      return;
    }

    const novo: Emprestimo = {
      nomePessoa: this.nomePessoa.trim(),
      tituloLivro: this.tituloLivro.trim(),
      dataPrevistaDevolucao: this.dataPrevistaDevolucao,
      devolvido: false
    };

    this.emprestimoService.adicionar(novo);
    this.emprestimoAdicionado.emit();

    if (form) {
      form.resetForm();
    }
    this.nomePessoa = '';
    this.tituloLivro = '';
    this.dataPrevistaDevolucao = '';
  }
}
