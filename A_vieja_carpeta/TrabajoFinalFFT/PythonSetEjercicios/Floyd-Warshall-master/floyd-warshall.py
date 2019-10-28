import sys

graphFile = open("grafo.txt")

size = graphFile.readline()
size = int(size)
graphMatrix = [[]] * size

for i in range(size):
	graphMatrix[i] = graphFile.readline()
	graphMatrix[i] = graphMatrix[i].lower().replace(' ', '').replace('\n', '')
	graphMatrix[i] = graphMatrix[i].split(',')

graphFile.close()

for k in range(size):
	for i in range(size):
		if graphMatrix[k][i] == 'n':
			graphMatrix[k][i] = sys.maxint
		else:
			graphMatrix[k][i] = int(graphMatrix[k][i])

resultMatrix = graphMatrix

for k in range(size):
	for i in range(size):
		for j in range(size):
			resultMatrix[i][j] = min(resultMatrix[i][j], resultMatrix[i][k] + resultMatrix[k][j])

resultFile = open("resultado.txt", 'w')

for i in range(size):
	resultFile.write(str(resultMatrix[i]).strip('[]') + '\n')

resultFile.close()