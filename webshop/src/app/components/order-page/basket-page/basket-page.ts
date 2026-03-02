import { Component, inject } from '@angular/core';
import { BasketService } from '../../../services/basket-service';
import { UserService } from '../../../services/user-service';
import { BasketCard } from './basket-card/basket-card';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-basket-page',
  imports: [BasketCard, RouterModule],
  templateUrl: './basket-page.html',
  styleUrl: './basket-page.css',
})
export class BasketPage {
  cartService = inject(BasketService)
  userService = inject(UserService)

  ngOnInit(): void {
    this.cartService.getBasketByUserId(this.userService.loggedUser?.id!).subscribe({
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
