//
//  ContentView+ToolbarContent.swift
//  GameOfLife (iOS)
//
//  Created by Lukas Pistrol on 09.12.21.
//

import SwiftUI

extension ContentView {
	@ToolbarContentBuilder
	internal var toolbarContent: some ToolbarContent {
		ToolbarItem(placement: .bottomBar) { actions }
		ToolbarItem(placement: .navigationBarLeading) { settingsButton }
	}
}
