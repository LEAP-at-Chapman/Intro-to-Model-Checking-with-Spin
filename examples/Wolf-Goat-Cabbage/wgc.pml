int wolf=0;
int goat=1;
int cabbage=2;

bit bank[3]; /* bank[wolf]==1 means "wolf is on the other side" */ 

active proctype boat()
{ 
L0: do
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


/* ============================================
 * Definitions for use in LTL formulas
 * ============================================ */


#define atL0 (boat@L0) /*boat on this side of the river */
#define atL1 (boat@L1) /*boat on the other side of the river */
#define cond1 (!(bank[wolf]&&bank[goat])&&!(bank[goat]&&bank[cabbage]))
#define cond0 (!(!bank[wolf]&&!bank[goat])&&!(!bank[goat]&&!bank[cabbage]))
#define cond2 (bank[wolf]&&bank[goat]&&bank[cabbage])


/* ============================================
 * LTL Formulas for Model Checking
 * ============================================
 *
 * Safety Property: wolf can't eat goat and goat can't eat cabbage
 *     []((atL0->cond0) /\ atL1->cond1)
 *
 * Safety + Liveness: the problem has a solution
 *     []((atL0->cond0) /\ atL1->cond1) /\ <>cond2
 *
 * To find a solution, check the negation (Spin finds counterexamples):
 *     !([]((atL0->cond0) /\ atL1->cond1) /\ <>cond2)
 */
