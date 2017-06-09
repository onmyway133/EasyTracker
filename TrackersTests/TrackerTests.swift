import UIKit
import XCTest
import Trackers

class TrackerTests: XCTestCase {

  class ListController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
    }
  }

  class DetailController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
    }
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
    list.viewDidAppear(true)
    detail.viewDidAppear(true)

    XCTAssertEqual(strings, ["ListController", "DetailController"])
  }
}
