import { Component, inject, OnInit } from '@angular/core';
import { OrderHistory } from '../../../model/orderHistory.model';
import { OrderService } from '../../../services/order-service';

@Component({
  selector: 'app-order-histories',
  imports: [],
  templateUrl: './order-histories.html',
  styleUrl: './order-histories.css',
})
export class OrderHistories implements OnInit{
  orderHistories: OrderHistory[] = []
  private orderService = inject(OrderService)

  ngOnInit(): void {

  }

  cancelOrder(id: number) {
    this.orderService.cancelOrder(id).subscribe({
      next: response => {

      }
    })
  }
}
