import { Component, inject, OnInit } from '@angular/core';
import { OtherService } from '../../../services/other-service';
import { AddressType } from '../../../model/addressType.model';
import { FormGroup, ReactiveFormsModule } from '@angular/forms';
import { OrderService } from '../../../services/order-service';

@Component({
  selector: 'app-billing-details-page',
  imports: [ReactiveFormsModule],
  templateUrl: './billing-details-page.html',
  styleUrl: './billing-details-page.css',
})
export class BillingDetailsPage implements OnInit{
  otherService = inject(OtherService)
  orderService = inject(OrderService)
  addressTypes: AddressType[] = []
  form!: FormGroup

  ngOnInit(): void {
    this.otherService.getAllAddressType().subscribe({
      next: response => this.addressTypes = response
    })

    this.form = new FormGroup({

    })
  }
}
