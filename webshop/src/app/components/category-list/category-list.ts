import { Component, inject, OnInit } from '@angular/core';
import { ProductService } from '../../services/product-service';
import { Category } from '../../model/category.model';
import { Router } from '@angular/router';

@Component({
  selector: 'app-category-list',
  imports: [],
  templateUrl: './category-list.html',
  styleUrl: './category-list.scss',
})
export class CategoryList implements OnInit{
  productService = inject(ProductService)
  categoryList: Category[] = []
  router = inject(Router)

  ngOnInit(): void {
    this.productService.getAllCategory().subscribe({
      next: response => this.categoryList = response
    })
  }

  getProductList(categoryId: number) {
    this.router.navigate(["productList", categoryId])
  }
}
