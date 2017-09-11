from subprocess import call

with open("wram_labels.txt", "r") as f:
	while True:
		line = f.readline()
		if line == "":
			break
		
		line = line[8:].rstrip()
		if line[0] != "w":
			call(["sh", "replace.sh", line, "w" + line[0:]])
			print line + " -> w" + line[0:]