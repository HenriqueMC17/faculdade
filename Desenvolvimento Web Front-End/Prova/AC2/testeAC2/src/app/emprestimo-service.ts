import { Injectable, signal } from '@angular/core';
import { Emprestimo } from './emprestimo';

@Injectable({
  providedIn: 'root'
})

export class EmprestimoService {
  private emprestimosSignal = signal<Emprestimo[]>([]);

  listar(): Emprestimo[] {
    return this.emprestimosSignal();
  }

  adicionar(emprestimo: Emprestimo): void {
    const novo: Emprestimo = {
      ...emprestimo,
      id: Date.now().toString() + Math.random().toString(36).substring(2, 7),
      devolvido: false
    };
    this.emprestimosSignal.update(lista => [...lista, novo]);
  }

  remover(id: string): void {
    this.emprestimosSignal.update(lista => lista.filter(e => e.id !== id));
  }

  registrarDevolucao(id: string): void {
    this.emprestimosSignal.update(lista =>
      lista.map(e => e.id === id ? { ...e, devolvido: true } : e)
    );
  }

  registrarDevolução(id: string): void {
    this.registrarDevolucao(id);
  }
}
