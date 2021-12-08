//
//  GameOfLifeApp.swift
//  Shared
//
//  Created by Lukas Pistrol on 07.12.21.
//

import SwiftUI

@main
struct GameOfLifeApp: App {
	
	@StateObject private var lifeModel: LifeModel = .init(with: 60)
	
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(self.lifeModel)
			#if os(macOS)
				.frame(minWidth: 500, idealWidth: 600, maxWidth: .infinity, minHeight: 600, idealHeight: 700, maxHeight: .infinity)
			#endif
        }
    }
}
