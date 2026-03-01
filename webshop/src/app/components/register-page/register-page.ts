import { Component, inject, OnInit } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { UserService } from '../../services/user-service';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { User } from '../../model/user.model';

@Component({
  selector: 'app-register-page',
  imports: [ReactiveFormsModule, RouterLink],
  templateUrl: './register-page.html',
  styleUrl: './register-page.css',
})
export class RegisterPage implements OnInit {
  private router = inject(Router)
  private userService = inject(UserService)
  registerForm!: FormGroup

  ngOnInit(): void {
    this.registerForm = new FormGroup({
      username: new FormControl("", [Validators.required]),
      email: new FormControl("", [Validators.required, Validators.email]),
      phone: new FormControl("", [Validators.required]),
      password: new FormControl("", [Validators.required, Validators.minLength(8), Validators.maxLength(16)]),
      passwordAgain: new FormControl("", [Validators.required,  Validators.minLength(8), Validators.maxLength(16)])
    })
  }

  sendRegister() {
    this.userService.register(new User(
      null,
      this.registerForm.controls["username"].value,
      this.registerForm.controls["email"].value,
      this.registerForm.controls["phone"].value,
      this.registerForm.controls["password"].value,
    )).subscribe({
      next: response => {
        this.router.navigate(["/login"])
      }
    })
  }
}
