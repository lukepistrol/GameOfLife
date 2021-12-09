//
//  ContentView+Grid.swift
//  GameOfLife (iOS)
//
//  Created by Lukas Pistrol on 09.12.21.
//

import SwiftUI

extension ContentView {
	
	/// Array of GridItem (grid.columns)
	internal var items: Array<GridItem> {
		var item: GridItem = .init()
		item.spacing = 1
		return .init(repeating: item, count: lifeModel.grid.columns)
	}
	
	/// The grid layout of the Cells
	internal var grid: some View {
		VStack(spacing: 1) {
			LazyVGrid(columns: items, spacing: 1) {
				ForEach(lifeModel.cells, id: \.id) { cell in
					CellView(cell: cell)
				}
			}
			.aspectRatio(1, contentMode: .fit)
			.padding()
		}
	}
}
