import { Routes } from '@angular/router';
import { CatalogoFilmes } from './CatalogoFilmes/catalogo-filmes';

export const routes: Routes = [
  { path: '', component: CatalogoFilmes },
  { path: 'catalogo', component: CatalogoFilmes },
  { path: '**', redirectTo: '' },
];
