strands = int(input("Enter the number of strands: "))
length = int(input("Enter the length of the word: "))
sample_size = int(input("Enter the number of trials: "))

pA_real_count = 0
per_real_count = 0
red_real_count = 0

pA_count = 0
per_count = 0
red_count = 0

multi_roots_count = 0 

for k in range(sample_size):
	braid = random_braid(strands,length)
	char = char_poly(braid.burau_matrix(var= 't',reduced =True))
	char_der = char.derivative()

	if gcd(char,char_der) != 1:
		multi_roots_count = multi_roots_count + 1
		print(f"The braid {braid} has repeated eigenavlues")
		print(f"The characteristic polynomial is {char}")

	if braid.is_pseudoanosov():
		pA_count = pA_count + 1
		if count_real_roots(char) == strands - 1:
			pA_real_count = pA_real_count + 1
		else:
			print(f"The pA braid {braid} does not have all real eigenvalues")

	if braid.is_periodic():
		per_count = per_count + 1
		if count_real_roots(char) == strands - 1:
			per_real_count = per_real_count + 1
			print(f"The periodic braid {braid} does have all real eigenvalues")

	if braid.is_reducible():
		red_count = red_count + 1
		if count_real_roots(char) == strands - 1:
			red_real_count = red_real_count + 1
		else:
			print(f"The reducible braid {braid} does not have all real eigenvalues")

print()
print(f"There are {pA_count} pA braids of which {pA_real_count} have real eigenvalues")
print(f"There are {per_count} periodic braids of which {per_real_count} have real eigenvalues")
print(f"There are {red_count} reducible braids of which {red_real_count} have real eigenvalues")
print(f"There are {multi_roots_count} braids with repeated eigenvalues")


	
