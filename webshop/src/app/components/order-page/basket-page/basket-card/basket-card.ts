import { Component, inject, input, output } from '@angular/core';
import { CartProduct } from '../../../../model/cartProduct.model';
import { BasketService } from '../../../../services/basket-service';
import { UserService } from '../../../../services/user-service';

@Component({
  selector: 'app-basket-card',
  imports: [],
  templateUrl: './basket-card.html',
  styleUrl: './basket-card.css',
})
export class BasketCard {
  cartProduct = input.required<CartProduct>()
  cartService = inject(BasketService)
  userService = inject(UserService)
  changeAmount = output<number>()

  changeAmountOfProduct(plusValue: 1 | -1) {
    this.cartService.changeAmountOfProduct(this.userService.loggedUser?.id!, {productId: this.cartProduct().id!, newAmount: this.cartProduct().amount + plusValue}).subscribe({
      next: response => {
        if (this.cartProduct().amount + plusValue === 0) {
          this.cartService.usersCart.cartProductList = this.cartService.usersCart.cartProductList?.filter((cp) => cp.id != this.cartProduct().id)
        } else {
          this.changeAmount.emit(this.cartProduct().amount + plusValue)
        }
      }
    })
  }

  deleteProductFromBasket() {
    this.cartService.deleteProduct(this.cartProduct().id!, this.userService.loggedUser?.id!).subscribe({
      next: response => {
        this.cartService.usersCart.cartProductList = this.cartService.usersCart.cartProductList?.filter((cp) => cp.id != this.cartProduct().id)
      }
    })
  }
}
