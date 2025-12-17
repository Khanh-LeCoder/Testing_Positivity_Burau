strands = input("Enter the number of strands: ")
sample_size = input("Enter the number of trials: ")
length = input("Enter the length of the word: ")

positive_count = test_pos_eig(strands, length, sample_size)

print(f"The portion of braids with all positive eigenvalues is " positive_count/sample_size)



