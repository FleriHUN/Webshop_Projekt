import { Component, inject, OnInit } from '@angular/core';
import { Product } from '../../../model/product.model';
import { ProductService } from '../../../services/product-service';

@Component({
  selector: 'app-product-manager-page',
  imports: [],
  templateUrl: './product-manager-page.html',
  styleUrl: './product-manager-page.css',
})
export class ProductManagerPage implements OnInit{
  products: Product[] = []
  private productService = inject(ProductService)

  ngOnInit(): void {

  }

  addProduct() {

  }

  deleteProduct() {

  }

  updateProduct() {

  }
}
