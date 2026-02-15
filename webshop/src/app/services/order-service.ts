import { inject, Injectable } from '@angular/core';
import { OrderHistory } from '../model/orderHistory.model';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root',
})
export class OrderService {
  newOrder!: OrderHistory
  http = inject(HttpClient)
  baseUrl: string = "http://localhost:8080/order"

  getOrderHistoryByUserId(userId: number): Observable<OrderHistory[]> {
    return this.http.get<OrderHistory[]>(`${this.baseUrl}/user/${userId}`)
  }

  cancelOrder(orderId: number) {
    return this.http.delete(`${this.baseUrl}/cancel/${orderId}`)
  }

  sendOrder(basketId: number, newOrder: OrderHistory) {
    return this.http.post(`${this.baseUrl}/baslet/${basketId}`, newOrder)
  }
}
