import type { BaseContract, BigNumberish, ContractTransaction } from "ethers";

export interface IHomeState {
    account: string | null;
}

export interface IDappazon extends BaseContract {
    /**
     * Purchases a product by ID, requires a value in ETH.
     * @param productId - The ID of the product to buy
     * @param options - Transaction options including value (ETH cost)
     */
    buy(productId: number, options: { value: BigNumberish }): Promise<ContractTransaction>;

    /**
     * Fetches details of a product by ID.
     * @param productId - The ID of the product
     * @returns A promise resolving to the product details
     */
    items(productId: number): Promise<{
        id: BigNumberish;
        name: string;
        category: string;
        image: string;
        cost: BigNumberish;
        stock: BigNumberish;
        rating: BigNumberish;
        description?: string;
    }>;
}

export interface IProduct {
    id: number;
    name: string;
    category: string;
    image: string;
    cost: BigNumberish; // ✅ Changed to match Ethers.js
    rating: number;
    stock: number;
}
