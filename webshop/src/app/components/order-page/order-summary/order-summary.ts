import { Component, inject, OnInit } from '@angular/core';
import { OtherService } from '../../../services/other-service';
import { PaymentMethod } from '../../../model/paymentMethod.model';
import { OrderService } from '../../../services/order-service';
import { BasketService } from '../../../services/basket-service';
import { UserService } from '../../../services/user-service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-order-summary',
  imports: [],
  templateUrl: './order-summary.html',
  styleUrl: './order-summary.css',
})
export class OrderSummary implements OnInit{
   orderService = inject(OrderService)
  cartService = inject(BasketService)
  userService = inject(UserService)
  transportAddress: string = ""
  billingAddress: string = ""
  router = inject(Router)

  ngOnInit(): void {
    this.transportAddress = this.orderService.actualOrder.orderTransportDetail?.postCode + " " + this.orderService.actualOrder.orderTransportDetail?.town + this.orderService.actualOrder.orderTransportDetail?.address + this.orderService.actualOrder.orderTransportDetail?.houseNumber
    this.billingAddress = this.orderService.actualOrder.orderBillingDetail?.postCode + " " + this.orderService.actualOrder.orderBillingDetail?.town + this.orderService.actualOrder.orderBillingDetail?.address + this.orderService.actualOrder.orderBillingDetail?.houseNumber
  }

  sendOrder() {
    this.orderService.actualOrder.orderUser = this.userService.loggedUser!
    this.orderService.sendOrder(this.cartService.usersCart.id!).subscribe({
      next: response => console.log(response),
      complete: () => {
        this.router.navigate(["/homePage"])
      }
    })
  }
}
