import { Component, inject, OnInit } from '@angular/core';
import { User } from '../../../model/user.model';
import { UserService } from '../../../services/user-service';

@Component({
  selector: 'app-user-manager-page',
  imports: [],
  templateUrl: './user-manager-page.html',
  styleUrl: './user-manager-page.css',
})
export class UserManagerPage implements OnInit{
  private userService = inject(UserService)
  users: User[] = []

  ngOnInit(): void {
    this.userService.getAllUser().subscribe({
      next: response => {
        console.log(response)
        this.users = response
      }
    })
  }

  deleteUser(id: number) {
    this.userService.deleteUser(id).subscribe({
      next: response => {
        this.users = this.users.filter(u => u.id !== id)
      }
    })
  }
}
