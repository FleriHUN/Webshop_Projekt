import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Category } from '../model/category.model';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class CategoryService {
  http = inject(HttpClient)
  baseUrl: string = "http://localhost:8080/category"

  getAllParentCategories(): Observable<Category[]> {
    return this.http.get<Category[]>(`${this.baseUrl}/parents`)
  }

  getAllSubCategoryOfParentCategory(id: number) {
    return this.http.get<Category[]>(`${this.baseUrl}/sub/${id}`)
  }

  addCategory(newCategory: Category) {
    return this.http.post(this.baseUrl, newCategory)
  }

  deleteCategory(id: number) {
    return this.http.delete(`${this.baseUrl}/${id}`)
  }

  updateCategory(updatedCategory: Category) {
    return this.http.put(this.baseUrl, updatedCategory)
  }

  getAllCategory(): Observable<Category[]> {
    return this.http.get<Category[]>(this.baseUrl)
  }
}
