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
export class OrderSummary implements OnInit {
  orderService = inject(OrderService)
  cartService = inject(BasketService)
  userService = inject(UserService)
  transportAddress: string = ""
  billingAddress: string = ""
  router = inject(Router)

  isSending: boolean = false
  errorMessage: string = ""

  ngOnInit(): void {
    this.transportAddress = this.orderService.actualOrder.orderTransportDetail?.postCode + " " + this.orderService.actualOrder.orderTransportDetail?.town + this.orderService.actualOrder.orderTransportDetail?.address + this.orderService.actualOrder.orderTransportDetail?.houseNumber
    this.billingAddress = this.orderService.actualOrder.orderBillingDetail?.postCode + " " + this.orderService.actualOrder.orderBillingDetail?.town + this.orderService.actualOrder.orderBillingDetail?.address + this.orderService.actualOrder.orderBillingDetail?.houseNumber
  }

  sendOrder() {
    if (this.isSending) return;

    if (!this.userService.loggedUser?.id) {
      this.errorMessage = "Nem vagy bejelentkezve. Kérjük jelentkezz be újra."
      return;
    }
    if (!this.cartService.usersCart?.id) {
      this.errorMessage = "A kosár nem érhető el. Frissítsd az oldalt."
      return;
    }
    if (!this.orderService.actualOrder.paymentMethod?.id) {
      this.errorMessage = "Hiányzó fizetési mód. Lépj vissza és válassz egyet."
      return;
    }

    this.errorMessage = ""
    this.isSending = true
    this.orderService.actualOrder.orderUser = this.userService.loggedUser

    this.orderService.sendOrder(this.cartService.usersCart.id).subscribe({
      next: response => {
        console.log("Rendelés sikeresen elküldve:", response)
        this.isSending = false
        this.router.navigate(["/homePage"])
      },
      error: err => {
        console.error("Hiba a rendelés küldésekor:", err)
        this.isSending = false

        const backendMessage = err?.error;
        if (err.status === 0) {
          this.errorMessage = "Nem érhető el a szerver. Fut a backend?"
        } else if (err.status === 401 || err.status === 403) {
          this.errorMessage = "Nincs jogosultságod. Jelentkezz be újra."
        } else if (backendMessage === "userNotFound") {
          this.errorMessage = "A felhasználó nem található."
        } else if (backendMessage === "paymentMethodNotFound" || backendMessage === "missingPaymentMethod") {
          this.errorMessage = "Érvénytelen fizetési mód."
        } else if (backendMessage === "basketNotFound") {
          this.errorMessage = "A kosár nem található."
        } else if (backendMessage === "emptyBasket") {
          this.errorMessage = "A kosár üres."
        } else if (backendMessage === "invalidEmail") {
          this.errorMessage = "Érvénytelen e-mail cím."
        } else {
          this.errorMessage = "Hiba történt a rendelés feldolgozása során. Próbáld újra később."
        }
      }
    })
  }
}
