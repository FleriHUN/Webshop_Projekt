import { Component, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';

interface Product {
  id: number;
  name: string;
  category: string;
  price: number;
  image: string;
}

@Component({
  selector: 'app-home',
  imports: [CommonModule, RouterLink],
  templateUrl: './home.html',
  styleUrl: './home.css'
})
export class HomeComponent {
  menuOpen = signal(false);

  categories = [
    'Kültéri',
    'Lámpák',
    'Ágyak',
    'Asztalok',
    'Polcok',
    'Kanapék & Fotelek',
    'Konyhabútor',
    'Szekrények & Tárolók',
    'Székek & Bárszékek',
    'Matracok'
  ];

  featuredProducts: Product[] = [
    {
      id: 1,
      name: 'Luxus boxspring ágy',
      category: 'ágy',
      price: 400000,
      image: 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=400&h=300&fit=crop'
    },
    {
      id: 2,
      name: 'Comfort design szék',
      category: 'szék',
      price: 50000,
      image: 'https://images.unsplash.com/photo-1506439773649-6e0eb8cfb237?w=400&h=300&fit=crop'
    },
    {
      id: 3,
      name: 'Chester luxuskanapé',
      category: 'kanapé',
      price: 200000,
      image: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400&h=300&fit=crop'
    }
  ];

  toggleMenu(): void {
    this.menuOpen.set(!this.menuOpen());
  }

  formatPrice(price: number): string {
    return price.toLocaleString('hu-HU') + ' Ft';
  }
}
