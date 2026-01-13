import { Component } from '@angular/core';
import { ProductCard } from '../product-card/product-card';

@Component({
  selector: 'app-home-page',
  imports: [ProductCard],
  templateUrl: './home-page.html',
  styleUrl: './home-page.scss',
})
export class HomePage {

}
