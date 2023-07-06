liste_kcpro = [7, 9, 10, 20, 31, 37, 38, 46, 47, 52, 56, 60, 68, 71, 78, 85, 91, 92, 100, 110, 111, 116, 119, 120, 123, 129, 131, 136, 140, 142, 145, 152, 154, 162, 169, 170, 172, 175, 178, 186, 189, 191, 196, 197, 198, 199, 200, 213, 216, 218, 220, 227, 228, 229, 231, 232, 234, 235, 238, 239, 240, 241, 242, 245, 249, 250, 251, 254, 258, 265, 267, 268, 269, 274, 304, 307]
liste_kcv = [9, 11, 196, 10, 100, 189, 120, 177, 24, 64, 84, 56, 62, 119, 141, 153, 104, 79, 47, 6, 25, 124, 282, 58, 236, 131, 255, 207, 5, 4, 81, 23, 96, 91, 53]
unique_numbers = liste_kcpro[:]
for item in liste_kcv:
    while item in unique_numbers:
        unique_numbers.remove(item)

unique_numbers.sort()

unique_numbers_string = ",".join(map(str, unique_numbers))

print("wget -N -b --progress=bar https://distrib-cours.keepcoolpro.fr/{{{}}}.mp4".format(unique_numbers_string))
print("wget -N -b --progress=bar https://distrib-cours.keepcoolpro.fr/{{{}}}.png".format(unique_numbers_string))