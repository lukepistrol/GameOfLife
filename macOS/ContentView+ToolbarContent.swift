//
//  ContentView+ToolbarContent.swift
//  GameOfLife (macOS)
//
//  Created by Lukas Pistrol on 09.12.21.
//

import SwiftUI

extension ContentView {
	@ToolbarContentBuilder
	internal var toolbarContent: some ToolbarContent {
		ToolbarItem(placement: .primaryAction) { actions }
		ToolbarItem(placement: .navigation) { settingsButton }
	}
}
