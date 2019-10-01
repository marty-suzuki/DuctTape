@dynamicMemberLookup
public struct Builder<Base: AnyObject> {

    private let _build: () -> Base

    public init(_ build: @escaping () -> Base) {
        self._build = build
    }

    public subscript<Value>(dynamicMember keyPath: ReferenceWritableKeyPath<Base, Value>) -> (Value) -> Builder<Base> {
        { [build = _build] value in
            Builder {
                let object = build()
                object[keyPath: keyPath] = value
                return object
            }
        }
    }

    public func build() -> Base {
        _build()
    }
}

extension Builder {

    public func reinforce(_ handler: @escaping (Base) -> Void) -> Builder<Base> {
        Builder { [build = _build] in
            let object = build()
            handler(object)
            return object
        }
    }

    public func reinforce<T: AnyObject>(_ t: T, handler: @escaping (Base, T) -> Void) -> Builder<Base> {
        Builder { [build = _build, weak t] in
            let object = build()
            if let t = t {
                handler(object, t)
            }
            return object
        }
    }

    public func reinforce<T1: AnyObject, T2: AnyObject>(_ t1: T1, t2: T2, handler: @escaping (Base, T1, T2) -> Void) -> Builder<Base> {
        Builder { [build = _build, weak t1, weak t2] in
            let object = build()
            if let t1 = t1, let t2 = t2 {
                handler(object, t1, t2)
            }
            return object
        }
    }

    public func reinforce<T1: AnyObject, T2: AnyObject, T3: AnyObject>(_ t1: T1, t2: T2, t3: T3, handler: @escaping (Base, T1, T2, T3) -> Void) -> Builder<Base> {
        Builder { [build = _build, weak t1, weak t2, weak t3] in
            let object = build()
            if let t1 = t1, let t2 = t2, let t3 = t3 {
                handler(object, t1, t2, t3)
            }
            return object
        }
    }

    public func reinforce<T1: AnyObject, T2: AnyObject, T3: AnyObject, T4: AnyObject>(_ t1: T1, t2: T2, t3: T3, t4: T4, handler: @escaping (Base, T1, T2, T3, T4) -> Void) -> Builder<Base> {
        Builder { [build = _build, weak t1, weak t2, weak t3, weak t4] in
            let object = build()
            if let t1 = t1, let t2 = t2, let t3 = t3, let t4 = t4 {
                handler(object, t1, t2, t3, t4)
            }
            return object
        }
    }

    public func reinforce<T1: AnyObject, T2: AnyObject, T3: AnyObject, T4: AnyObject, T5: AnyObject>(_ t1: T1, t2: T2, t3: T3, t4: T4, t5: T5, handler: @escaping (Base, T1, T2, T3, T4, T5) -> Void) -> Builder<Base> {
        Builder { [build = _build, weak t1, weak t2, weak t3, weak t4, weak t5] in
            let object = build()
            if let t1 = t1, let t2 = t2, let t3 = t3, let t4 = t4, let t5 = t5 {
                handler(object, t1, t2, t3, t4, t5)
            }
            return object
        }
    }
}

public protocol DuctTapeCompatible {
    associatedtype DuctTapeBase: AnyObject
    var ductTape: Builder<DuctTapeBase> { get set }
}

extension DuctTapeCompatible where Self: AnyObject {
    public var ductTape: Builder<Self> {
        get { Builder { self } }
        set {}
    }
}


#if canImport(Foundation)
import Foundation

extension NSObject: DuctTapeCompatible {}
#endif
