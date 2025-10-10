/*
  Three pilgrims and three bandits meet on the left bank of a river.
  They must cross the river, but the only available boat will hold
  only two people at a time. There is no bridge, the river cannot be
  swum, and the boat cannot cross the river without someone in it. The
  bandits may attack pilgrims they outnumber on either bank of the
  river.  The problem is to get everyone across the river with all the
  pilgrims safe of any attacks.
*/

int bandit; /* bandit ranges over {0,1,2,3}
               bandit==n means "n bandits on the other side" */ 

int pilgrim; /* pilgrim ranges over {0,1,2,3}
               pilgrim==n means "n pilgrims on the other side" */ 

active proctype boat()
{ 
L0:do
   ::
   if /* boat moves to the other side of the river */
    YOUR CODE FOR ALL THE POSSIBILITIES
   fi;

printf("after moving forth, %d bandits and %d pilgrims on the other side\n", bandit, pilgrim);

L1:if /* boat moves back */
    YOUR CODE FOR ALL THE POSSIBILITIES
   fi;

printf("after moving back , %d bandits and %d pilgrims on the other side\n", bandit, pilgrim);
   
  od
}



#define atL0 (boat@L0) /*boat on this side of the river */
#define atL1 (boat@L1) /*boat on the other side of the river */
#define notOutnumber (pilgrim==0||pilgrim==3||pilgrim==bandit)
#define success (YOUR CODE)




/*

   YOUR LTL PROPERTY

*/
