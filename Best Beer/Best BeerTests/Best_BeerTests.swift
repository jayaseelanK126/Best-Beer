//
//  Best_BeerTests.swift
//  Best BeerTests
//
//  Created by Pyramid on 13/11/21.
//

import XCTest
@testable import Best_Beer

class Best_BeerTests: XCTestCase {
    
    //MARK: - Variable Declarations
    var webServiceHelper: NetworkManager!
    var viewModelObj: BeerListModelView!

    override func setUpWithError() throws {
        webServiceHelper = NetworkManager()
        viewModelObj = BeerListModelView()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Networkmanager_With_ValidRequest_Returns_BeerDataResponse()
    {
        //Arrange
        let expectation = self.expectation(description: "ValidRequest_Returns_BeerDataResponse")
        
        // Act
        NetworkManager.GETMethodRequest(foodName: "tacos") { result in
            
            if let safeData = result
            {
                let jsonObj = Parser.parseBeerList(apiResponse: safeData)
                
                self.viewModelObj.insertBeerData(jsonObj, foodName: "") {
                    self.viewModelObj.fetchBeerData("") { value in
                        //Assert
                        XCTAssertNotNil(value)
                        XCTAssertNotEqual(0, value.count)
                    }
                    
                    //Assert
                    XCTAssertNotNil(jsonObj)
                }
                
                //Assert
                XCTAssertNotNil(safeData)
                
                expectation.fulfill()
            }
            
        } Failure: { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 60, handler: nil)
    }
    
    func test_Networkmanager_With_InvalidRequest_Returns_BeerDataResponse()
    {
        //Arrange
        let expectation = self.expectation(description: "InvalidRequest_Returns_BeerDataResponse")
        
        // Act
        NetworkManager.GETMethodRequest(foodName: "") { result in
            
            if let safeData = result
            {
                let jsonObj = Parser.parseBeerList(apiResponse: safeData)
                
                self.viewModelObj.insertBeerData(jsonObj, foodName: "") {
                    self.viewModelObj.fetchBeerData("") { value in
                        //Assert
                        XCTAssertNotEqual(0, value.count)
                    }
                }
                
                //Assert
                XCTAssertNotNil(result)
                expectation.fulfill()
            }
            
        } Failure: { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 60, handler: nil)

    }
}
