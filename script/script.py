import os

folder_script = os.path.dirname(os.path.abspath(__file__))
folder_principal = os.path.dirname(folder_script)
cale_fisier = os.path.join(folder_principal, "data")
rezultat = os.path.join(cale_fisier, "intrari_test.txt")

with open(rezultat, "w") as f:
    for a in range(16):
        for b in range(16):
            f.write(f"{a:04b} {b:04b}\n")

print(f"Am generat testele cu succes in:\n{rezultat}")