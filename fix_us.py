import sys
with open(sys.argv[1]) as f:
	for line in f:
		if 'lbl' in line or 'func' in line:
			addr = line[-9:-1]
			print(line[:-1]+" = 0x"+addr+";")
		else:
			print(line[:-1])
