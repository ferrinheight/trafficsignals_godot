# Rules for Traffic Signals: a simple game based on traffic signals(lights) made in godot.

---
## What is the game?
##### This is game where the a setion of the cities traffic signal system is under digital attack, and at the very
##### same time a super important government offical is en route through the same area. It seems obvious the hackers are involved
##### in some kind of attack planned on the pre...precious person. You are a skilled white hat hacker tasked with fighting back!
##### The hackers have a section downtown roads traffic signals stuck in either a green, yellow or red lit state. While traffic 
##### can flow through a contiguos path of roads that are all green, that path need to be determined and the appropriate 
##### intersections need to be changed to form it. The hackers are good and we cant just simply set all or some of the 
##### intersections to functional. We only have the ability to swap the state of a intersection with one of its adjacent
##### neighbors. Beware though that some intersections can not be swapped and there are other obstacles such as construction
##### zones and blinking red intersections.

---
## How does it work?
##### Start with a randomized but solveable game board with designated entry/exit cells for rows 1 and 8.
##### Swap colored "intersections" aka cells(red/green/yellow) so that all rules are satisfied.
##### Swap cells horizontally or vertically.
##### Invalid swaps can be attempted but will quickly undo as a visual hint the move is not allowed.
###### *note that the only invalid swap is 2 cells of the same color*
##### A gameboard is completed and won when the completion rule(see below) is satisfied.

### Rules
##### **Cell placement rules:**
- If a red is above a green cell then the sides of the green cell must contain at least 1 green and 0 reds.
- If a yellow is above a green cell then the sides of the green cell must contain at least 1 green.
- If a green is above a green cell then the sides of the(lower) green cell must contain at least 1 red or yellow.
- Cells in either edge column have slightly different rules for 2 cases;
  - If a red above, the side of the green must also be green.
  - If a green is above, the side of the green(lower) must be red or yellow.
##### **Gameplay rules:**
- You can swap 2 cells if they border either horizontally or vertially.
- You can not swap 2 cells of the same color.
##### **Completion rule:**
- To complete and win a board the following 2 conditions must be satisfied;
  - There must be at least one contiguos path of greens connecting the designated cell in row 1 to the designated cell in row 8.  
  - No rules are broken by the final arrangement of cells.
###### **Rule notes:**
  - *edge rows are 0 and 7 respectively in code*
  - *contiguos path is one where cells are connected on cardinal sides i.e. diagonals do not count* 
