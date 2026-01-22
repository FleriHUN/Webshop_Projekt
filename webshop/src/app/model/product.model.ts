import { Brand } from "./brand.model";
import { Category } from "./category.model";
import { ProductImages } from "./productImages.model";

export class Product {
    constructor(
        public id: number,
        public name: string,
        public description: string,
        public heightInCm: number,
        public widthInCm: number,
        public depthInCm: number,
        public weightInKg: number,
        public price: number,
        public brand: Brand,
        public images: ProductImages,
        public categories: Category[],
    ) {}
}