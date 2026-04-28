import { inject, Injectable } from '@angular/core';
import { User } from '../model/user.model';
import { HttpClient, HttpParams } from '@angular/common/http';
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

  sendVerificationCode(email: string): Observable<any> {
    const params = new HttpParams().set('email', email);
    return this.http.get(`${this.baseUrl}/vCode`, { params })
  }

  checkVerificationCode(vCode: string, email: string): Observable<any> {
    return this.http.post(`${this.baseUrl}/check`, { vCode: vCode, email: email })
  }

  changePassword(email: string, newPassword: string): Observable<any> {
    return this.http.patch(`${this.baseUrl}/password`, { email: email, newPassword: newPassword })
  }
}
