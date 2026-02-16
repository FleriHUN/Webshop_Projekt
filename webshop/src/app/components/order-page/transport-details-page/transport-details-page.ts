import { Component, inject, OnInit } from '@angular/core';
import { OtherService } from '../../../services/other-service';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { AddressType } from '../../../model/addressType.model';
import { OrderService } from '../../../services/order-service';

@Component({
  selector: 'app-transport-details-page',
  imports: [ReactiveFormsModule],
  templateUrl: './transport-details-page.html',
  styleUrl: './transport-details-page.css',
})
export class TransportDetailsPage implements OnInit{
  private otherService = inject(OtherService)
  orderService = inject(OrderService)
  addressTypes: AddressType[] = []
  form!: FormGroup;

  ngOnInit(): void {
    this.otherService.getAllAddressType().subscribe({
      next: response => this.addressTypes = response
    })

    this.form = new FormGroup({
      firstName: new FormControl("", [Validators.required]),
      lastName: new FormControl("", [Validators.required]),
      phoneNumber: new FormControl("", [Validators.required]),
      email: new FormControl("", [Validators.required]),
      postCode: new FormControl("", [Validators.required]),
      town: new FormControl("", [Validators.required]),
      addressTypeId: new FormControl("", [Validators.required]),
      address: new FormControl("", [Validators.required]),
      houseNumber: new FormControl("", [Validators.required]),
      other: new FormControl("", [Validators.required])
    })
  }

  continue() {

  }
}
