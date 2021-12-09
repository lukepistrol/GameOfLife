//
//  CustomNavigationView.swift
//  GameOfLife
//
//  Created by Lukas Pistrol on 09.12.21.
//

import SwiftUI

/// Embedds Content in NavigationView on iOS.
/// Returns Content without change in macOS.
struct CustomNavigationView<Content: View>: View {
	var content: Content
	
	init(@ViewBuilder content: () -> Content) {
		self.content = content()
	}
	
    var body: some View {
		#if os(macOS)
        content
		#else
		NavigationView {
			content
		}
		.navigationViewStyle(.stack)
		#endif
    }
}

