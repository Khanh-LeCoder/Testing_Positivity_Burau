strands = int(input("Enter the number of strands: "))
length = int(input("Enter the length of the word: "))
sample_size = int(input("Enter the number of trials: "))

real_count = test_real_eig(strands, length, sample_size)

print(f"The portion of braids with all positive eigenvalues is {real_count/sample_size*100}%")
