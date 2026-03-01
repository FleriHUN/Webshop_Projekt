import { Component, inject, OnInit } from '@angular/core';
import { ProductService } from '../../services/product-service';
import { Product } from '../../model/product.model';
import { ActivatedRoute, Router } from '@angular/router';
import { BasketService } from '../../services/basket-service';
import { UserService } from '../../services/user-service';

@Component({
  selector: 'app-product-details',
  imports: [],
  templateUrl: './product-details.html',
  styleUrl: './product-details.css',
})
export class ProductDetails implements OnInit {
  productService = inject(ProductService)
  selectedProduct!: Product
  private route = inject(ActivatedRoute)
  private router = inject(Router)
  private userService = inject(UserService)
  private basketService = inject(BasketService)

  ngOnInit(): void {
    this.route.params.subscribe({
      next: param => {
        const id: number = param["id"]
        this.productService.getProductById(id).subscribe({
          next: response => {
            this.selectedProduct = response
          }
        })
      }
    })
  }

  addToCart() {
    console.log("Add to Cart")
    this.basketService.addProductToBasket(this.userService.loggedUser?.id!, { productId: this.selectedProduct.id!, amount: 1 }).subscribe({
      next: response => console.log(response)
    })
  }
}
