import { Product } from "./product.model";

export class CartProduct {
    constructor(
        public id: number,
        public amount: number,
        public cartProduct: Product,
    ) {}
}