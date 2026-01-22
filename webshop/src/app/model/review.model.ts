export class Review {
    constructor(
        public id: number,
        public reviewText: string,
        public rating: number,
        public isAnonymous: boolean,
    ) {}
}