import { Component, inject, input, OnInit, output } from '@angular/core';
import { ProductService } from '../../services/product-service';
import { Category } from '../../model/category.model';
import { Router } from '@angular/router';

@Component({
  selector: 'app-category-list',
  imports: [],
  templateUrl: './category-list.html',
  styleUrl: './category-list.css',
})
export class CategoryList{
  productService = inject(ProductService)
  categoryList = input.required<Category[]>()
  router = inject(Router)
  changeCategory = output<number>()

  changeList(categoryId: number) {
    this.changeCategory.emit(categoryId)
  }
}
