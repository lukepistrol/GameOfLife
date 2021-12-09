//
//  ContentView+ToolbarActions.swift
//  GameOfLife (iOS)
//
//  Created by Lukas Pistrol on 09.12.21.
//

import SwiftUI

extension ContentView {
	
	/// Toolbar Actions for play/pause, next step, restart
	internal var actions: some View {
		ControlGroup {
			Button {
				if isRunnung { cancelTimer() }
				else { setupTimer() }
			} label: {
				Image(systemName: isRunnung ? "pause" : "play")
			}
			.help(isRunnung ? "Pause" : "Resume")
			
			Button(action: self.lifeModel.lifeCycle) {
				Image(systemName: "arrow.turn.up.right")
			}
			.disabled(isRunnung)
			.help("Next Step")
			
			Button(action: self.lifeModel.reset) {
				Image(systemName: "arrow.clockwise")
			}
			.help("Restart")
		}
	}
	
	/// Settings Button
	internal var settingsButton: some View {
		Button(action: {
			displaySettings = true
		}, label: {
			Image(systemName: "gear")
		})
			.help("Setup")
	}
}
