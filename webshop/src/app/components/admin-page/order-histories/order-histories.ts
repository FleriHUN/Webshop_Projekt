import { Component, inject, OnInit } from '@angular/core';
import { OrderHistory } from '../../../model/orderHistory.model';
import { OrderService } from '../../../services/order-service';
import { OrderHistoryCardComponent } from '../../order-history-card/order-history-card.component';

@Component({
  selector: 'app-order-histories',
  imports: [OrderHistoryCardComponent],
  templateUrl: './order-histories.html',
  styleUrl: './order-histories.css',
})
export class OrderHistories implements OnInit{
  orderHistories: OrderHistory[] = []
  private orderService = inject(OrderService)

  ngOnInit(): void {
    this.orderService.getAllOrderHistory().subscribe({
      next: response => {
        this.orderHistories = response
      }
    })
  }

  cancelOrder(id: number, index:number) {
    this.orderService.cancelOrder(id).subscribe({
      next: response => {
        this.orderHistories[index] = response
      }
    })
  }
}
