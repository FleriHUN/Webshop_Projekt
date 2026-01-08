import { Routes } from '@angular/router';
import { HomeComponent } from './home/home';
import { RegisterComponent } from './auth/register/register';
import { LoginComponent } from './auth/login/login';
import { ForgotPasswordComponent } from './auth/forgot-password/forgot-password';

export const routes: Routes = [
  { path: '', component: HomeComponent },
  { path: 'register', component: RegisterComponent },
  { path: 'login', component: LoginComponent },
  { path: 'forgot-password', component: ForgotPasswordComponent },
  { path: '**', redirectTo: '' }
];
