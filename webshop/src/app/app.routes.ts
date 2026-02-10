import { Routes } from '@angular/router';
import { HomePage } from './components/home-page/home-page';
import { BasketPage } from './components/basket-page/basket-page';
import { LoginPage } from './components/login-page/login-page';
import { ProfilePage } from './components/profile-page/profile-page';
import { ProductList } from './components/product-list/product-list';
import { ProductDetails } from './components/product-details/product-details';

export const routes: Routes = [
  { path: "homePage", component: HomePage, },
  { path: "", pathMatch: "full", redirectTo: "homePage" },
  { path: "basket", component: BasketPage },
  { path: "login", component: LoginPage },
  { path: "profilePage", component: ProfilePage },
  { path: "productList/:category", component: ProductList },
  { path: "productDetails", component: ProductDetails }
];
