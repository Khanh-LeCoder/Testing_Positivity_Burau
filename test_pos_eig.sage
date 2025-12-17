strands = input("Enter the number of strands: ")
length = input("Enter the length of the word: ")
sample_size = input("Enter the number of trials: ")

pos_count = test_pos_eig(strands, length, sample_size)

print(f"The portion of braids with all positive eigenvalues is {pos_count/sample_size}")



