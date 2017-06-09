import UIKit
import RxSwift
import RxCocoa

public func track<T: UIViewController>(type: T.Type, block: (T) -> Void) {
  let original = #selector(UIViewController.viewDidAppear(_:))
  let swizled = #selector(UIViewController.trackers_viewDidAppear(_:))
  swizzle(type: type, originalSelector: original, swizzledSelector: swizled)
}

extension UIViewController {
  func trackers_viewDidAppear(_ animated: Bool) {
    trackers_viewDidAppear(animated)
  }
}

func swizzle<T: UIViewController>(type: T.Type, originalSelector: Selector, swizzledSelector: Selector) {
  let originalMethod = class_getInstanceMethod(type, originalSelector)
  let swizzledMethod = class_getInstanceMethod(type, swizzledSelector)

  let didAddMethod = class_addMethod(type, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))

  if didAddMethod {
    class_replaceMethod(type, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
  } else {
    method_exchangeImplementations(originalMethod, swizzledMethod)
  }
}
