import { Component, inject, input, OnInit, output } from '@angular/core';
import { OrderHistory } from '../../model/orderHistory.model';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-order-history-card',
  imports: [CommonModule],
  templateUrl: './order-history-card.component.html',
  styleUrl: './order-history-card.component.css',
})
export class OrderHistoryCardComponent implements OnInit {
  orderHistory = input.required<OrderHistory>();
  cancel = output<number>();
  expand: boolean = false;
  sumPrice: number = 0;
  billingAddress: string = '';
  transportAddress: string = '';

  ngOnInit(): void {
    this.orderHistory().products?.forEach((product) => {
      this.sumPrice += product.orderProduct.price * product.amount;
    });

    this.billingAddress = `${this.orderHistory().orderBillingDetail?.postCode} ${this.orderHistory().orderBillingDetail?.town} ${this.orderHistory().orderBillingDetail?.address} ${this.orderHistory().orderBillingDetail?.billingAddressType.name} ${this.orderHistory().orderBillingDetail?.houseNumber}`;
    this.transportAddress = `${this.orderHistory().orderTransportDetail?.postCode} ${this.orderHistory().orderTransportDetail?.town} ${this.orderHistory().orderTransportDetail?.address} ${this.orderHistory().orderTransportDetail?.transportAddressType.name} ${this.orderHistory().orderTransportDetail?.houseNumber}`;;
  }

  cancelOrder(): void {
    this.cancel.emit(this.orderHistory().id!);
  }
}
