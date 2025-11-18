module gogen_token::gogen_token {
    use sui::coin::{Self, TreasuryCap};
    use sui::coin_registry;
    use std::string;

    public struct GOGEN_TOKEN has drop {}

    fun init(witness: GOGEN_TOKEN, ctx: &mut TxContext) {
        let (currency, treasury_cap) = coin_registry::new_currency_with_otw(
            witness,
            6,
            string::utf8(b"GEN"),
            string::utf8(b"Gogen token"),
            string::utf8(b"Gogen token — fungible token for CoinBank challenge by @gogenjack"),
            string::utf8(b""),
            ctx,
        );

        let metadata_cap = currency.finalize(ctx);

        transfer::public_transfer(treasury_cap, ctx.sender());
        transfer::public_transfer(metadata_cap, ctx.sender());
    }

    public fun mint(
        treasury_cap: &mut TreasuryCap<GOGEN_TOKEN>,
        amount: u64,
        recipient: address,
        ctx: &mut TxContext,
    ) {
        let coin = coin::mint(treasury_cap, amount, ctx);
        transfer::public_transfer(coin, recipient);
    }
}

