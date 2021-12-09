//
//  GameOfLifeApp.swift
//  Shared
//
//  Created by Lukas Pistrol on 07.12.21.
//

import SwiftUI

@main
struct GameOfLifeApp: App {
	
	@StateObject private var lifeModel: GOLModel = .init(with: 30)
	
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(self.lifeModel)
			#if os(macOS)
				.frame(width: 900, height: 900)
			#endif
				.preferredColorScheme(.dark)
        }
    }
}
