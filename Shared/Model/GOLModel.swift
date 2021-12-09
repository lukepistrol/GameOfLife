//
//  GOLModel.swift
//  GameOfLife
//
//  Created by Lukas Pistrol on 07.12.21.
//

import Foundation

/// The View Model for the Game Of Life.
class GOLModel: ObservableObject {
	
	// MARK: - PROPERTIES
	
	/// Contains all cells
	@Published private (set) var cells: Array<Cell> = []
	
	/// The Grid object which manages creation of cells
	public var grid: Grid = .init(columns: 30, rows: 30)
	
	/// The preferred width & height of the Grid
	private var gridSize: Int = 30
	
	
	// MARK: - INIT
	
	/// Initializer without options
	init() {
		reset()
	}
	
	/// Initializer with size
	/// - Parameter size: the width & height of the grid
	init(with size: Int) {
		self.gridSize = size
		reset()
	}
	
	
	// MARK: - INTENTS
	
	/// Lets the user change the grid size
	/// - Parameter size: the width & height of the grid
	public func setGridSize(_ size: Int) {
		gridSize = size
		reset()
	}
	
	/// Resets the grid and starts from a new random sample of cells
	public func reset() {
		self.grid = .init(columns: gridSize, rows: gridSize)
		self.cells = self.grid.initializeCells()
	}
	
	/// Starts the next life cycle for the cells
	public func lifeCycle() {
		var nextCells: Array<Cell> = []
		
		// loop through all cells and calculate new cells
		for cell in cells {
			nextCells.append(getCellForNextCycle(for: cell))
		}
		
		// overwrite current cells
		self.cells = nextCells
	}
	
	
	// MARK: - METHODS
	
	/// Calculate the value of the cell for the next life cycle
	/// - Parameter cell: a Cell
	/// - Returns: a new Cell
	private func getCellForNextCycle(for cell: Cell) -> Cell {
		
		// get the alive neighbor cells of the cell
		let neighbors = getAliveNeighbors(for: cell)
		
		// create a new cell at the coordinates of the reference cell
		var newCell = Cell(column: cell.column, row: cell.row, isAlive: false)
		
		// Cell is alive
		// Cell dies due to underpopulation
		if cell.isAlive!, neighbors.count < 2 {
			newCell.isAlive = false
		} else
		
		// Cell is alive
		// Cell stays alive
		if cell.isAlive!, (2...3).contains(neighbors.count) {
			newCell.isAlive = true
		} else
		
		// Cell is alive
		// Cell dies due to overpopulation
		if cell.isAlive!, neighbors.count > 3 {
			newCell.isAlive = false
		} else
		
		// Cell is dead
		// Cell comes to life
		if !cell.isAlive!, neighbors.count == 3 {
			newCell.isAlive = true
		}
		
		// Cell is dead
		// Cell stays dead
		else {
			newCell.isAlive = false
		}
		return newCell
	}
	
	/// Calculate alive Neighbors of a Cell
	/// - Parameter cell: a Cell
	/// - Returns: an Array of Cells (neighbors of Cell)
	private func getAliveNeighbors(for cell: Cell) -> Array<Cell> {
		var neighbors: Array<Cell> = []
		
		// loop over every neighbor of the cell
		cell.neighbors.forEach { potentialNeighbor in
			
			//check if neighbor is in bounds of grid, otherwise return
			if potentialNeighbor.column < 0 || potentialNeighbor.row < 0 ||
				potentialNeighbor.column >= grid.columns || potentialNeighbor.row >= grid.rows
			{ return }
			
			// calculate the index of the neighbor in cells array
			// *** Note: calculating the index is about 200 times faster than cell.first(where:)
			let index = potentialNeighbor.row * grid.columns + potentialNeighbor.column
			
			// get the neighbor at index
			let neighbor = self.cells[index]
			
			// only add neighbor too array when alive
			if neighbor.isAlive! {
				neighbors.append(neighbor)
			}
		}
		return neighbors
	}
	
}




