//
//  CellView.swift
//  GameOfLife
//
//  Created by Lukas Pistrol on 09.12.21.
//

import SwiftUI

/// The view for one Cell
struct CellView: View {
	// The Cell Object
	var cell: Cell
	
	var body: some View {
		Rectangle()
			.cornerRadius(2)
			.foregroundColor(cell.isAlive! ? .green : .clear)
			.aspectRatio(1, contentMode: .fit)
	}
}
