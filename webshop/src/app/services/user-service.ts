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
  private baseUrl = 'http://localhost:8080/user';

  login(username: string, password:string): Observable<User> {
    return this.http.post<User>(`${this.baseUrl}/login`, {username: username, password: password})
  }

  register(newUser: User) {
    return this.http.post(`${this.baseUrl}/register`, newUser)
  }

  getAllUser(): Observable<User[]> {
    return this.http.get<User[]>(this.baseUrl)
  }

  deleteUser(id: number) {
    return this.http.delete(`${this.baseUrl}/${id}`)
  }

  updateUser(id: number, email: string, username: string): Observable<User> {
    return this.http.patch<User>(`${this.baseUrl}/${id}`, {email: email, username: username})
  }
}
