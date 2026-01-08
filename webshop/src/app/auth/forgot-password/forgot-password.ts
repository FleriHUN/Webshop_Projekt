import { Component, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterLink } from '@angular/router';
import { AuthService } from '../auth.service';

@Component({
  selector: 'app-forgot-password',
  imports: [CommonModule, FormsModule, RouterLink],
  templateUrl: './forgot-password.html',
  styleUrl: './forgot-password.css'
})
export class ForgotPasswordComponent {
  email = '';
  isLoading = signal(false);
  message = signal<{ type: 'success' | 'error'; text: string } | null>(null);
  emailSent = signal(false);

  constructor(private authService: AuthService) {}

  onSubmit(): void {
    this.message.set(null);

    if (!this.email) {
      this.message.set({ type: 'error', text: 'Kérlek add meg az e-mail címed!' });
      return;
    }

    if (!this.isValidEmail(this.email)) {
      this.message.set({ type: 'error', text: 'Érvénytelen e-mail cím!' });
      return;
    }

    this.isLoading.set(true);

    setTimeout(() => {
      const result = this.authService.requestPasswordReset(this.email);
      this.isLoading.set(false);
      
      if (result.success) {
        this.emailSent.set(true);
        this.message.set({ type: 'success', text: result.message });
      } else {
        this.message.set({ type: 'error', text: result.message });
      }
    }, 800);
  }

  private isValidEmail(email: string): boolean {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
  }
}
