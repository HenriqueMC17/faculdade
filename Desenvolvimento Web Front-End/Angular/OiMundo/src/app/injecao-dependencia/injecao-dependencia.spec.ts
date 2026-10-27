import { ComponentFixture, TestBed } from '@angular/core/testing';
import { InjecaoDependencia } from './injecao-dependencia';

describe('InjecaoDependencia', () => {
  let component: InjecaoDependencia;
  let fixture: ComponentFixture<InjecaoDependencia>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [InjecaoDependencia],
    }).compileComponents();

    fixture = TestBed.createComponent(InjecaoDependencia);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
