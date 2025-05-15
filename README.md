


- Solo el comercio afecta los terminos de intercambio.
  - El comercio se inicia en el router:

1. Trader wants to submit an order to buy $\Delta Y$, therefore he specifies the amount fo tokens he wnats

```solidity
uint128 amountOut = \Delta Y
```

Then he specifies the key

```solidity
PoolKey key = PoolKey(
    {
        currency0: X,
        currency1: Y,
        fee: \phi,
        tickSpacing: \mu,
        hooks: address(0)
    }
)
```

Trader is buying 1 with 0, this is 
```solidity
bool zeroForOne = true;
```

Finally he sets up a minimum slippage cost by specifying $\Delta X_{max}$

```solidity
struct ExactOutputSingleParams {
    PoolKey poolKey;
    bool zeroForOne;
    uint128 amountOut;
    uint128 amountInMaximum;
    bytes hookData;
}
```
Then he sends it to the router:


```solidity

function _handleAction(uint256 action, bytes calldata params) internal override {
    _swapExactOutputSingle(trade = decoded(swapParams));
            if  trade.amountOut ==0:
                //Trader: you owe me someting of token X?
                trade.amountOut = _getFullDebt(X)
                amountIn = _swap(trade.key,zeroForOne,DeltaY)
                                unchecked {
                                        BalanceDelta delta = poolManager.swap(
                                                                                poolKey,
                                                                                SwapParams(
                                                                                    zeroForOne, 
                                                                                    DeltaY,
                                                                                    max P_{Y/X}
                                                                                ),
                                                                                hookData
                                                                            );
                                                            

                                        DeltaX = (zeroForOne == amountSpecified < 0) ? delta.amount1() : delta.amount0();
}                                        
            if DeltaX > DeltaX_max:
                revert
                

}

```

```solidity
/// @inheritdoc IPoolManager
function swap(PoolKey memory key, SwapParams memory params, bytes calldata hookData)
    external
    onlyWhenUnlocked
    noDelegateCall
    returns (BalanceDelta swapDelta)
{    

    DeltaY != 0 
       toId(key)
       pool --> (P, L, i, Y^{AMM}_X, Y^{AMM}_Y , LP'S)  //PoolState
       pool.P ! = 0
            BeforeSwapDelta beforeSwapDelta;
            {
                int256 amountToSwap;
                uint24 lpFeeOverride;
            (amountToSwap, beforeSwapDelta, lpFeeOverride) = key.hooks.beforeSwap(key, params, hookData);

        // execute swap, account protocol fees, and emit swap event
        // _swap is needed to avoid stack too deep error
        swapDelta = _swap(
            pool,
            id,
            Pool.SwapParams({
                tickSpacing: key.tickSpacing,
                zeroForOne: params.zeroForOne,
                amountSpecified: amountToSwap,
                sqrtPriceLimitX96: params.sqrtPriceLimitX96,
                lpFeeOverride: lpFeeOverride
            }),
            params.zeroForOne ? key.currency0 : key.currency1 // input token
        );
    }

    BalanceDelta hookDelta;
    (swapDelta, hookDelta) = key.hooks.afterSwap(key, params, swapDelta, hookData, beforeSwapDelta);

    // if the hook doesn't have the flag to be able to return deltas, hookDelta will always be 0
    if (hookDelta != BalanceDeltaLibrary.ZERO_DELTA) _accountPoolBalanceDelta(key, hookDelta, address(key.hooks));

    _accountPoolBalanceDelta(key, swapDelta, msg.sender);
}

/// @notice Internal swap function to execute a swap, take protocol fees on input token, and emit the swap event
function _swap(Pool.State storage pool, PoolId id, Pool.SwapParams memory params, Currency inputCurrency)
    internal
    returns (BalanceDelta)
{
    (BalanceDelta delta, uint256 amountToProtocol, uint24 swapFee, Pool.SwapResult memory result) =
        pool.swap(params);

    // the fee is on the input currency
    if (amountToProtocol > 0) _updateProtocolFees(inputCurrency, amountToProtocol);

    // event is emitted before the afterSwap call to ensure events are always emitted in order
    emit Swap(
        id,
        msg.sender,
        delta.amount0(),
        delta.amount1(),
        result.sqrtPriceX96,
        result.liquidity,
        result.tick,
        swapFee
    );

    return delta;
}
```