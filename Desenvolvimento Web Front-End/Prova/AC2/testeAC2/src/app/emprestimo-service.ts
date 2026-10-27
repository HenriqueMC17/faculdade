import { Injectable } from '@angular/core';
import { Emprestimo } from './emprestimo';

@Injectable({
  providedIn: 'root'
})
export class EmprestimoService {
  private emprestimos: Emprestimo[] = [];

  listar(): Emprestimo[] {
    return [...this.emprestimos];
  }

  adicionar(emprestimo: Emprestimo): void {
    const novo: Emprestimo = {
      ...emprestimo,
      id: Date.now().toString() + Math.random().toString(36).substr(2, 5),
      devolvido: false
    };
    this.emprestimos.push(novo);
  }

  remover(id: string): void {
    this.emprestimos = this.emprestimos.filter(e => e.id !== id);
  }

  registrarDevolucao(id: string): void {
    const emp = this.emprestimos.find(e => e.id === id);
    if (emp) {
      emp.devolvido = true;
    }
  }

  registrarDevolução(id: string): void {
    this.registrarDevolucao(id);
  }
}
