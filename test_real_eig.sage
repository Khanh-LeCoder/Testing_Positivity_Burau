strands = input("Enter the number of strands: ")
length = input("Enter the length of the word: ")
sample_size = input("Enter the number of trials: ")

real_count = test_real_eig(strands, length, sample_size)

print(f"The portion of braids with all positive eigenvalues is {real_count/sample_size*100}")
