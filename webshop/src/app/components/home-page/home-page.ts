import { Component, inject, OnInit } from '@angular/core';
import { ProductCard } from '../product-card/product-card';
import { ProductService } from '../../services/product-service';
import { Product } from '../../model/product.model';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-home-page',
  imports: [ProductCard, CommonModule],
  templateUrl: './home-page.html',
  styleUrl: './home-page.css',
})
export class HomePage implements OnInit{
  productService = inject(ProductService)
  productList: Product[] = []

  ngOnInit(): void {
    this.productService.getFirstThreeProduct().subscribe({
      next: response => this.productList = response
    })
  }
}
