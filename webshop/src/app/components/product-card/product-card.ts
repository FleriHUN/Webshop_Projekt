import { Component, inject, input } from '@angular/core';
import { Router } from '@angular/router';
import { Product } from '../../model/product.model';

@Component({
  selector: 'app-product-card',
  imports: [],
  templateUrl: './product-card.html',
  styleUrl: './product-card.scss',
})
export class ProductCard {
  private router = inject(Router)
  product = input.required<Product>()
}
