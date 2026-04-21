import { Component, inject, OnInit, output } from '@angular/core';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { ProductService } from '../../../../services/product-service';
import { Product } from '../../../../model/product.model';
import { Brand } from '../../../../model/brand.model';
import { Category } from '../../../../model/category.model';
import { BrandService } from '../../../../services/brand-service';
import { CategoryService } from '../../../../services/category-service';

@Component({
  selector: 'app-product-creator',
  imports: [ReactiveFormsModule],
  templateUrl: './product-creator.component.html',
  styleUrl: './product-creator.component.css',
})
export class ProductCreatorComponent implements OnInit {
  form!: FormGroup;
  productService = inject(ProductService);
  brandService = inject(BrandService)
  categoryService = inject(CategoryService)
  createProduct = output<Product>();
  close = output<void>();
  brands: Brand[] = [];
  categories: Category[] = [];

  ngOnInit(): void {
    this.brandService.getAllBrand().subscribe({
      next: (response) => this.brands = response
    })

    this.form = new FormGroup({
      name: new FormControl('', [Validators.required]),
      description: new FormControl("", [Validators.required]),
      heightInCm: new FormControl(null, [Validators.required, Validators.min(0)]),
      widthInCm: new FormControl(null, [Validators.required, Validators.min(0)]),
      depthInCm: new FormControl(null, [Validators.required, Validators.min(0)]),
      weightInKg: new FormControl(null),
      price: new FormControl(null, [Validators.required, Validators.min(0)]),
      brand: new FormControl('', [Validators.required]),
      category: new FormControl('', [Validators.required]),
    })
  }

  addProduct() {

  }

  uploadImage() {

  }

  closePopup() {
    this.close.emit()
  }
}
