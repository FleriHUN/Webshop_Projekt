import { Component, inject, OnInit } from '@angular/core';
import { Product } from '../../../model/product.model';
import { ProductService } from '../../../services/product-service';
import { FormGroup, ReactiveFormsModule } from '@angular/forms';
import { AdminProductCardComponent } from './admin-product-card/admin-product-card.component';
import { ProductCreatorComponent } from './product-creator/product-creator.component';

@Component({
  selector: 'app-product-manager-page',
  imports: [ReactiveFormsModule, AdminProductCardComponent, ProductCreatorComponent],
  templateUrl: './product-manager-page.html',
  styleUrl: './product-manager-page.css',
})
export class ProductManagerPage implements OnInit {
  private productService = inject(ProductService);
  products: Product[] = [];
  showCreator: boolean = false

  ngOnInit(): void {
    this.productService.getAllProduct().subscribe({
      next: (response) => {
        this.products = response;
      },
    });
  }

  deleteProduct(id: number, index: number) {
    this.productService.deleteProduct(id).subscribe({
      next: () => {
        this.products.splice(index, 1);
      },
    });
  }

  addProduct(product: Product) {
    this.showCreator = false
    this.products.push(product)
  }

}
