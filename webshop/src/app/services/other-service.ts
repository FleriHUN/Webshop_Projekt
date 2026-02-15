import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { AddressType } from '../model/addressType.model';
import { PaymentMethod } from '../model/paymentMethod.model';

@Injectable({
  providedIn: 'root',
})
export class OtherService {
  private http = inject(HttpClient)
  baseUrl: string = "http://localhost:8080"

  getAllAddressType(): Observable<AddressType[]> {
    return this.http.get<AddressType[]>(`${this.baseUrl}/addressType`)
  }

  getAllPaymentMethod(): Observable<PaymentMethod[]> {
    return this.http.get<PaymentMethod[]>(`${this.baseUrl}/paymentMethods`)
  }
}
