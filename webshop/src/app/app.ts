import { Component, signal } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { Navbar } from './components/navbar/navbar';
import { CategoryList } from './components/category-list/category-list';
import { Footer } from './components/footer/footer';
import { ParentCategories } from './components/parent-categories/parent-categories';

@Component({
  selector: 'app-root',
  imports: [RouterOutlet, Navbar, ParentCategories, Footer],
  templateUrl: './app.html',
  styleUrl: './app.css'
})
export class App {
  protected readonly title = signal('furnitureWebPage');
}
