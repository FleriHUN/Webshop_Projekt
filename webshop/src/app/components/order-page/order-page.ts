import { Component, inject, OnInit } from '@angular/core';
import { RouterModule } from '@angular/router';
import { BasketService } from '../../services/basket-service';

@Component({
  selector: 'app-order-page',
  imports: [RouterModule],
  templateUrl: './order-page.html',
  styleUrl: './order-page.scss',
})
export class OrderPage implements OnInit{
  cartService = inject(BasketService)
  sumPrice: number = 0

  ngOnInit(): void {
    this.cartService.usersCart?.cartProductList.forEach(product => {
      this.sumPrice += (product.amount * product.cartProduct.price)
    })
  }
}
