import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Brand } from '../model/brand.model';

@Injectable({
  providedIn: 'root',
})
export class BrandService {
  baseUrl: string = "http://localhost:8080/brand"
  private http = inject(HttpClient)

  getAllBrand(): Observable<Brand> {
    return this.http.get<Brand>(`${this.baseUrl}`)
  }

  addBrand(newBrand: Brand) {
    return this.http.post(`${this.baseUrl}`, newBrand)
  }

  updateBrand(updatedBrand: Brand) {
    return this.http.put(`${this.baseUrl}`, updatedBrand)
  }

  deleteBrand(id: number) {
    return this.http.delete(`${this.baseUrl}/${id}`)
  }
}
