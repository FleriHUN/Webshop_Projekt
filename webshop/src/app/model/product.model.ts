import { Brand } from "./brand.model";
import { Category } from "./category.model";

export class Product {
    constructor(
        public name: string,
        public description: string,
        public heightInCm: number,
        public widthInCm: number,
        public depthInCm: number,
        public weightInKg: number,
        public price: number,
        public brand: Brand,
        public category: Category,
        public amount: number,
        public imagePath: string = "",
        public id: number | null = null,
        public isDeleted: boolean = false
    ) {}
}
