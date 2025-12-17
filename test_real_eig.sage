strands = int(input("Enter the number of strands: "))
length = int(input("Enter the length of the word: "))
sample_size = int(input("Enter the number of trials: "))

real_count = 0
periodic_count = 0
for k in range(sample_size):
	braid = random_braid(strands,length)
	if braid.is_periodic():
    	periodic_count = periodic_count + 1
  	else:
    	char = char_poly(braid.burau_matrix(var= 't',reduced =True))
	  	if count_real_roots(char) == strands - 1: 
			real_count = real_count + 1

print(f"The portion of periodic braids is {periodic_count/sample_size*100}%")
print(f"The portion of braids with all positive eigenvalues is {real_count/sample_size*100}%")
