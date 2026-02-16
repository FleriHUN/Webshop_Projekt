import { Component, inject, OnInit } from '@angular/core';
import { OtherService } from '../../../services/other-service';
import { PaymentMethod } from '../../../model/paymentMethod.model';
import { OrderService } from '../../../services/order-service';

@Component({
  selector: 'app-order-summary',
  imports: [],
  templateUrl: './order-summary.html',
  styleUrl: './order-summary.css',
})
export class OrderSummary implements OnInit{
  otherService = inject(OtherService)
  orderService = inject(OrderService)
  paymentMethods: PaymentMethod[] = []

  ngOnInit(): void {

  }
}
