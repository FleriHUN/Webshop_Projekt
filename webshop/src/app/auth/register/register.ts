import { Component, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { AuthService } from '../auth.service';

@Component({
  selector: 'app-register',
  imports: [CommonModule, FormsModule, RouterLink],
  templateUrl: './register.html',
  styleUrl: './register.css'
})
export class RegisterComponent {
  formData = {
    username: '',
    email: '',
    phone: '',
    password: '',
    confirmPassword: ''
  };

  isLoading = signal(false);
  message = signal<{ type: 'success' | 'error'; text: string } | null>(null);
  showPassword = signal(false);
  showConfirmPassword = signal(false);

  constructor(
    private authService: AuthService,
    private router: Router
  ) {}

  togglePasswordVisibility(): void {
    this.showPassword.set(!this.showPassword());
  }

  toggleConfirmPasswordVisibility(): void {
    this.showConfirmPassword.set(!this.showConfirmPassword());
  }

  onSubmit(): void {
    this.message.set(null);

    if (!this.formData.username || !this.formData.username || 
        !this.formData.email || !this.formData.phone || 
        !this.formData.password || !this.formData.confirmPassword) {
      this.message.set({ type: 'error', text: 'Kérlek töltsd ki az összes mezőt!' });
      return;
    }

    if (!this.isValidEmail(this.formData.email)) {
      this.message.set({ type: 'error', text: 'Érvénytelen e-mail cím!' });
      return;
    }

    if (this.formData.password.length < 6) {
      this.message.set({ type: 'error', text: 'A jelszónak legalább 6 karakter hosszúnak kell lennie!' });
      return;
    }

    if (this.formData.password !== this.formData.confirmPassword) {
      this.message.set({ type: 'error', text: 'A jelszavak nem egyeznek!' });
      return;
    }

    this.isLoading.set(true);

    setTimeout(() => {
      const result = this.authService.register({
        username: this.formData.username,
        email: this.formData.email,
        phone: this.formData.phone,
        password: this.formData.password
      });

      this.isLoading.set(false);

      if (result.success) {
        this.message.set({ type: 'success', text: result.message });
        setTimeout(() => {
          this.router.navigate(['/login']);
        }, 1500);
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
