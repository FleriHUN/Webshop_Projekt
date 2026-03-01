import { Routes } from '@angular/router';
import { AdminPage } from './components/admin-page/admin-page';
import { OrderHistories } from './components/admin-page/order-histories/order-histories';
import { ProductManagerPage } from './components/admin-page/product-manager-page/product-manager-page';
import { UserManagerPage } from './components/admin-page/user-manager-page/user-manager-page';
import { HomePage } from './components/home-page/home-page';
import { LoginPage } from './components/login-page/login-page';
import { NotFound } from './components/not-found/not-found';
import { BasketPage } from './components/order-page/basket-page/basket-page';
import { BillingDetailsPage } from './components/order-page/billing-details-page/billing-details-page';
import { OrderPage } from './components/order-page/order-page';
import { OrderSummary } from './components/order-page/order-summary/order-summary';
import { TransportDetailsPage } from './components/order-page/transport-details-page/transport-details-page';
import { ProductDetails } from './components/product-details/product-details';
import { ProductList } from './components/product-list/product-list';
import { ProfilePage } from './components/profile-page/profile-page';
import { RegisterPage } from './components/register-page/register-page';
import { Unauthorized } from './components/unauthorized/unauthorized';

export const routes: Routes = [
  { path: "homePage", component: HomePage, },
  { path: "", pathMatch: "full", redirectTo: "homePage" },
  { path: "login", component: LoginPage },
  { path: "profilPage", component: ProfilePage, canMatch: [] },
  { path: "productList/:category", component: ProductList },
  { path: "productDetails/:id", component: ProductDetails },
  { path: "register", component: RegisterPage },
  { path: "unauthorized", component: Unauthorized },

  {
    path: "orderPage", component: OrderPage, canMatch: [], children: [
      { path: "transportDetails", component: TransportDetailsPage },
      { path: "billingDetails", component: BillingDetailsPage },
      { path: "summary", component: OrderSummary },
      { path: "basket", component: BasketPage },
      { path: "", pathMatch: "full", redirectTo: "basket" },
    ]
  },
  { path: "adminPage", component: AdminPage, canMatch: [] },
  { path: "orderManager", component: OrderHistories, canMatch: [] },
  { path: "userManager", component: UserManagerPage, canMatch: [] },
  { path: "productManager", component: ProductManagerPage, canMatch: [] },

  { path: "**", component: NotFound }
];
