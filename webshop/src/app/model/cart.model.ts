import { CartProduct } from "./cartProduct.model";

export class Cart {
    constructor(
        public id: number,
        public cartProductList: CartProduct,
    ) {}
}