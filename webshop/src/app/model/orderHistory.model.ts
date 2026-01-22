import { BillingDetail } from "./billingDetail.model";
import { OrderProduct } from "./orderProduct.model";
import { PaymentMethod } from "./paymentMethod.model";
import { Status } from "./status.model";
import { TransportDetail } from "./transportDetail.model";

export class OrderHistory {
    constructor(
        public id: number,
        public firstName: string,
        public lastName: string,
        public phone: string,
        public email: string,
        public orderedAt: Date,
        public orderId: number,
        public orderBillingDetail: BillingDetail,
        public orderTransportDetail: TransportDetail,
        public paymentMethod: PaymentMethod,
        public status: Status,
        public products: OrderProduct[]
    ) {}
}