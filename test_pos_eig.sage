strands = int(input("Enter the number of strands: "))
length = int(input("Enter the length of the word: "))
sample_size = int(input("Enter the number of trials: "))

pos_count = test_pos_eig(strands, length, sample_size)

print(f"The portion of braids with all positive eigenvalues is {pos_count/sample_size*100}%")

