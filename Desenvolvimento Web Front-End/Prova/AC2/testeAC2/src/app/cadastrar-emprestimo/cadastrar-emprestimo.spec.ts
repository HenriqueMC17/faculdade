import { ComponentFixture, TestBed } from '@angular/core/testing';
import { CadastrarEmprestimo } from './cadastrar-emprestimo';

describe('CadastrarEmprestimo', () => {
  let component: CadastrarEmprestimo;
  let fixture: ComponentFixture<CadastrarEmprestimo>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CadastrarEmprestimo],
    }).compileComponents();

    fixture = TestBed.createComponent(CadastrarEmprestimo);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
