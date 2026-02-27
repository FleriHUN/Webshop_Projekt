import { inject, Injectable } from '@angular/core';
import { OrderHistory } from '../model/orderHistory.model';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root',
})
export class OrderService {
   actualOrder: OrderHistory = new OrderHistory()
  http = inject(HttpClient)
  baseUrl: string = "http://localhost:8080/order"

  getOrderHistoryByUserId(userId: number): Observable<OrderHistory[]> {
    return this.http.get<OrderHistory[]>(`${this.baseUrl}/user/${userId}`)
  }

  cancelOrder(orderId: number): Observable<OrderHistory> {
    return this.http.delete<OrderHistory>(`${this.baseUrl}/cancel/${orderId}`)
  }

  sendOrder(cartId: number) {
    return this.http.post(`${this.baseUrl}/cart/${cartId}`, this.actualOrder)
  }

  getAllOrderHistory(): Observable<OrderHistory[]> {
    return this.http.get<OrderHistory[]>(this.baseUrl)
  }
}
