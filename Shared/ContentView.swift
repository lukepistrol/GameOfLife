//
//  ContentView.swift
//  Shared
//
//  Created by Lukas Pistrol on 07.12.21.
//

import SwiftUI

struct ContentView: View {
	
	@EnvironmentObject var lifeModel: LifeModel
	
	@State private var timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
	
	var body: some View {
		VStack(spacing: 2) {
			let items: Array<GridItem> = .init(repeating: item, count: lifeModel.grid.columns)
			
			LazyVGrid(columns: items, spacing: 1) {
				ForEach(lifeModel.cells, id: \.id) { cell in
					CellView(cell: cell)
				}
			}
			.background(Color.black)
			.padding()
			HStack {
				
				Button(action: {
					self.timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
				}, label: {
					Image(systemName: "play.fill")
				})
					.help("run")
				
				Button(action: {
					self.timer.upstream.connect().cancel()
				}, label: {
					Image(systemName: "pause.fill")
				})
					.help("stop")
				
				Button(action: {
					self.lifeModel.lifeCycle()
				}, label: {
					Image(systemName: "forward.end.fill")
				})
					.help("step_forward")
				
				Button(action: {
					self.lifeModel.reset()
				}, label: {
					Image(systemName: "arrow.clockwise")
				})
					.help("reset")
				
			}
			.controlSize(.large)
			.padding()
		}
		.onReceive(timer) { _ in
			//Task(priority: .high) {
			DispatchQueue.main.async {
				lifeModel.lifeCycle()
			}
		}
	}
	
	var item: GridItem {
		var item: GridItem = .init()
		item.spacing = 1
		return item
	}
}

struct CellView: View {
	
	var cell: Cell
	
	var body: some View {
		Rectangle()
			.foregroundColor(cell.isAlive! ? .green : .clear)
			.aspectRatio(1, contentMode: .fit)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
			.environmentObject(LifeModel())
	}
}
