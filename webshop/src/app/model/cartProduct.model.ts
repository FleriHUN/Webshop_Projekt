import { Product } from "./product.model";

export class CartProduct {
    constructor(
        public id: number,
        public cartProduct: Product,
    ) {}
}