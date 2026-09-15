import { Routes } from '@angular/router';
import { Home } from './Home/home';
import { Sobre } from './Sobre/sobre';
import { Login } from './Login/login';
import { Contato } from './Contato/contato';
import { CatalogoFilmes } from './CatalogoFilmes/catalogo-filmes';

export const routes: Routes = [
  { path: '', component: CatalogoFilmes },
  { path: 'catalogo', component: CatalogoFilmes },
  { path: 'home', component: Home },
  { path: 'sobre', component: Sobre },
  { path: 'login', component: Login },
  { path: 'contato', component: Contato },
  { path: '**', redirectTo: '' },
];