import { Component, inject, input, output } from '@angular/core';
import { OrderHistory } from '../../model/orderHistory.model';

@Component({
  selector: 'app-order-history-card',
  imports: [],
  templateUrl: './order-history-card.component.html',
  styleUrl: './order-history-card.component.css',
})
export class OrderHistoryCardComponent {
  orderHistory = input.required<OrderHistory>();
  cancel = output<number>()
  expand: boolean = false

  cancelOrder(): void {
    this.cancel.emit(this.orderHistory().id!)
  }


}
