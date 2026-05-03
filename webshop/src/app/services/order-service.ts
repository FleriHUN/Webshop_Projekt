import { inject, Injectable } from '@angular/core';
import { OrderHistory } from '../model/orderHistory.model';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { OrderDto } from '../model/orderDto.model';

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

  sendOrder(cartId: number, newOrder: OrderDto) {
    console.log(this.actualOrder)
    return this.http.post(`${this.baseUrl}/basket/${cartId}`, newOrder)
  }

  getAllOrderHistory(): Observable<OrderHistory[]> {
    return this.http.get<OrderHistory[]>(this.baseUrl)
  }
}
