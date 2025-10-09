# Introduction

Model checking formulas of temporal logic against a model has a wide range of applications in hardware and software verification. Here we will look at one example: How to use Spin to verify the design of distributed protocols. 

On the syntax side, we will work with Linear Temporal Logic, that is, a modal logic in which $\Box$ means "always now and in the future" and $\Diamond$ means "sometimes, now or in the future". There are also variations of "until".

On the semantic side, formulas will be interpreted in the initial state (or world) of infinite runs (or execution sequences) of a "model". A model here is a transition system with an initial state, a successor relation, and valuations of atomic propositions for each state. Thus a model coincides with a Kripke model as discussed in the chapter on modal logic, but the semantics is different since formulas are not evaluated directly in the model but in the infinite runs defined by the model.

## Definitions

First, we should look at [the definition of the syntax of LTL in Spin](https://spinroot.com/spin/Man/ltl.html).

![](images/2025-10-09-07-32-16.png)

**Exercise/Activity**: Write some formulas and translate them into informal English.

**Semantics of LTL.** Let $M=(v_n)_{n\in\mathbb{N}}$ be a sequence[^1] of valuations $v_n:\mathbb{P}\to\{0,1\}$.

- $M,n\models p$ if $v_n(p)=1$,
- $M,n\models \neg \phi$ if not $M,n\models\phi$,
- $M,n\models \phi\wedge\psi$ if $M,n\models\phi$ and $M,n\models\psi$,
- $M,n\models{\Large\circ}\phi$ if $M,n+1\models\phi$,
- $M,n\models\Box\phi$ if $M,m\models\phi$ for all $m\ge n$,
- $M,n\models\Diamond\phi$ if $M,m\models\phi$ for some $m\ge n$,
- $M,n\models \phi\mathrel{\mathsf{until}}\psi$ if $M,m\models\psi$ for some $m> n$ and $M,k\models\phi$ for all $k$ with $n< k < m$.

$M\models\phi$ if $M,n\models\phi$ for all $n\in\mathbb{N}$.

$M\models\Phi$ and $\Phi\models\phi$ and $\models\phi$ ('$\phi$ is valid') as before.

[^1]: $\mathbb{N}=\{0,1,2\ldots\}$ denotes the set of natural numbers; $(v_n)_{n\in\mathbb{N}}$, or $(v_n)$, is short for $(v_0,v_1,v_2\ldots)$. Each $v_n$ represents a state of the computation. Think of it as the memory and of $v_n(p)$ as the value of bit $p$ at time $n$.


