import { Product } from "./product.model";

export class OrderProduct {
    constructor(
        public id: number,
        public amount: number,
        public orderProduct: Product
    ) {}
}