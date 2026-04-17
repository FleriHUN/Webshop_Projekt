import { Component, input, OnInit, output } from '@angular/core';
import { Product } from '../../../../model/product.model';
import { FormGroup, ReactiveFormsModule } from '@angular/forms';
import { Reactive } from '@angular/core/primitives/signals';

@Component({
  selector: 'app-admin-product-card',
  imports: [ReactiveFormsModule],
  templateUrl: './admin-product-card.component.html',
  styleUrl: './admin-product-card.component.css',
})
export class AdminProductCardComponent implements OnInit {
  product = input.required<Product>();
  delete = output<number>()
  update = output<number>()
  form!: FormGroup

  ngOnInit(): void {
    this.form = new FormGroup({

    })
  }

  updateProduct() {
  }

  deleteProduct() {
    this.delete.emit(this.product().id)
  }
}
