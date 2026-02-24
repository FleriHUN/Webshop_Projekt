import { Component, inject } from '@angular/core';
import { BasketService } from '../../../services/basket-service';
import { UserService } from '../../../services/user-service';

@Component({
  selector: 'app-basket-page',
  imports: [],
  templateUrl: './basket-page.html',
  styleUrl: './basket-page.css',
})
export class BasketPage {
  basketService = inject(BasketService)
  userService = inject(UserService)

  ngOnInit(): void {
    this.basketService.getBasketByUserId(11).subscribe({
      next: response => {
        this.basketService.usersBasket = response
      },
    })
  }

  // changeAmount(newAmount: number, index: number) {
  //   const searchedProduct = this.basketService.usersBasket.productList![index]
  //   searchedProduct.amount = newAmount
  //   this.basketService.usersBasket.![index] = searchedProduct
  // }

  clearBasket() {

  }
}
