import { Component, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { AuthService } from '../auth.service';

@Component({
  selector: 'app-login',
  imports: [CommonModule, FormsModule, RouterLink],
  templateUrl: './login.html',
  styleUrl: './login.css'
})
export class LoginComponent {
  formData = {
    email: '',
    password: ''
  };

  isLoading = signal(false);
  message = signal<{ type: 'success' | 'error'; text: string } | null>(null);
  showPassword = signal(false);

  constructor(
    private authService: AuthService,
    private router: Router
  ) {}

  togglePasswordVisibility(): void {
    this.showPassword.set(!this.showPassword());
  }

  onSubmit(): void {
    this.message.set(null);

    if (!this.formData.email || !this.formData.password) {
      this.message.set({ type: 'error', text: 'Kérlek töltsd ki az összes mezőt!' });
      return;
    }

    this.isLoading.set(true);

    setTimeout(() => {
      const result = this.authService.login({
        email: this.formData.email,
        password: this.formData.password
      });

      this.isLoading.set(false);

      if (result.success) {
        this.message.set({ type: 'success', text: result.message });
      } else {
        this.message.set({ type: 'error', text: result.message });
      }
    }, 800);
  }
}
