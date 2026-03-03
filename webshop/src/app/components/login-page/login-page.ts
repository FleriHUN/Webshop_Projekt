import { Component, inject, OnInit } from '@angular/core';
import { FormControl, FormGroup, ReactiveFormsModule, Validators, } from '@angular/forms';
import { UserService } from '../../services/user-service';
import { Router, RouterModule } from '@angular/router';

@Component({
  selector: 'app-login-page',
  imports: [ReactiveFormsModule, RouterModule],
  templateUrl: './login-page.html',
  styleUrl: './login-page.css',
})
export class LoginPage implements OnInit{
  userService = inject(UserService)
  loginForm!: FormGroup
  private router = inject(Router)
  isError: boolean = false

  ngOnInit(): void {
    this.loginForm = new FormGroup({
      username: new FormControl("", [Validators.required]),
      password: new FormControl("", [Validators.required])
    })
  }

  sendLogin() {
    this.userService.login(this.loginForm.controls["username"].value, this.loginForm.controls["password"].value).subscribe({
      next: response => {
        this.userService.loggedUser = response
        console.log(response)
        console.log(this.userService.loggedUser)
        this.router.navigate([""])
      }, error: (error) => {
        this.isError = true
      }
    })
  }
}
