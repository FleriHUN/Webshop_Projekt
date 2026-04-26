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

    this.categoryService.getAllCategory().subscribe({
      next: response => this.categories = response
    })

    this.form = new FormGroup({
      name: new FormControl('', [Validators.required]),
      description: new FormControl("", [Validators.required]),
      heightInCm: new FormControl(null, [Validators.required, Validators.min(1)]),
      widthInCm: new FormControl(null, [Validators.required, Validators.min(1)]),
      depthInCm: new FormControl(null, [Validators.required, Validators.min(1)]),
      weightInKg: new FormControl(null),
      price: new FormControl(null, [Validators.required, Validators.min(1)]),
      brand: new FormControl('', [Validators.required]),
      category: new FormControl('', [Validators.required]),
      amount: new FormControl(null, [Validators.required, Validators.min(1)]),
    })
  }

  addProduct() {
    const newProduct = new Product(
      this.form.controls["name"].value,
      this.form.controls["description"].value,
      this.form.controls["heightInCm"].value,
      this.form.controls["widthInCm"].value,
      this.form.controls["depthInCm"].value,
      this.form.controls["weightInKg"].value,
      this.form.controls["price"].value,
      this.brands[this.form.controls["brand"].value],
      this.categories[this.form.controls["category"].value],
      this.form.controls["amount"].value,
    )

    this.productService.addProduct(newProduct).subscribe({
      next: response => {
        this.uploadImage(response.id!)
        this.createProduct.emit(response)
      }
    })
  }

  uploadImage(id: number) {

  }

  closePopup() {
    this.close.emit()
  }
}
