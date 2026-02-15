import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Category } from '../model/category.model';
import { Product } from '../model/product.model';

@Injectable({
  providedIn: 'root',
})
export class ProductService {
    private http = inject(HttpClient)
    baseUrl = "http://localhost:8080/product"

    getAllCategory(): Observable<Category[]> {
      return this.http.get<Category[]>(`${this.baseUrl}/category`)
    }

    getProductsByCategory(id: number): Observable<Product[]> {
      return this.http.get<Product[]>(`${this.baseUrl}/category/${id}`)
    }

    getFirstThreeProduct(): Observable<Product[]> {
      return this.http.get<Product[]>(`${this.baseUrl}/homePage`)
    }

    addProduct(newProduct: Product) {
      return this.http.post(`${this.baseUrl}`, newProduct)
    }

    deleteProduct(productId: number) {
      return this.http.delete(`${this.baseUrl}/${productId}`)
    }

    updateProduct(updatedProduct: Product) {
      return this.http.put(this.baseUrl, updatedProduct)
    }
}
