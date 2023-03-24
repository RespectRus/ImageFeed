import XCTest

final class ImageFeedUITests: XCTestCase {
    private let app = XCUIApplication() // Переменная приложения

    override func setUpWithError() throws {
        continueAfterFailure = false //Настройка выполнения тестов, которая прекратит выполнение тестов, если в тесте что-то пошло не так

        app.launch() //Запускаем приложение перед каждым тестом
        
    }
    
    //MARK: - тестируем сценарии авторизации
    func testAuth() throws {
        app.buttons["Authenticate"].tap()
            
            let webView = app.webViews["UnsplashWebView"]
            
            XCTAssertTrue(webView.waitForExistence(timeout: 5))

            let loginTextField = webView.descendants(matching: .textField).element
            XCTAssertTrue(loginTextField.waitForExistence(timeout: 5))
            
            loginTextField.tap()
            loginTextField.typeText("<email>")
            webView.swipeUp()
            
            let passwordTextField = webView.descendants(matching: .secureTextField).element
            XCTAssertTrue(passwordTextField.waitForExistence(timeout: 5))
            
            passwordTextField.tap()
            passwordTextField.typeText("<password>")
            webView.swipeUp()
            
            webView.buttons["Login"].tap()
            
            let tablesQuery = app.tables
            let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
            
            XCTAssertTrue(cell.waitForExistence(timeout: 5))
        }
    
    //MARK: -  тестируем сценарии ленты
    func testFeed() throws {
        let tablesQuery = app.tables
        
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        cell.swipeUp()
        
        sleep(2)
        
        let cellToLike = tablesQuery.children(matching: .cell).element(boundBy: 1)
        
        cellToLike.buttons["no active like button"].tap()
        
        sleep(2)
        
        cellToLike.buttons["active like button"].tap()
        
        sleep(2)
        
        cellToLike.tap()
        
        sleep(2)
        
        let image = app.scrollViews.images.element(boundBy: 0)
        
        image.pinch(withScale: 3, velocity: 1)
        
        image.pinch(withScale: 0.5, velocity: -1)
        
        let navBackButtonWhiteButton = app.buttons["nav_back_white_button"]
        navBackButtonWhiteButton.tap()
    }
    
    //MARK: - тестируем сценарии профиля
    func testProfile() throws {
        sleep(3)
        app.tabBars.buttons.element(boundBy: 1).tap()
        
        XCTAssertTrue(app.staticTexts["FirstName_LastName"].exists)
        XCTAssertTrue(app.staticTexts["@userName"].exists)
        
        app.buttons["exit profile button"].tap()
        
        app.alerts["Пока, пока!"].scrollViews.otherElements.buttons["Да"].tap()
    }
}
