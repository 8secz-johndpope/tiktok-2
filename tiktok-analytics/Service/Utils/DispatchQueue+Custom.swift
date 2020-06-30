import Foundation

public typealias Completion = () -> Void

public func onMain(_ closure: @escaping Completion) {
    if Thread.isMainThread {
        closure()
    } else {
        DispatchQueue.main.async(execute: closure)
    }
}
