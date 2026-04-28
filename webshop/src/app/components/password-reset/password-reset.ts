import { Component, inject, OnInit } from '@angular/core';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { UserService } from '../../services/user-service';

@Component({
  selector: 'app-password-reset',
  imports: [ReactiveFormsModule, RouterLink],
  templateUrl: './password-reset.html',
  styleUrl: './password-reset.css',
})
export class PasswordReset implements OnInit {
  private userService = inject(UserService);
  private router = inject(Router);

  step: 1 | 2 | 3 = 1;
  email: string = '';
  isLoading: boolean = false;
  errorMessage: string = '';
  infoMessage: string = '';

  emailForm!: FormGroup;
  codeForm!: FormGroup;
  passwordForm!: FormGroup;

  ngOnInit(): void {
    this.emailForm = new FormGroup({
      email: new FormControl('', [Validators.required, Validators.email]),
    });

    this.codeForm = new FormGroup({
      vCode: new FormControl('', [Validators.required, Validators.minLength(10), Validators.maxLength(10)]),
    });

    this.passwordForm = new FormGroup({
      password: new FormControl('', [Validators.required, Validators.minLength(8), Validators.maxLength(16)]),
      passwordAgain: new FormControl('', [Validators.required, Validators.minLength(8), Validators.maxLength(16)]),
    });
  }

  sendVerificationCode(): void {
    if (this.emailForm.invalid) return;
    this.errorMessage = '';
    this.infoMessage = '';
    this.isLoading = true;
    const emailValue = this.emailForm.controls['email'].value;

    this.userService.sendVerificationCode(emailValue).subscribe({
      next: () => {
        this.email = emailValue;
        this.step = 2;
        this.infoMessage = 'Az ellenőrző kódot elküldtük az e-mail címére.';
        this.isLoading = false;
      },
      error: (err) => {
        if (err.status === 404) {
          this.errorMessage = 'Nem található felhasználó ezzel az e-mail címmel.';
        } else if (err.status === 422) {
          this.errorMessage = 'Hiányzó adat.';
        } else {
          this.errorMessage = 'Hiba történt. Kérjük, próbálja újra.';
        }
        this.isLoading = false;
      },
    });
  }

  verifyCode(): void {
    if (this.codeForm.invalid) return;
    this.errorMessage = '';
    this.infoMessage = '';
    this.isLoading = true;
    const vCode = this.codeForm.controls['vCode'].value;

    this.userService.checkVerificationCode(vCode, this.email).subscribe({
      next: (response: any) => {
        if (response === false) {
          this.errorMessage = 'Hibás ellenőrző kód.';
          this.isLoading = false;
        } else {
          this.step = 3;
          this.isLoading = false;
        }
      },
      error: () => {
        this.errorMessage = 'Hibás vagy érvénytelen kód.';
        this.isLoading = false;
      },
    });
  }

  changePassword(): void {
    if (this.passwordForm.invalid) return;
    const newPassword = this.passwordForm.controls['password'].value;
    const passwordAgain = this.passwordForm.controls['passwordAgain'].value;

    if (newPassword !== passwordAgain) {
      this.errorMessage = 'A két jelszó nem egyezik.';
      return;
    }

    this.errorMessage = '';
    this.infoMessage = '';
    this.isLoading = true;

    this.userService.changePassword(this.email, newPassword).subscribe({
      next: () => {
        this.isLoading = false;
        this.router.navigate(['/login']);
      },
      error: (err) => {
        if (err.status === 415 && err.error === 'invalidPassword') {
          this.errorMessage =
            'A jelszónak 8-16 karakter hosszúnak kell lennie, és tartalmaznia kell kis- és nagybetűt, számot és speciális karaktert.';
        } else if (err.status === 415 && err.error === 'invalidEmail') {
          this.errorMessage = 'Érvénytelen e-mail cím.';
        } else {
          this.errorMessage = 'Hiba történt a jelszó módosítása során.';
        }
        this.isLoading = false;
      },
    });
  }

  goBack(): void {
    this.errorMessage = '';
    this.infoMessage = '';
    if (this.step > 1) {
      this.step = (this.step - 1) as 1 | 2 | 3;
    }
  }
}
