import { inject, Injectable } from '@angular/core';
import { User } from '../model/user.model';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class UserService {
  http = inject(HttpClient)
  loggedUser: User | null = null
  private baseUrl = 'http://localhost:8080/users';

  login(username: string, password:string): Observable<User> {
    return this.http.post<User>(`${this.baseUrl}/login`, {username: username, password: password})
  }

  register(newUser: User) {
    return this.http.post(`${this.baseUrl}/register`, newUser)
  }
}
