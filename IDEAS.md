# Ideas

## Context
Given 
$$
\begin{align*}
    \mathcal{L}_{\kappa, \delta} \bigg ( r_{\varepsilon_{\mathbb{Z}},\mu} \, \bigg) : = \, \begin{cases}
        \kappa^{r_{\varepsilon_{\mathbb{Z}}}, \mu} \cdot \bigg ( \frac{1- \kappa}{1-\kappa^{\delta}}\bigg ) & \, r_{\varepsilon_{\mathbb{Z}},\mu} \in \big [ 0, \delta \, \big] \cap \, \mathbb{Z} \\
        \\
        0 & \, \text{otherwise}
    \end{cases}
\end{align*}
$$
- $\kappa$ The exponent that governs the shape of the liquidity curve.
  - Represents the LP’s risk sensitivity or confidence in price stability 
  - Encode their view on price dynamics and volatility expectations .
  
      - $\kappa \to [0,1]$ liquidity decreases exponentially as we move away from the origin (mean price). 
  
      - $\kappa \to 0$ Reflects strong belief in price staying near $\mu$ .Similar to a trader placing a limit order very close to spot .
      - $\kappa \to 1$ Flat or nearly uniform distribution → reflects uncertainty or expectation of high volatility . Like placing liquidity in wide ranges to capture multiple outcomes .
      - $\kappa > 1$ liquidity increases exponentially , which is less common but could be used for speculative or volatility-hedging strategies.
  
      - Increasing liquidity at higher prices → may reflect trend-following beliefs , such as expecting continued upward movement.
- $\delta \in \mathbb{N}$ The length or support of the liquidity distribution — i.e., how many ricks are used to deploy liquidity.\\
  
  - $\delta$ The number of rick positions over which liquidity is distributed.
  - Defines the maximum distance from the mean price that liquidity extends.
  - $\downarrow \, \delta:$ Reflects low uncertainty about price behavior → liquidity is concentrated. Useful in stable environments like stablecoin pairs.
  - $\uparrow \, \delta:$ Reflects high uncertainty or expectation of high volatility → liquidity is spread out. Suitable for volatile assets likes

## Idea

For a expiry token ERC7818 I have that its expiration trading life is measured on time on epochs $E_t$ such that

```solidity
/**
 * @dev Enum represents the types of `epoch` that can be used.
 * @notice The implementing contract may use one of these types to define how the `epoch` is measured.
 */
enum EPOCH_TYPE {
    BLOCKS_BASED, // measured in the number of blocks (e.g., 1000 blocks)
    TIME_BASED // measured in seconds (UNIX time) (e.g., 1000 seconds)
}
```
Then at expiration time $T, \, E_T$ There exists $E_{t \to T}$ identified as pre-expiration epoch.

$IERC7818.E_{t \to T}$ is characterized to have effects on markets 
$M^{(IERC7818, Y)}$ where $Y$ is a non-expiry numeraire token (cash) such that the mechanism to achieve market equilibrium

```solidity
enum  STATE{
    EQUILIBRIUM,
    SUPPLY_SURPLUS,
    SCARCITY
}
```

Is no longer avhievable via arbitrage, therefore we need to have liquidity providers to enfore equilibrium whenever we have the situation

$$
IERC7818.E_{t \to T} \, \wedge \big (  M.STATE.SUPPLY\_SURPLUS \vee  M.STATE.SCARICITY \big )
$$

What mechanisms make econmic sense to achieve this and why?
