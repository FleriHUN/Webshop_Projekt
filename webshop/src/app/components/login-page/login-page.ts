import { Component, inject, OnInit } from '@angular/core';
import { FormControl, FormGroup, ReactiveFormsModule, } from '@angular/forms';
import { UserService } from '../../services/user-service';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-login-page',
  imports: [ReactiveFormsModule, RouterModule],
  templateUrl: './login-page.html',
  styleUrl: './login-page.css',
})
export class LoginPage implements OnInit{
  userService = inject(UserService)
  loginForm!: FormGroup

  ngOnInit(): void {
    this.loginForm = new FormGroup({
      username: new FormControl("", []),
      password: new FormControl("", [])
    })
  }

  sendLogin() {
    this.userService.login(this.loginForm.controls["username"].value, this.loginForm.controls["password"].value)
  }
}
