//
//  FlickrImageListTests.swift
//  FlickrImageListTests
//
//  Created by Pooja Chaudhary on 22/02/22.
//

import XCTest
@testable import FlickrImageList

class FlickrImageListTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testApiKeyConstantLength() {
        let apiKey = Constants.apiKey
        XCTAssertTrue(apiKey.count > 0)
    }
    func testSearchURLConstantLength() {
        let searchURL = Constants.searchURL
        XCTAssertTrue(searchURL.count > 0)
    }
    func testDownloadImageURLConstantLength() {
        let downloadImageURL = Constants.downloadImageURL
        XCTAssertTrue(downloadImageURL.count > 0)
    }
    func testAPISuccessOrFailure() {
        let expectation = expectation(description: "Flickr Images List")
        let viewModel = FlickrImageListViewModel()
        var apiStatus: Bool?
        viewModel.loadFlickrImages { status in
            apiStatus = status
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10) { error in
            XCTAssertNotNil(apiStatus)
            XCTAssertTrue(apiStatus ?? false)
        }
    }
    func testFlickrImageListCount() {
        let expectation = expectation(description: "Flickr Images List")
        let viewModel = FlickrImageListViewModel()
        viewModel.loadFlickrImages { status in
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10) { error in
            XCTAssertTrue(viewModel.flickrImageList.count > 0)
        }
    }
    func testPhotoListPerPageCount() {
        let expectation = expectation(description: "Flickr Images List")
        let viewModel = FlickrImageListViewModel()
        viewModel.loadFlickrImages(page: 2) { status in
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10) { error in
            XCTAssertEqual(viewModel.flickrImageList.count, 100)
        }
    }
}
