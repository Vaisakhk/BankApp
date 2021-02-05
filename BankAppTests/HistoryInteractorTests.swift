//
//  HistoryInteractorTests.swift
//  BankAppTests
//
//  Created by User on 1/31/21.
//

import XCTest
@testable import BankApp

class HistoryInteractorTests: XCTestCase {

    var mockPresenter:FakeHistoryInteractionToPresenter?
    var sut :HistoryInteractor?
    let BOB = "Bobtest"
    let ALICE = "Alicetest"
    
    override func setUpWithError() throws {
        mockPresenter = FakeHistoryInteractionToPresenter()
        sut = HistoryInteractor()
        sut?.presenter = mockPresenter
        
        let history  = CoreDataHandler.sharedInstance.newEntityForName(entityName: "History") as? History
        history?.name = BOB
        history?.amount =  20.0
        history?.type = "Pay Now"
        history?.payee = ALICE
        history?.date = "31/01/2021 18:00:00"
        
        let secondHistory  = CoreDataHandler.sharedInstance.newEntityForName(entityName: "History") as? History
        secondHistory?.name = BOB
        secondHistory?.amount =  40.0
        secondHistory?.type = "Top up"
        secondHistory?.payee = ""
        secondHistory?.date = "31/01/2021 18:00:00"
        CoreDataHandler.sharedInstance.saveContext()
        
    }

    override func tearDownWithError() throws {
        CoreDataHandler.sharedInstance.deleteAllDataWithCondition(name: "History", predicate: NSPredicate(format: "name == %@", BOB))
        CoreDataHandler.sharedInstance.deleteAllDataWithCondition(name: "History", predicate: NSPredicate(format: "payee == %@", ALICE))
    }
    
    /*
     * Test Get History Details
     */
    func testGetHistoryDetails() {
        sut?.getHistoryDetails(name: BOB)
        XCTAssertEqual((mockPresenter?.fakeHistory?.count ?? 0) > 0 , true, "Transaction History is empty")
        XCTAssertEqual((mockPresenter?.fakeHistory?.count ?? 0) == 2 , true, "Transaction History count is not 2")
        let historyData = mockPresenter?.fakeHistory?.first
        XCTAssertEqual(historyData?.name == BOB , true, "Transaction History is empty")
        let historySecondData = mockPresenter?.fakeHistory?[1]
        XCTAssertEqual(historySecondData?.date == "31/01/2021 18:00:00" , true, "Transaction date not matching")
       
    }

}

//MARK:- Mock up Home interactor to presenter protocol
class FakeHistoryInteractionToPresenter: HistoryInteractorToPresenterProtocol {
    var fakeErrorString:String?
    var fakeHistory:[History]?
    
    func historyDetailsCompletedWithSuccess(data: [History]) {
        fakeHistory = data
    }
    
    func historyDetailsWithError(errorString: String) {
        fakeErrorString = errorString
    }
    
}
