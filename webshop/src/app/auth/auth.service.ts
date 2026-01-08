import { Injectable, signal } from '@angular/core';
import { Router } from '@angular/router';

export interface User {
  id?: number;
  username: string;
  email: string;
  phone: string;
  pfp_path?: string;
  is_admin?: boolean;
  last_login?: Date;
  register_at?: Date;
}

export interface RegisterData {
  username: string;
  email: string;
  phone: string;
  password: string;
}

export interface LoginData {
  email: string;
  password: string;
}

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private users: Map<string, { user: User; password: string }> = new Map();
  private currentUser = signal<User | null>(null);
  private resetTokens: Map<string, string> = new Map();
  
  isAuthenticated = signal(false);

  constructor(private router: Router) {
    // Test users from database
    this.users.set('test1@gmail.com', {
      user: { id: 1, username: 'test1', email: 'test1@gmail.com', phone: '06710000000', is_admin: true },
      password: 'test5.Asd'
    });
    this.users.set('test2@gmail.com', {
      user: { id: 2, username: 'test2', email: 'test2@gmail.com', phone: '06701000000', is_admin: false },
      password: 'test2'
    });
  }

  register(data: RegisterData): { success: boolean; message: string } {
    if (this.users.has(data.email)) {
      return { success: false, message: 'Ez az e-mail cím már regisztrálva van!' };
    }

    const user: User = {
      username: data.username,
      email: data.email,
      phone: data.phone,
      pfp_path: '',
      is_admin: false,
      register_at: new Date()
    };

    this.users.set(data.email, { user, password: data.password });
    return { success: true, message: 'Sikeres regisztráció!' };
  }

  login(data: LoginData): { success: boolean; message: string } {
    const userData = this.users.get(data.email);
    
    if (!userData) {
      return { success: false, message: 'Nem található felhasználó ezzel az e-mail címmel!' };
    }

    if (userData.password !== data.password) {
      return { success: false, message: 'Hibás jelszó!' };
    }

    userData.user.last_login = new Date();
    this.currentUser.set(userData.user);
    this.isAuthenticated.set(true);
    return { success: true, message: 'Sikeres bejelentkezés!' };
  }

  requestPasswordReset(email: string): { success: boolean; message: string } {
    if (this.users.has(email)) {
      const token = Math.random().toString(36).substring(2, 15);
      this.resetTokens.set(token, email);
      console.log(`Password reset token for ${email}: ${token}`);
    }
    
    return { success: true, message: 'Ha az e-mail cím létezik, elküldtük a visszaállítási linket!' };
  }

  resetPassword(token: string, newPassword: string): { success: boolean; message: string } {
    const email = this.resetTokens.get(token);
    
    if (!email) {
      return { success: false, message: 'Érvénytelen vagy lejárt token!' };
    }

    const userData = this.users.get(email);
    if (userData) {
      this.users.set(email, { ...userData, password: newPassword });
      this.resetTokens.delete(token);
      return { success: true, message: 'Jelszó sikeresen megváltoztatva!' };
    }

    return { success: false, message: 'Hiba történt!' };
  }

  logout(): void {
    this.currentUser.set(null);
    this.isAuthenticated.set(false);
    this.router.navigate(['/login']);
  }

  getCurrentUser(): User | null {
    return this.currentUser();
  }
}