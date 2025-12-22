strands = int(input("Enter the number of strands: "))
length = int(input("Enter the length of the word: "))
sample_size = int(input("Enter the number of trials: "))

pA_real_count = 0
per_real_count = 0
red_real_count = 0

pA_count = 0
per_count = 0
red_count = 0

for k in range(sample_size):
	braid = random_braid(strands,length)
	char = char_poly(braid.burau_matrix(var= 't',reduced =True))

	if braid.is_pseudoanosov():
		pA_count = pA_count + 1
		if count_real_roots(char) == strands - 1:
			pA_real_count = pA_real_count + 1

	if braid.is_periodic():
		per_count = per_count + 1
		if count_real_roots(char) == strands - 1:
			per_real_count = per_real_count + 1

	if braid.is_reducible():
		red_count = red_count + 1
		if count_real_roots(char) == strands - 1:
			red_real_count = red_real_count + 1	

print(f"The are {pA_count} pseudo-Anosov braids of which {pA_real_count} have real eigenvalues")
print(f"The are {per_count} periodic braids of which {per_real_count} have real eigenvalues")
print(f"The are {red_count} reducible braids of which {red_real_count} have real eigenvalues")



	
