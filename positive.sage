from sage.all import BraidGroup, RealField
import numpy as np
import random

def random_braid(strands, length):
    	B = BraidGroup(strands)
    	gens = list(range(1, strands)) + [-s for s in range(1, strands)]
    	word = [random.choice(gens) for _ in range(length)]
    	return B(word)

def random_pos_braid(strands, length):
	B = BraidGroup(strands)
	gens = list(range(1, strands)) 
	word = [random.choice(gens) for _ in range(length)]
	return B(word)

def clear_denominators(laurent_poly_matrix):
	A = laurent_poly_matrix
	L.<t> = FunctionField(QQ)
	min_exp = min(e.polynomial_construction()[1] for e in A.list())
	B = (t**-min_exp) * A
	return B.change_ring(L)

def char_poly(laurent_poly_matrix):
	A = clear_denominators(laurent_poly_matrix)
	return A.characteristic_polynomial()

def is_pure(braid):
	strands = braid.strands()
	return braid.permutation() == [i + 1 for i in range(strands)]

def sturm_chain(char):
	L.<t> = FunctionField(QQ)
	p0 = char
	p1 = char.derivative()
	sturm = [p0,p1]
	while p1.degree() > 0: 
		r = -p0.quo_rem(p1)[1]
		sturm = sturm + [r]
		p0 = p1
		p1 = r
	return sturm
	
def sturm_at_pos_infty(char):
	L.<t> = FunctionField(QQ)
	sturm = sturm_chain(char)
	return [L(c.leading_coefficient()).list()[0] for c in sturm]	

def sturm_at_neg_infty(char):
	L.<t> = FunctionField(QQ)
	sturm = sturm_chain(char)
	if char.degree() % 2 == 0:
		return [L(c.leading_coefficient()).list()[0] for c in sturm]
	else:
		return [-L(c.leading_coefficient()).list()[0] for c in sturm]

def sturm_at_zero(char):
	sturm = sturm_chain(char)
	return [c(0) for c in sturm]	

def lowest_deg_coeff(univar_rat_func):
	L.<t> = FunctionField(QQ)
	if univar_rat_func == 0:
		return 0
	else:
		min_deg = univar_rat_func.valuation('t')
		pole_removed = (univar_rat_func * t^(-min_deg)).element()
		return pole_removed(0)

def lowest_coeff_seq(sturm):
	return [lowest_deg_coeff(poly) for poly in sturm]

def count_sign_change(coeff_sequence):
	count = 0
	zero_removed = [c for c in coeff_sequence if c != 0 ]
	cur_sign = zero_removed[0] >0
	for elem in zero_removed:
		if (elem > 0) != cur_sign:
			count = count + 1
			cur_sign = (elem >0)  
	return count

def count_pos_roots(char):
	Vinfty = count_sign_change(lowest_coeff_seq(sturm_at_pos_infty(char)))
	Vzero = count_sign_change(lowest_coeff_seq(sturm_at_zero(char)))
	return Vzero - Vinfty

L.<t> = FunctionField(QQ)
d = L.higher_derivation()
braid = random_braid(5,10)
char = char_poly(braid.burau_matrix(var='t',reduced=True))

def test_pos_eig(strands, length, sample_size):
	count = 0
	for k in range(sample_size):
		braid = random_braid(strands,length)
		char = char_poly(braid.burau_matrix(var= 't',reduced =True))
		if count_pos_roots(char) == strands - 1: 
			count = count + 1
	return count

def test_pure(strands, length, sample_size):
	count = 0
	for k in range(sample_size):
		braid = random_braid(strands,length)
		if is_pure(braid): 
			count = count + 1
	return count


def test_pure_or_pos_eig(strands, length, sample_size):
	count = 0
	for k in range(sample_size):
		braid = random_braid(strands,length)
		char = char_poly(braid.burau_matrix(var= 't',reduced =True))
		if is_pure(braid) or count_pos_roots(char) == strands - 1: 
			count = count + 1
	return count


def clear_denominators_burau(braid):
	A = braid.burau_matrix(var='t',reduced=True)
	L = A.base_ring()
	min_exp = min(e.polynomial_construction()[1] for e in A.list())
	t = L.gen()
	B = (t**-min_exp) * A
	return B.change_ring(L.polynomial_ring())



def min_positive_real_root(f):
	RR = RealField(53)
	e = min(f.exponents())
	R = f.parent()
	t = R.gen()
	f = f // t**e
	pos_roots = [r for r in f.roots(RR, multiplicities=False) if r > 0] 
	return min(pos_roots + [2])


def all_eigenvalue_positive_for_very_small_params(laurent_poly_matrix):
	"""
	Not rigorous, but could be made so
	"""
	A = clear_denominators(laurent_poly_matrix)
	p = A.det()
	r = A.characteristic_polynomial().discriminant()
	t_0 = min(min_positive_real_root(p), min_positive_real_root(r))
	t_0 = t_0/2
	print(f'Using t_0={t_0}')
	M = laurent_poly_matrix(t=t_0).numpy()
	eigs = np.linalg.eigvals(M)
	return eigs
    
    
    
