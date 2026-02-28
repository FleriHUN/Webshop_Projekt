import { Component, inject } from '@angular/core';
import { BasketService } from '../../services/basket-service';
import { UserService } from '../../services/user-service';
import { BasketCard } from './basket-card/basket-card';

@Component({
  selector: 'app-basket-page',
  imports: [BasketCard],
  templateUrl: './basket-page.html',
  styleUrl: './basket-page.css',
})
export class BasketPage {
  cartService = inject(BasketService)
  userService = inject(UserService)

  ngOnInit(): void {
    this.cartService.getBasketByUserId(11).subscribe({
      next: response => {
        this.cartService.usersCart = response
      },
    })
  }

  changeAmount(newAmount: number, index: number) {
    const searchedProduct = this.cartService.usersCart.cartProductList![index]
    searchedProduct.amount = newAmount
    this.cartService.usersCart.cartProductList[index] = searchedProduct
  }

  clearBasket() {

  }
}
