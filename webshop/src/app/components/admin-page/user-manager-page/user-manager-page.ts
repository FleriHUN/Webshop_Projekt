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

  }

  deleteUser(id: number) {

  }
}
