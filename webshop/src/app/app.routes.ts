import { Routes } from '@angular/router';
import { HomePage } from './components/home-page/home-page';
import { BasketPage } from './components/order-page/basket-page/basket-page';
import { LoginPage } from './components/login-page/login-page';
import { ProfilePage } from './components/profile-page/profile-page';
import { ProductList } from './components/product-list/product-list';
import { ProductDetails } from './components/product-details/product-details';
import { RegisterPage } from './components/register-page/register-page';
import { OrderPage } from './components/order-page/order-page';
import { TransportDetailsPage } from './components/order-page/transport-details-page/transport-details-page';
import { BillingDetailsPage } from './components/order-page/billing-details-page/billing-details-page';
import { OrderSummary } from './components/order-page/order-summary/order-summary';
import { AdminPage } from './components/admin-page/admin-page';
import { NotFound } from './components/not-found/not-found';
import { OrderHistories } from './components/admin-page/order-histories/order-histories';
import { UserManagerPage } from './components/admin-page/user-manager-page/user-manager-page';
import { ProductManagerPage } from './components/admin-page/product-manager-page/product-manager-page';

export const routes: Routes = [
  { path: "homePage", component: HomePage, },
  { path: "", pathMatch: "full", redirectTo: "homePage" },
  { path: "login", component: LoginPage },
  { path: "profilPage", component: ProfilePage },
  { path: "productList/:category", component: ProductList },
  { path: "productDetails/:id", component: ProductDetails },
  { path: "register", component: RegisterPage },
  {
    path: "orderPage", component: OrderPage, children: [
      { path: "transportDetails", component: TransportDetailsPage },
      { path: "billingDetails", component: BillingDetailsPage },
      { path: "summary", component: OrderSummary },
      { path: "basket", component: BasketPage }
    ]
  },
  { path: "adminPage", component: AdminPage },
  { path: "orderManager", component: OrderHistories },
  { path: "userManager", component: UserManagerPage },
  { path: "productManager", component: ProductManagerPage },

  { path: "**", component: NotFound }
];
