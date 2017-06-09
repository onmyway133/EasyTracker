import UIKit
import XCTest
import Trackers

class TrackerTests: XCTestCase {

  class ListController: UIViewController {

  }

  class DetailController: UIViewController {

  }

  func testTrackers() {
    var strings = [String]()
    track(ListController.self) {
      strings.append(String(describing: type(of: $0)))
    }

    track(DetailController.self) {
      strings.append(String(describing: type(of: $0)))
    }

    let list = ListController()
    let detail = DetailController()
    let navigation = UINavigationController(rootViewController: list)
    navigation.pushViewController(detail, animated: false)

    XCTAssertEqual(strings, ["", ""])
  }
}
