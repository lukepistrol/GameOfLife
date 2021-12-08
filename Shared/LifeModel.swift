//
//  LifeModel.swift
//  GameOfLife
//
//  Created by Lukas Pistrol on 07.12.21.
//

import Foundation

class LifeModel: ObservableObject {
	
	@Published var cells: Array<Cell> {
		didSet {
			self.objectWillChange.send()
		}
	}
	
	var grid: Grid
	
	var width: Int
	
	init() {
		self.grid = .init(columns: 30, rows: 30)
		self.cells = self.grid.initializeCells()
		self.width = 30
	}
	
	init(with canvasSize: Int) {
		self.width = canvasSize
		self.grid = .init(columns: canvasSize, rows: canvasSize)
		self.cells = self.grid.initializeCells()
	}
	
	func reset() {
		self.grid = .init(columns: width, rows: width)
		self.cells = self.grid.initializeCells()
	}
	
	func lifeCycle() {
		// Measurments
		let start = CFAbsoluteTimeGetCurrent()
		var count = 0
		
		var nextCells: Array<Cell> = []
		for cell in cells {
			nextCells.append(getCellForNextCycle(for: cell))
			count += 1
		}
		
		let diff1 = CFAbsoluteTimeGetCurrent() - start
		self.cells = nextCells
		let diff2 = CFAbsoluteTimeGetCurrent() - start
		print("Took \(diff1), \(diff2) seconds; \(count) iterations") // 3.6s
	}
	
	private func getCellForNextCycle(for cell: Cell) -> Cell {
		let neighbors = getNeighbors(for: cell)
		var cell = cell
		if cell.isAlive! {
			//underpopulation
			if neighbors.count < 2 {
				cell.isAlive = false
			}
			
			if (2...3).contains(neighbors.count) {
				cell.isAlive = true
			}
			//overpopulation
			if neighbors.count > 3 {
				cell.isAlive = false
			}
		} else {
			if neighbors.count == 3 {
				cell.isAlive = true
			} else {
				cell.isAlive = false
			}
		}
		return cell
	}
	
	private func getNeighbors(for cell: Cell) -> Array<Cell> {
		var neighbors: Array<Cell> = []
		
		cell.neighbors.forEach { potentialNeighbor in
			if potentialNeighbor.column < 0 || potentialNeighbor.row < 0 || potentialNeighbor.column >= grid.columns || potentialNeighbor.row >= grid.rows { return }
			
			let index = potentialNeighbor.row * grid.columns + potentialNeighbor.column // calculating the index is about 200 times faster than cell.first(where:)
			let neighbor = self.cells[index]
			if neighbor.isAlive ?? false {
				neighbors.append(neighbor)
			}
		}
		return neighbors
	}
	
}

struct Grid {
	let columns: Int
	let rows: Int
	
	func initializeCells() -> Array<Cell> {
		var cells: Array<Cell> = []
		for row in 0..<rows {
			for column in 0..<columns {
				let cell = Cell(column: column, row: row, isAlive: Bool.random())
				cells.append(cell)
			}
		}
		return cells
	}
}

struct Cell: Identifiable {
	var id: String
	let column: Int
	let row: Int

	var isAlive: Bool? = nil
	
	var neighbors: Array<Cell>

	init(column: Int, row: Int) {
		self.column = column
		self.row = row
		self.isAlive = nil
		self.neighbors = []
		self.id = "\(column)\(row)"
	}
	
	init(column: Int, row: Int, isAlive: Bool) {
		self.column = column
		self.row = row
		self.isAlive = isAlive
		self.neighbors = [.init(column: self.column - 1, row: self.row - 1),
						  .init(column: self.column - 1, row: self.row),
						  .init(column: self.column - 1, row: self.row + 1),
						  .init(column: self.column, row: self.row - 1),
						  .init(column: self.column, row: self.row + 1),
						  .init(column: self.column + 1, row: self.row - 1),
						  .init(column: self.column + 1, row: self.row),
						  .init(column: self.column + 1, row: self.row + 1)]
		self.id = column.description + row.description
	}
	
}
