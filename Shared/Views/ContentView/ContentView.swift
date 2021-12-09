//
//  ContentView.swift
//  Shared
//
//  Created by Lukas Pistrol on 07.12.21.
//

import SwiftUI

struct ContentView: View {
	@EnvironmentObject internal var lifeModel: GOLModel
	
	/// Refresh Timer
	@State internal var timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
	
	/// States wether the timer is running
	@State internal var isRunnung: Bool = true
	
	/// States if SettingsView is shown
	@State internal var displaySettings: Bool = false
	
	
	var body: some View {
		CustomNavigationView {
			grid
			.navigationTitle("Game of Life")
			.toolbar { toolbarContent }
		}
		.onReceive(timer) { _ in
			DispatchQueue.main.async { lifeModel.lifeCycle() }
		}
		.onAppear(perform: cancelTimer)
		.sheet(isPresented: $displaySettings) {	SettingsView() }
	}
	
	/// Start refreshing
	internal func setupTimer() {
		self.isRunnung = true
		self.timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
	}
	
	/// Stop refreshing
	internal func cancelTimer() {
		self.isRunnung = false
		self.timer.upstream.connect().cancel()
	}
}



// MARK: - PREVIEWS

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		let model = GOLModel(with: 12)
		#if os(macOS)
		ContentView()
			.environmentObject(model)
		#else
		ContentView()
			.environmentObject(model)
			.previewDevice("iPhone 12")
		ContentView()
			.environmentObject(model)
			.previewDevice("iPad Pro (11-inch) (2nd generation)")
			.previewInterfaceOrientation(.landscapeLeft)
		#endif
	}
}
