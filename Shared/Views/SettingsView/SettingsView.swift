//
//  SettingsView.swift
//  GameOfLife
//
//  Created by Lukas Pistrol on 09.12.21.
//

import SwiftUI

/// Settings View
struct SettingsView: View {
	@Environment(\.dismiss) private var dismiss
	@EnvironmentObject private var lifeModel: GOLModel
	
    var body: some View {
		CustomNavigationView {
			Form {
				// Canvas Width
				Stepper("Canvas Width \(lifeModel.grid.columns)") {
					lifeModel.setGridSize(lifeModel.grid.columns + 1)
				} onDecrement: {
					lifeModel.setGridSize(lifeModel.grid.columns - 1)
				}
			}
			.navigationTitle("Settings")
			.toolbar {
				ToolbarItem(placement: .confirmationAction) {
					Button("Done") { dismiss() }
				}
			}
		}
		#if os(macOS)
		.padding()
		.frame(width: 300)
		#endif
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
