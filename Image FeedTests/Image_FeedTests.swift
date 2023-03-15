//
//  Image_FeedTests.swift
//  Image FeedTests
//
//  Created by Respect on 02.03.2023.
//
@testable import ImageFeed

import XCTest

final class ImagesListServiceTests: XCTestCase {
    
    
    func testExample() throws {
        let service = ImageListService()
        
        let expectation = self.expectation(description: "Wait for Notification")
        NotificationCenter.default.addObserver(
            forName: ImageListService.didChangeNotification,
            object: nil,
            queue: .main) { _ in
                expectation.fulfill()
            }
        
        service.fetchPhotosNextPage()
        wait(for: [expectation], timeout: 10)
        
        XCTAssertEqual(service.photos.count, 10)
    }
}
