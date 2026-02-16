import { Routes } from '@angular/router';
import { HomePage } from './components/home-page/home-page';
import { BasketPage } from './components/basket-page/basket-page';
import { LoginPage } from './components/login-page/login-page';
import { ProfilePage } from './components/profile-page/profile-page';
import { ProductList } from './components/product-list/product-list';
import { ProductDetails } from './components/product-details/product-details';
import { RegisterPage } from './components/register-page/register-page';
import { OrderPage } from './components/order-page/order-page';
import { TransportDetailsPage } from './components/order-page/transport-details-page/transport-details-page';
import { BillingDetailsPage } from './components/order-page/billing-details-page/billing-details-page';
import { OrderSummary } from './components/order-page/order-summary/order-summary';

export const routes: Routes = [
  { path: "homePage", component: HomePage, },
  { path: "", pathMatch: "full", redirectTo: "homePage" },
  { path: "basket", component: BasketPage },
  { path: "login", component: LoginPage },
  { path: "profilePage", component: ProfilePage },
  { path: "productList/:category", component: ProductList },
  { path: "productDetails", component: ProductDetails },
  { path: "register", component: RegisterPage },
  {
    path: "orderPage", component: OrderPage, children: [
      { path: "transportDetails", component: TransportDetailsPage },
      { path: "billingDetails", component: BillingDetailsPage },
      { path: "summary", component: OrderSummary },
      { path: "", pathMatch: "full", redirectTo: "transportDetails" }
    ]
  }
];
