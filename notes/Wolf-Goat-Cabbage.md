# Wolf, Goat, Cabbage

The [wolf, goat and cabbage problem](https://en.wikipedia.org/wiki/Wolf,_goat_and_cabbage_problem) is a classic problem with a long history. We use it here to learn the following.

- How to use a Spin model to describe a set of possible execution sequences (runs).
- How to use a formula of linear temporal logic (LTL) to specify runs with certain desirable properties.
- How to use the Spin model checker to find a run that satisfies the LTL property.

In terms of the puzzle, the run satsifying the property will be the solution to the puzzle. 

We end with a similar problem, bandits and pilgrims, which can be done as an exercise.

## The Model

Let us jump right into the formalization of WGC in Promela, which is the programming language in which Spin models are defined. The code is also availabe as [`wgc.pml`](../examples/Wolf-Goat-Cabbage/wgc.pml)

```c
int wolf=0;
int goat=1;
int cabbage=2;

bit bank[3]; /* bank[wolf]==1 means "wolf is on the other side" */ 

active proctype boat()
{ 
L0:do
   ::
   if
    :: 	!bank[wolf]-> bank[wolf]=1;
    :: 	!bank[goat]-> bank[goat]=1;
    :: 	!bank[cabbage]-> bank[cabbage]=1;
    ::  skip; /* boat goes to the other side empty */
   fi;

    printf("wolf: %d, goat: %d, cabbage: %d\n",bank[wolf], bank[goat], bank[cabbage]);

L1: if
    :: 	bank[wolf]-> bank[wolf]=0;
    :: 	bank[goat]-> bank[goat]=0;
    :: 	bank[cabbage]-> bank[cabbage]=0;
    ::  skip; /* boat goes back empty */
    fi;

    printf("wolf: %d, goat: %d, cabbage: %d\n",bank[wolf], bank[goat], bank[cabbage]);

  od
}
```

**Exercise/Activity:** Explain how the Promela model formalizes the puzzle. Questions about Promela can be answered by consulting the [Promela Manual](https://spinroot.com/spin/Man/promela.html). In particular, read the articles about [proctype](https://spinroot.com/spin/Man/proctype.html), [do](https://spinroot.com/spin/Man/do.html), [if](https://spinroot.com/spin/Man/if.html).

## Running the Model

**Running a Random Simulation**: To run a random simulation (useful for exploring the model's behavior):
```bash
spin wgc.pml | less
```

**Exercise/Activity:** Explain the output. You will see an initial segment of an infinite run through the model. What happens when you use the return key to take another transition (computation step) in your model? Make sure to match each transition against the corresponding line of code in `wgc.pml`. 

What needs to be added to the model in order to make sure that we only get runs that follow the rules of the puzzle?


## Rules as LTL Properties

In this section, we will formalize the rules of the puzzle as a formula in LTL.

**Exercise/Activity:** Formulate the rules of the puzzle in an informal linear temporal logic.

Now we look at how LTL formulas appear in [`wgc.pml`](../examples/Wolf-Goat-Cabbage/wgc.pml):

```c
#define atL0 (boat@L0) /*boat on this side of the river */
#define atL1 (boat@L1) /*boat on the other side of the river */
#define cond0 (!(bank[wolf]&&bank[goat])&&!(bank[goat]&&bank[cabbage]))
#define cond1 (!(!bank[wolf]&&!bank[goat])&&!(!bank[goat]&&!bank[cabbage]))
#define cond2 (bank[wolf]&&bank[goat]&&bank[cabbage])
```

**Exercise/Activity:** Read the formulas. Match them up against the rules of the game. Questions about Promela can be answered by consulting the [Promela Manual](https://spinroot.com/spin/Man/promela.html). In particular, read the articles about [labels](https://spinroot.com/spin/Man/labels.html), [ltl](https://spinroot.com/spin/Man/ltl.html), , [if](https://spinroot.com/spin/Man/if.html).

## Verifying LTL properties with Spin

In many applications of Spin, we want to verify that all runs of a model satisfy a certain correctness property. As in SAT-solvers, Spin is doing this by verifying that no run violates the property. In other words, similarly to SAT-solvers and also to Prolog, Spin is searching for a solution that satisfies a formula. In the case of LTL, we can think of the formula as a query and a solution as an infinite run that satisfies the formula. 

To check a formula with Spin we run through the following. 
```bash
spin -a -f 'FORMULA' wgc.pml
gcc -o pan pan.c
./pan -a
spin -t -p wgc.pml
```
This does the following. 1. Create the source code of the verifier. 2. Compile the verifier. 3. Run the verifier. 4. Display the error trail (if one was generated).

**Exercise/Activity:** Replace 'FORMULA' by your own formulas and observe whether a trail file is generated. (Careful, old trail files do not get deleted automatically.) Here are some examples
- 'true'
- 'false' 
- 'atL1'
- '<>cond2'
- '[](atL1->cond1)'
In each case, formulate the result you expect before you run Spin. Explain carefully whether the result matches your expectation. If a trail file was generated, make sure you understand which run it represents. Always translate formal representations into informal English.

The trail shows a sequence of states that satisfies FORMULA.

```bash
spin -a -f '([]((atL0->cond0) /\ atL1->cond1) /\ <>cond2)' wgc.pml
gcc -o pan pan.c
./pan -a
spin -t -p wgc.pml
```

```bash
clear
spin -a -f '[](atL1->cond1)' wgc.pml
gcc -o pan pan.c
./pan -a
spin -t -p wgc.pml
```
