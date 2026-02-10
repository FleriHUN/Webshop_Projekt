import { Component, inject } from '@angular/core';
import { Router, RouterModule } from '@angular/router';
import { UserService } from '../../services/user-service';

@Component({
  selector: 'app-navbar',
  imports: [RouterModule],
  templateUrl: './navbar.html',
  styleUrl: './navbar.css',
})
export class Navbar {
  private router = inject(Router)
  private userService = inject(UserService)

  userIconNavigation() {
    if (this.userService.loggedUser == null) {
      this.router.navigate(["/login"])
    } else {
      this.router.navigate(["/profilPage"])
    }
  }

}
