import UIKit

var mapping: [String: (UIViewController) -> Void] = [:]
var hasSwizzled = false

public func track<T: UIViewController>(_ type: T.Type, block: @escaping (T) -> Void) {
  let original = #selector(UIViewController.viewDidAppear(_:))
  let swizled = #selector(UIViewController.trackers_viewDidAppear(_:))

  if !hasSwizzled {
    swizzle(kClass: UIViewController.self, originalSelector: original, swizzledSelector: swizled)
    hasSwizzled = true
  }

  mapping[NSStringFromClass(type)] = { controller in
    if let controller = controller as? T {
      block(controller)
    }
  }
}

extension UIViewController {
  func trackers_viewDidAppear(_ animated: Bool) {
    trackers_viewDidAppear(animated)

    let string = NSStringFromClass(type(of: self))
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
