import { inject, Injectable } from "@angular/core";
import { ActivatedRouteSnapshot, CanActivate, RedirectCommand, Route, Router, RouterStateSnapshot, UrlSegment } from "@angular/router";
import { UserService } from "../services/user-service";

@Injectable({
  providedIn: "root"
})
export class AdminGuard implements CanActivate {
  userService = inject(UserService)
  private router = inject(Router)

  canActivate(route: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
    if (this.userService.loggedUser?.role?.name == "ROLE_admin") {
      return true;
    }

    return new RedirectCommand(this.router.parseUrl("/unauthorized"))
  }
}
