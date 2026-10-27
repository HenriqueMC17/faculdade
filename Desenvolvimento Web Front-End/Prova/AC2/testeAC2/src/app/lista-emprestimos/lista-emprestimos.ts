import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { EmprestimoService } from '../emprestimo-service';
import { Emprestimo } from '../emprestimo';

@Component({
  selector: 'app-lista-emprestimos',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './lista-emprestimos.html',
  styleUrls: ['./lista-emprestimos.css']
})
export class ListaEmprestimos {
  constructor(private emprestimoService: EmprestimoService) {}

  get emprestimos(): Emprestimo[] {
    return this.emprestimoService.listar();
  }

  load(): void {
    // mantido para compatibilidade
  }

  remover(id: string): void {
    this.emprestimoService.remover(id);
  }

  registrarDevolucao(id: string): void {
    this.emprestimoService.registrarDevolucao(id);
  }

  get total(): number { return this.emprestimos.length; }
  get emAberto(): number { return this.emprestimos.filter(e => !e.devolvido).length; }
  get devolvidos(): number { return this.emprestimos.filter(e => e.devolvido).length; }
}
