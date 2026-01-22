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

def alg_winding_num(word,i):
  '''
  returns the algebraic winding number of an immersed curve representing a word in the free group about the ith puncture on a many punctured disk
  '''
  F = FreeGroup()
  tup = word.Tietze()
  h = 0 
  for j in tup:
    if j == i:
      h = h + 1
    else if j == -i:
      h = h - 1
  return h

def linking_tuple(braid,i):
  '''
  returns the linking number of all other components of the braid closure and an unknotted component obtained as the closure of the ith strand of the braid  
  '''
  perm = braid.permutation()
  cycle_tup = perm.cycle_tuple()
  link_tup = []  
  for cycle in cycle_tup:
  

  
def is_CCR_satisfied(braid):
  perm = braid.permutation()
  if 1 is not in perm.cycle_type():
    return False
  else:
    

