import { Component, inject, OnInit } from '@angular/core';
import { Product } from '../../../model/product.model';
import { ProductService } from '../../../services/product-service';
import { FormGroup, ReactiveFormsModule } from '@angular/forms';

@Component({
  selector: 'app-product-manager-page',
  imports: [ReactiveFormsModule],
  templateUrl: './product-manager-page.html',
  styleUrl: './product-manager-page.css',
})
export class ProductManagerPage implements OnInit{
  products: Product[] = []
  private productService = inject(ProductService)
  editorForm!: FormGroup
  isEdit: boolean = false;

  ngOnInit(): void {
    this.productService.getAllProduct().subscribe({
      next: response => {
        this.products = response
      }
    })
  }



  addProduct() {

  }

  deleteProduct() {

  }

  updateProduct() {

  }
}
