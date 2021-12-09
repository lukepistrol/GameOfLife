//
//  Tests_macOS.swift
//  Tests macOS
//
//  Created by Lukas Pistrol on 07.12.21.
//

import XCTest
import GameOfLife

class Tests_macOS: XCTestCase {
	func testRuntimeAverage30() {
		let runtime = 1000
		let model = LifeModel(with: 30)
		var totalTime: Double = 0
		for _ in 0..<runtime {
			let start = CFAbsoluteTimeGetCurrent()
			model.lifeCycle()
			totalTime += CFAbsoluteTimeGetCurrent() - start
		}
		let avg = totalTime/Double(runtime)
		print("---------------------\n\t🟢 Took \(avg) on average\n\t\t\(totalTime) total\n---------------------")
		XCTAssertLessThan(avg, 0.0035)
	}
	
	func testRuntimeAverage10() {
		let runtime = 1000
		let model = LifeModel(with: 10)
		var totalTime: Double = 0
		for _ in 0..<runtime {
			let start = CFAbsoluteTimeGetCurrent()
			model.lifeCycle()
			totalTime += CFAbsoluteTimeGetCurrent() - start
		}
		let avg = totalTime/Double(runtime)
		print("---------------------\n\t🟢 Took \(avg) on average\n\t\t\(totalTime) total\n---------------------")
		XCTAssertLessThan(avg, 0.0035)
	}
	
	func testRuntimeAverage100() {
		let runtime = 100
		let model = LifeModel(with: 100)
		var totalTime: Double = 0
		for _ in 0..<runtime {
			let start = CFAbsoluteTimeGetCurrent()
			model.lifeCycle()
			totalTime += CFAbsoluteTimeGetCurrent() - start
		}
		let avg = totalTime/Double(runtime)
		print("---------------------\n\t🟢 Took \(avg) on average\n\t\t\(totalTime) total\n---------------------")
		XCTAssertLessThan(avg, 0.041)
	}
}
