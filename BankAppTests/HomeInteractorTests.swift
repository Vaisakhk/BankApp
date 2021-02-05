//
//  HomeInteractorTests.swift
//  BankAppTests
//
//  Created by User on 1/31/21.
//

import XCTest
@testable import BankApp

class HomeInteractorTests: XCTestCase {

    var mockPresenter:FakeHomeInteractionToPresenter?
    var sut :HomeInteractor?
    let BOB = "Bobtest"
    let ALICE = "Alicetest"
        
    override func setUpWithError() throws {
        mockPresenter = FakeHomeInteractionToPresenter()
        sut = HomeInteractor()
        sut?.presenter = mockPresenter
        
        let bobUser:User = CoreDataHandler.sharedInstance.newEntityForName(entityName: "User") as! User
        bobUser.name = BOB
        bobUser.balance = 100
        
        let aliceUser:User = CoreDataHandler.sharedInstance.newEntityForName(entityName: "User") as! User
        aliceUser.name = ALICE
        aliceUser.balance = 20
        
        CoreDataHandler.sharedInstance.saveContext()
    }

    override func tearDownWithError() throws {
        CoreDataHandler.sharedInstance.deleteAllDataWithCondition(name: "User", predicate: NSPredicate(format: "name == %@", BOB))
        CoreDataHandler.sharedInstance.deleteAllDataWithCondition(name: "User", predicate: NSPredicate(format: "name == %@", ALICE))
        CoreDataHandler.sharedInstance.deleteAllDataWithCondition(name: "History", predicate: NSPredicate(format: "name == %@", ALICE))
        CoreDataHandler.sharedInstance.deleteAllDataWithCondition(name: "History", predicate: NSPredicate(format: "name == %@", BOB))
        CoreDataHandler.sharedInstance.deleteAllDataWithCondition(name: "History", predicate: NSPredicate(format: "payee == %@", ALICE))
        CoreDataHandler.sharedInstance.deleteAllDataWithCondition(name: "History", predicate: NSPredicate(format: "payee == %@", BOB))
        
    }
    
    /*
     * Test save Top up amount method
     */
    func testTopUpAmount() {
        sut?.topUpAmount(with: "20", username: BOB)
        XCTAssertEqual((mockPresenter?.fakeAmount ?? 0) == 120.0, true,"Balance Not matching for Bob")
        XCTAssertNil( mockPresenter?.fakeErrorString,"Error is not Nil")
        sut?.topUpAmount(with: "100", username: BOB)
        XCTAssertEqual((mockPresenter?.fakeAmount ?? 0) == 220.0, true,"Balance Not matching for Bob")
        sut?.topUpAmount(with: "", username: BOB)
        XCTAssertEqual( mockPresenter?.fakeErrorString == AlertConstants.topUpEmptyMessage, true,"Error message not matching, when topup amount is empty")
    }

    /*
     * Test Get amount value method
     */
    func testGetAmountValue() {
        sut?.getAmountValue(name: BOB)
        XCTAssertEqual((mockPresenter?.fakeAmount ?? 0) == 100.0, true,"Balance Not matching for Bob")
        sut?.getAmountValue(name: ALICE)
        XCTAssertEqual((mockPresenter?.fakeAmount ?? 0) == 20.0, true,"Balance Not matching for Alice")
//        XCTAssertEqual((getHistoryDetails(name: BOB).count) > 0, true,"Transaction saved in history")
    }
    
    func getHistoryDetails(name: String) -> [History] {
        let temp =  CoreDataHandler.sharedInstance.getAllDatasWithPredicate(entity: "History", predicate: NSPredicate(format: "name ==  %@ || payee == %@", name, name), sortDescriptor: NSSortDescriptor(key: "date", ascending: true)) as? [History] ?? []
        return temp
    }
    
    /*
     * Test insert Pay Amount
     */
    
    func testInsertPayAmount() {
        sut?.insertPayAmount(from: BOB, to: ALICE, amount: "30")
        sut?.getAmountValue(name: ALICE)
        XCTAssertEqual((mockPresenter?.fakeAmount ?? 0) == 50.0, true,"Balance Not matching for Alice")
        sut?.getAmountValue(name: BOB)
        XCTAssertEqual((mockPresenter?.fakeAmount ?? 0) == 70.0, true,"Balance Not matching for Bob")
    }
}


//MARK:- Mock up Home interactor to presenter protocol
class FakeHomeInteractionToPresenter: HomeInteractorToPresenterProtocol {
    var fakeErrorString:String?
    var fakeAmount:Double?

    func balanceAmountCompletedWithSuccess(data: Double) {
        fakeAmount = data
    }
    
    func topUPCompletedWithError(errorString: String) {
        fakeErrorString = errorString
    }
    
}
