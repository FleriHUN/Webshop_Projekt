import { Component, inject, OnInit } from '@angular/core';
import { Category } from '../../model/category.model';
import { CategoryService } from '../../services/category-service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-parent-categories',
  imports: [],
  templateUrl: './parent-categories.html',
  styleUrl: './parent-categories.scss',
})
export class ParentCategories implements OnInit {
  parentCategories: Category[] = []
  categoryService = inject(CategoryService)
  router = inject(Router)

  ngOnInit(): void {
    this.categoryService.getAllParentCategories().subscribe({
      next: response => this.parentCategories = response
    })
  }

  selectCategory(id: number) {
    this.router.navigate(["productList", id])
  }
}
