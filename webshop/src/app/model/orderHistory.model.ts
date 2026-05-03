import { BillingDetail } from "./billingDetail.model";
import { OrderProduct } from "./orderProduct.model";
import { PaymentMethod } from "./paymentMethod.model";
import { Status } from "./status.model";
import { TransportDetail } from "./transportDetail.model";
import { User } from "./user.model";

export class OrderHistory {
  constructor(
    public id: number | null = null,
    public firstName: string | null = null,
    public lastName: string | null = null,
    public phone: string | null = null,
    public email: string | null = null,
    public orderedAt: Date = new Date(),
    public cancelledAt: Date | null = null,
    public isCancelled: boolean = false,
    public orderId: number | null = null,
    public orderUser: User | null = null,
    public orderBillingDetail: BillingDetail | null = null,
    public orderTransportDetail: TransportDetail | null = null,
    public paymentMethod: PaymentMethod | null = null,
    public status: Status | null = null,
    public products: OrderProduct[] = [],
  ) {}
}
