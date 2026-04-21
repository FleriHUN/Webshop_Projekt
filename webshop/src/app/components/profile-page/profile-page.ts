import { Component, inject, OnInit } from '@angular/core';
import { UserService } from '../../services/user-service';
import {
  FormControl,
  FormGroup,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { Router } from '@angular/router';
import { OrderHistoryCardComponent } from '../order-history-card/order-history-card.component';
import { OrderService } from '../../services/order-service';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-profil-page',
  imports: [ReactiveFormsModule, OrderHistoryCardComponent, CommonModule],
  templateUrl: './profile-page.html',
  styleUrl: './profile-page.css',
})
export class ProfilePage implements OnInit {
  userService = inject(UserService);
  private router = inject(Router);
  showInputs: boolean = false;
  showConfirmation: boolean = false;
  form!: FormGroup;
  orderService = inject(OrderService);

  ngOnInit(): void {
    console.log(this.userService.loggedUser);
    this.form = new FormGroup({
      email: new FormControl(this.userService.loggedUser?.email, [
        Validators.required,
        Validators.email,
      ]),
      username: new FormControl(this.userService.loggedUser?.username, [
        Validators.required,
      ]),
    });
  }

  handleUpdate() {
    if (this.showInputs) {
      this.sendUpdate();
    }
    this.showInputs = !this.showInputs;
  }

  sendUpdate() {
    this.userService
      .updateUser(
        this.userService.loggedUser!.id!,
        this.form.value.email,
        this.form.value.username,
      )
      .subscribe({
        next: (response) => (this.userService.loggedUser = response),
        complete: () => {
          this.showInputs = false;
        },
      });
  }

  deleteProfile() {
    this.userService.deleteUser(this.userService.loggedUser!.id!).subscribe({
      complete: () => {
        this.logout();
      },
    });
  }

  logout() {
    this.userService.loggedUser = null;
    this.router.navigate(['/']);
  }

  cancelOrder(id: number, index: number) {
    this.orderService.cancelOrder(id).subscribe({
      next: (response) => {
        this.userService.loggedUser!.orderHistoryList[index]! = response;
      },
    });
  }
}
