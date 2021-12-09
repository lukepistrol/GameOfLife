//
//  Cell.swift
//  GameOfLife
//
//  Created by Lukas Pistrol on 09.12.21.
//

import Foundation

/// A Cell in the Grid
struct Cell: Identifiable, Hashable {
	
	/// ID of the Cell (HashValue)
	public var id: String { self.hashValue.description }
	
	/// The Column coordinate of the Cell
	public let column: Int
	
	/// The Row coordinate of the Cell
	public let row: Int
	
	/// The Alive State of the Cell
	/// This can be 'nil' when cell is a neighbor of another cell
	public var isAlive: Bool? = nil
	
	/// An array of neighbors
	/// [] when cell is a neighbor itself
	private (set) var neighbors: Array<Cell>
	
	/// Initialize as Neighbor Cell
	/// - Parameters:
	///   - column: The Column Coordinate
	///   - row: The Row Coordinate
	init(column: Int, row: Int) {
		self.column = column
		self.row = row
		self.isAlive = nil
		self.neighbors = []
	}
	
	/// Initialize as Regular Cell
	/// - Parameters:
	///   - column: The Column Coordinate
	///   - row: The Row Coordinate
	///   - isAlive: State of the cell [true = alive, false = dead]
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
	}
}
