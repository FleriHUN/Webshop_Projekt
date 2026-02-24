import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Cart } from '../model/cart.model';
import { CartProduct } from '../model/cartProduct.model';

@Injectable({
  providedIn: 'root',
})
export class BasketService {
  private baseUrl = "http://localhost:8080/basket"
  private http = inject(HttpClient)
  usersBasket!: Cart

  getBasketByUserId(userId: number): Observable<Cart> {
    return this.http.get<Cart>(`${this.baseUrl}/user/${userId}`)
  }

  deleteProduct(basketProductId: number, basketId: number) {
    return this.http.delete(`${this.baseUrl}/book?basketProductId=${basketProductId}&basketId=${basketId}`)
  }

  changeAmountOfProduct(basketId: number, body: { productId: number, newAmount: number }): Observable<CartProduct> {
    return this.http.patch<CartProduct>(`${this.baseUrl}/${basketId}`, body)
  }

  addProductToBasket(basketId: number, body: { productId: number, amount: number }) {
    return this.http.post(`${this.baseUrl}/${basketId}`, body)
  }

  clearBasket(basketId: number) {
    return this.http.delete(`${this.baseUrl}/${basketId}/clear`)
  }
}
