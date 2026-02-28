import { Component, inject, OnInit } from '@angular/core';
import { ProductCard } from '../product-card/product-card';
import { ActivatedRoute } from '@angular/router';
import { ProductService } from '../../services/product-service';
import { Product } from '../../model/product.model';
import { CategoryList } from '../category-list/category-list';
import { Category } from '../../model/category.model';
import { CategoryService } from '../../services/category-service';

@Component({
  selector: 'app-product-list',
  imports: [ProductCard, CategoryList],
  templateUrl: './product-list.html',
  styleUrl: './product-list.css',
})
export class ProductList implements OnInit{
  route = inject(ActivatedRoute)
  productService = inject(ProductService)
  categoryService = inject(CategoryService)
  productList: Product[] = []
  subCategories: Category[] = []
  selectedSubCategoryId!: number

  ngOnInit(): void {
    this.route.params.subscribe({
      next: response => {
        let categoryId: number = response["category"]
        this.categoryService.getAllSubCategoryOfParentCategory(categoryId).subscribe({
          next: response => {
            this.subCategories = response
          },
          complete: () => {
            this.selectedSubCategoryId = this.subCategories[0].id
            this.productService.getProductsByCategory(this.selectedSubCategoryId).subscribe({
              next: response => this.productList = response
            })
          }
        })
      }
    })
  }


  getRows(): Product[][] {
    const rows: Product[][] = []

    for (let i = 0; i < this.productList.length; i+=3) {
      const row: Product[] = []
      for (let j = i; j < i+3; j++) {
        row.push(this.productList[j])
      }
      rows.push(row)
    }

    return rows;
  }

  changeCategory(id: number) {
    this.productService.getProductsByCategory(id).subscribe({
      next: response => this.productList = response
    })
  }
}
