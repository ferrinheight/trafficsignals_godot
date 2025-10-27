# Traffic Signals: a simple game based on traffic signals(lights) made in godot.
---
## What is the game? How does it work?
##### Swap colored cells(red/green/yellow) so that all rules are satisfied.
##### Swap cells horizontally or vertically.
##### Invalid swaps can be attempted but will quickly undo as a visual hint the move is not allowed.
###### *note that the only invalid swap is 2 cells of the same color*
##### A gameboard is completed and won when the completion rule is satisfied and no rules are broken.
- **Cell placement rules:**
- If a red is above a green cell then the sides of the green cell must contain at least 1 green and 0 reds.
- If a yellow is above a green cell then the sides of the green cell must contain at least 1 green.
- If a green is above a green cell then the sides of the(lower) green cell must contain at least 1 red or yellow.
- Cells in either edge column have slightly different rules for 2 cases;
  - If a red above, the side of the green must also be green.
  - If a green is above, the side of the green(lower) must be red or yellow.
- **Gameplay rules:**
- You can swap 2 cells if they border either horizontally or vertially.
- You can not swap 2 cells of the same color.
- To complete and win a board the following 2 conditions must be satisfied;
  - There must be at least one contiguos path of greens connecting any cell in row 1 to any cell in row 8.  
  - No rules are broken by the final arrangement of cells.
- **Rule notes:**
  - *edge rows are 0 and 7 respectively in code*
  - *contiguos path is one where cells are connected on cardinal sides i.e. diagonals do not count* 
 
### Example gameboard(completed and won through H3 to A3).
**G == green, R == red, Y == yellow**

|#|**1**|**2**|**3**|<font color="green">4</font>|**5**|**6**|**7**|**8**|
|-|-|-|-|-|-|-|-|-|
|A| <font color="red">R</font> | <font color="green">G</font> | <font color="yellow">Y</font> | <font color="green">G</font> | <font color="red">R</font> | <font color="green">G</font> | <font color="green">G</font> | <font color="red">R</font> |
|B| <font color="green">G</font> | <font color="yellow">Y</font> | <font color="red">R</font> | <font color="green">G</font> | <font color="green">G</font> | <font color="green">G</font> | <font color="yellow">Y</font> | <font color="green">G</font> |
|C| <font color="red">R</font> | <font color="green">G</font> | <font color="green">G</font> | <font color="green">G</font> | <font color="red">R</font> | <font color="green">G</font> | <font color="green">G</font> | <font color="green">G</font> |
|D| <font color="green">G</font> | <font color="green">G</font> | <font color="yellow">Y</font> | <font color="red">R</font> | <font color="yellow">Y</font> | <font color="red">R</font> | <font color="yellow">Y</font> | <font color="red">R</font> |
|E| <font color="red">R</font> | <font color="green">G</font> | <font color="green">G</font> | <font color="green">G</font> | <font color="green">G</font> | <font color="yellow">Y</font> | <font color="green">G</font> | <font color="yellow">Y</font> |
|F| <font color="green">G</font> | <font color="green">G</font> | <font color="red">R</font> | <font color="yellow">Y</font> | <font color="green">G</font> | <font color="green">G</font> | <font color="red">R</font> | <font color="green">G</font> |
|G| <font color="red">R</font> | <font color="red">R</font> | <font color="red">R</font> | <font color="green">G</font> | <font color="green">G</font> | <font color="red">R</font> | <font color="yellow">Y</font> | <font color="red">R</font> |
|H| <font color="green">G</font> | <font color="green">G</font> | <font color="yellow">Y</font> | <font color="green">G</font> | <font color="red">R</font> | <font color="green">G</font> | <font color="green">G</font> | <font color="green">G</font> |
|#|**1**|**2**|**3**|<font color="green">4</font>|**5**|**6**|**7**|**8**|
