//
//  Grid.swift
//  GameOfLife
//
//  Created by Lukas Pistrol on 09.12.21.
//

import Foundation

/// The Grid of Cells
struct Grid {
	
	/// Number of columns in the grid
	let columns: Int
	
	/// Number of rows in the grid
	/// Defaults to the number of columns
	let rows: Int
	
	
	/// Initialize all Cells for the Grid
	/// - Returns: an array of Cells
	func initializeCells() -> Array<Cell> {
		var cells: Array<Cell> = []
		
		// loop over each row
		for row in 0..<rows {
			
			// loop over each column
			for column in 0..<columns {
				
				// create a new cell with random alive state
				let cell = Cell(column: column, row: row, isAlive: Bool.random())
				cells.append(cell)
			}
		}
		return cells
	}
}
