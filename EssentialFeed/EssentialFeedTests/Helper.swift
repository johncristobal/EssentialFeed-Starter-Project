//
//  Helper.swift
//  EssentialFeedTests
//
//  Created by JOHN CRIS on 17/02/26.
//

import XCTest

// trackForMemoryLeaks Helper function generic
extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
