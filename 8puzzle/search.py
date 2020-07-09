import random
import time
import collections

#Por conveniencia leer de abajo para arriba
def a_star1(board):
	priority_queue = collections.deque([Node(board,-1,None)])
	visited = set()
	visited.add(priority_queue[0].id)
	while priority_queue:
		priority_queue = collections.deque(sorted(list(priority_queue),key = lambda node: node.f1))
		node = priority_queue.popleft()
		if node.board.isSolved:
			return True
		for move in range(4):
			childBoard = node.board.copy()
			childBoard.action(move)
			child = Node(childBoard, move, node)

			if child.id not in visited:
				priority_queue.appendleft(child)
				visited.add(child.id)
				nodeCnt += 1

def a_star2(board):
	root = Node(board,-1,None)
	priority_queue = collections.deque([root])
	visited = set()
	visited.add(root.id)
	while priority_queue:
		priority_queue = collections.deque(sorted(list(priority_queue),key = lambda node: node.f2))
		node = priority_queue.popleft()
		if node.board.isSolved:
			return True
		for move in range(4):
			childBoard = node.board.copy()
			childBoard.action(move)
			child = Node(childBoard, move, node)

			if child.id not in visited:
				nodeCnt +=1
				priority_queue.appendleft(child)
				visited.add(child.id)

def bfs(board):
	root = Node(board,-1,None)
	queue = collections.deque([root])
	visited = set()
	visited.add(root.id)
	while queue:
		node = queue.popleft()
		if node.board.isSolved:
			return True
		for move in range(4):
			childBoard = node.board.copy()
			childBoard.action(move)
			child = Node(childBoard, move, node)

			if child.id not in visited:
				nodeCnt += 1
				queue.appendleft(child)
				visited.add(child.id)

def l_dfs(node,visited,depth):
	if node.id in visited or node.g > depth:
		return False
	if node.board.isSolved:
		return True
	visited.add(node.id)
	
	for move in range(4):
		childBoard = node.board.copy()
		childBoard.action(move)
		child = Node(childBoard, move, node)
		l_dfs(child,visited,depth)

def i_dfs(board):
	root = Node(board,-1,None)
	visited = set()
	for depth in range(25):
		if l_dfs(root,visited,depth):
			return True

class Node:
	def __init__(self, board, move, parent):
		self.board = board
		self.move = move
		self.parent = parent
		if(self.parent==None):
			self.g = 0
		else:
			self.g = self.parent.g + 1

	def id(self):
		return str(self)

	def f1(self):
		return self.g + self.board.manhattan

	def f2(self):
		return self.g + self.board.misplaced

class Board:
	def __init__(self,board):
		self.board = board
		#posición del hueco en el tablero
		self.i = 2
		self.j = 2
	
	def manhattan(self):
		distance = 0
		for i in range(3):
			for j in range(3):
				if(self.board[i][j]!=0):
					x = (self.board[i][j]-1)/3
					y = (self.board[i][j]-1)%3
					distance += abs(i-x) + abs(j-y)
		return distance

	def misplaced(self):
		count = 0
		for i in range(3):
			for j in range(3):
				if(self.board[i][j]!= (i*3)+j+1):
					count += 1
		return count

	#Determina si el tablero está resuelto
	def isSolved(self):
		for i in range(3):
			for j in range(3):
				if(self.board[i][j]!=((i*3)+j+1)):
					return False
		return True

	#Retorna una copia del tablero
	def copy(self):
		copyBoard = [[0,0,0],[0,0,0],[0,0,0]]
		for i in range(3):
			for j in range(3):
				copyBoard[i][j] = self.board[i][j]
		return Board(copyBoard)

	#Movimiento de la ficha
	def action(self,move):
		#Arriba
		if(move==0):
			if(self.i-1>=0):
				self.board[self.i][self.j] = self.board[self.i-1][self.j]
				self.board[self.i-1][self.j] = 0
				self.i -= 1
			else:
				self.action((move+1)%4)
		#Derecha
		if(move==1):
			if(self.j+1<3):
				self.board[self.i][self.j] = self.board[self.i][self.j+1]
				self.board[self.i][self.j+1] = 0
				self.j += 1
			else:
				self.action((move+1)%4)
		#Arriba
		if(move==2):
			if(self.i+1<3):
				self.board[self.i][self.j] = self.board[self.i+1][self.j]
				self.board[self.i+1][self.j] = 0
				self.i += 1
			else:
				self.action((move+1)%4)
		#Izquierda
		if(move==3):
			if(self.j-1>=0):
				self.board[self.i][self.j] = self.board[self.i][self.j-1]
				self.board[self.i][self.j-1] = 0
				self.j -=1
			else:
				self.action((move+1)%4)
	
	#Realiza al puzzle 14 movimientos aleatorios
	def shuffle(self):
		prevMove = 0
		for i in range(14):
			move = random.randrange(0,4)
			#checkea que la nueva jugada no deshaga la anterior
			if((move+2)%4 == prevMove):
				move = (move+1)%4
			self.action(move)
			prevMove = move

#Resuelve un tablero para las 4 búsquedas
def solve():
	init = [[1,2,3],[4,5,6],[7,8,0]]
	puzzle1 = Board(init)
	puzzle1.shuffle()
	puzzle2 = puzzle1.copy()
	puzzle3 = puzzle1.copy()
	puzzle4 = puzzle1.copy()
	
	results = ""
	#A* con manhattan
	tic = time.perf_counter()
	a_star1(puzzle1)
	toc = time.perf_counter	()
	results += "\t"+str(toc-tic)[0:6]

	#A* con mal colocadas
	tic = time.perf_counter()
	a_star2(puzzle2)
	toc = time.perf_counter()
	results += "\t"+str(toc-tic)[0:6]

	#Busqueda en profundidad iterativa
	tic = time.perf_counter()
	i_dfs(puzzle4)
	toc = time.perf_counter()
	results += "\t"+str(toc-tic)[0:6]

	#Busqueda en amplitud
	tic = time.perf_counter()
	bfs(puzzle3)
	toc = time.perf_counter()
	results += "\t"+str(toc-tic)[0:6]

	print(results)

#Se aplica el procedimiento 30 veces
def run():
	print("Tiempo")
	print("\tBFS\tIDFS\tA*(h2)\tA*(h1)")
	for i in range(30):
		solve()

run()
