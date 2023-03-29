import XCTest
@testable import ImageFeed

final class ProfileViewTests: XCTestCase {
    func testViewControllerCallsDidLoad() {
        //Given
        let sut = ProfileViewControllerSpy()
        let presenter = ProfilePresenterSpy()
        
        guard let view = sut.profileScreenView as? ProfileViewSpy else {
            XCTFail()
            return
        }
        
        //When
        view.presenter = presenter
        view.presenter?.view = view
        presenter.viewDidLoad()
        
        //Then
        XCTAssertTrue(presenter.viewDidLoadCalled)
    }
    
    func testProfileViewCallsUpdateProfile() {
        //Given
        let sut = ProfileViewControllerSpy()
        let helper = ProfileHelper()
        let presenter = ProfilePresenter(helper: helper)
        
        guard let view = sut.profileScreenView as? ProfileViewSpy else {
            XCTFail()
            return
        }
        
        //When
        view.presenter = presenter
        view.presenter?.view = view
        presenter.viewDidLoad()
        
        //Then
        XCTAssertTrue(view.updateProfileCalled)
    }
}
