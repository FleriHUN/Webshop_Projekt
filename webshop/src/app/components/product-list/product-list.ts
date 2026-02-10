import { Component, inject, OnInit } from '@angular/core';
import { ProductCard } from '../product-card/product-card';
import { ActivatedRoute } from '@angular/router';
import { ProductService } from '../../services/product-service';
import { Product } from '../../model/product.model';

@Component({
  selector: 'app-product-list',
  imports: [ProductCard],
  templateUrl: './product-list.html',
  styleUrl: './product-list.css',
})
export class ProductList implements OnInit{
  route = inject(ActivatedRoute)
  productService = inject(ProductService)
  productList: Product[] = []

  ngOnInit(): void {
    this.route.params.subscribe({
      next: response => {
        let categoryId: number = response["category"]
        this.productService.getProductsByCategory(categoryId).subscribe({
          next: response => this.productList = response
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
}
