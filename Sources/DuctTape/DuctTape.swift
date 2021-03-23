@dynamicMemberLookup
public struct Builder<Base> {

    private let base: Base

    public init(_ base: Base) {
        self.base = base
    }

    public subscript<Value>(dynamicMember keyPath: WritableKeyPath<Base, Value>) -> (Value) -> Builder<Base> {
        { [base] value in
            var object = base
            object[keyPath: keyPath] = value
            return Builder(object)
        }
    }

    public subscript<Value>(dynamicMember keyPath: WritableKeyPath<Base, Value>) -> (Value) -> Base {
        { [base] value in
            var object = base
            object[keyPath: keyPath] = value
            return object
        }
    }

    @available(swift, deprecated: 5)
    public func build() -> Base {
        base
    }
}

extension Builder {

    public func reinforce(_ handler: (inout Base) -> Void) -> Builder<Base> {
        Builder(reinforce(handler))
    }

    public func reinforce(_ handler: (inout Base) -> Void) -> Base {
        var object = base
        handler(&object)
        return object
    }

    public func reinforce<T>(_ t: T, handler: (inout Base, T) -> Void) -> Builder<Base> {
        Builder(reinforce(t, handler: handler))
    }

    public func reinforce<T>(_ t: T, handler: (inout Base, T) -> Void) -> Base {
        var object = base
        handler(&object, t)
        return object
    }

    public func reinforce<T1, T2>(_ t1: T1, _ t2: T2, handler: (inout Base, T1, T2) -> Void) -> Builder<Base> {
        Builder(reinforce(t1, t2, handler: handler))
    }

    public func reinforce<T1, T2>(_ t1: T1, _ t2: T2, handler: (inout Base, T1, T2) -> Void) -> Base {
        var object = base
        handler(&object, t1, t2)
        return object
    }

    public func reinforce<T1, T2, T3>(_ t1: T1, _ t2: T2, _ t3: T3, handler: (inout Base, T1, T2, T3) -> Void) -> Builder<Base> {
        Builder(reinforce(t1, t2, t3, handler: handler))
    }

    public func reinforce<T1, T2, T3>(_ t1: T1, _ t2: T2, _ t3: T3, handler: (inout Base, T1, T2, T3) -> Void) -> Base {
        var object = base
        handler(&object, t1, t2, t3)
        return object
    }

    public func reinforce<T1, T2, T3, T4>(_ t1: T1, _ t2: T2, _ t3: T3, _ t4: T4, handler: (inout Base, T1, T2, T3, T4) -> Void) -> Builder<Base> {
        Builder(reinforce(t1, t2, t3, t4, handler: handler))
    }

    public func reinforce<T1, T2, T3, T4>(_ t1: T1, _ t2: T2, _ t3: T3, _ t4: T4, handler: (inout Base, T1, T2, T3, T4) -> Void) -> Base {
        var object = base
        handler(&object, t1, t2, t3, t4)
        return object
    }

    public func reinforce<T1, T2, T3, T4, T5>(_ t1: T1, _ t2: T2, _ t3: T3, _ t4: T4, _ t5: T5, handler: (inout Base, T1, T2, T3, T4, T5) -> Void) -> Builder<Base> {
        Builder(reinforce(t1, t2, t3, t4, t5, handler: handler))
    }

    public func reinforce<T1, T2, T3, T4, T5>(_ t1: T1, _ t2: T2, _ t3: T3, _ t4: T4, _ t5: T5, handler: (inout Base, T1, T2, T3, T4, T5) -> Void) -> Base {
        var object = base
        handler(&object, t1, t2, t3, t4, t5)
        return object
    }
}

public protocol DuctTapeCompatible {
    associatedtype DuctTapeBase
    var ductTape: Builder<DuctTapeBase> { get set }
}

extension DuctTapeCompatible {
    public var ductTape: Builder<Self> {
        get { Builder(self) }
        set {}
    }
}

#if canImport(Foundation)
import Foundation

extension NSObject: DuctTapeCompatible {}
#endif
