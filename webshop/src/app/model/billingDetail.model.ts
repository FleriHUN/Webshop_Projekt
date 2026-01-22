import { AddressType } from "./addressType.model";

export class BillingDetail {
    constructor(
        public id: number,
        public postCode: number,
        public town: string,
        public address: string,
        public houseNumber: number,
        public companyName: string | null = null,
        public taxNumber: string | null = null,
        public other: string,
        public billingAddressType: AddressType,
    ) {}
}