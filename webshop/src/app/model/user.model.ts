import { Cart } from "./cart.model";
import { OrderHistory } from "./orderHistory.model";
import { Role } from "./role.model";

export class User {
  constructor(
    public id: number | null,
    public username: string,
    public email: string,
    public phone: string,
    public password: string,
    public pfpPath?: string,
    public role?: Role,
    public cart?: Cart,
    public orderHistoryList: OrderHistory[] = []
  ) { }
}
