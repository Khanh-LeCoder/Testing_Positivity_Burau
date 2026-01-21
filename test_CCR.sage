/* 
The script tests the order-preserving criterion described in Cai-Clay-Rolfsen paper: https://arxiv.org/abs/2406.18876
*/

def conjugating_words(braid):
  '''
  returns the conjugating words for the Artin action of the braid of the basis elements of the free group
  '''
  strands = braid.strands()
  F = FreeGroup(strands)
  conj = []
  for i in range(1,strands):
    x = (F([i])*braid).Tietze()
    if len(x) > 1:
      w = [x[j] for j in range((len(x) - 1)/2)]
      conj = conj + [w]
    else:
      conj = conj + [[]]
  return conj

def linking_tuple(braid,i):
  '''
  returns the linking number of all other components of the braid closure and an unknotted component obtained as the closure of the ith strand of the braid  
  '''
  perm = braid.permutation()
  link_tup = []  
  

  
def is_CCR_satisfied(braid):
  perm = braid.permutation()
  if 1 is not in perm.cycle_type():
    return False
  else:
    

