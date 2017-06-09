import UIKit
import RxSwift
import RxCocoa

var mapping: [String: (UIViewController) -> Void] = [:]

public func track<T: UIViewController>(_ type: T.Type, block: @escaping (T) -> Void) {
  let original = #selector(UIViewController.viewDidAppear(_:))
  let swizled = #selector(UIViewController.trackers_viewDidAppear(_:))
  swizzle(kClass: type, originalSelector: original, swizzledSelector: swizled)

  mapping[String(describing: type)] = { controller in
    if let controller = controller as? T {
      block(controller)
    }
  }
}

extension UIViewController {
  func trackers_viewDidAppear(_ animated: Bool) {
    trackers_viewDidAppear(animated)

    let string = String(describing: type(of: self))
    mapping[string]?(self)
  }
}

func swizzle(kClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
  let originalMethod = class_getInstanceMethod(kClass, originalSelector)
  let swizzledMethod = class_getInstanceMethod(kClass, swizzledSelector)

  let didAddMethod = class_addMethod(kClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))

  if didAddMethod {
    class_replaceMethod(kClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
  } else {
    method_exchangeImplementations(originalMethod, swizzledMethod)
  }
}
