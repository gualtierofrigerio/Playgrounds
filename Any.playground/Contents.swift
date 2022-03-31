import Foundation

/// protocol and classes

protocol StringManipulating {
    func manipulateString(_ string: String) -> String
}

class UppercaseManipulator: StringManipulating {
    func manipulateString(_ string: String) -> String {
        string.uppercased()
    }
}

class LowercaseManipulator: StringManipulating {
    func manipulateString(_ string: String) -> String {
        string.lowercased()
    }
}

/// functions to manipulate strings

func manipulate(string: String, using manipulator: any StringManipulating) -> String {
    manipulator.manipulateString(string)
}

func genericManipulate<S: StringManipulating>(string: String, using manipulator: S) -> String {
    manipulator.manipulateString(string)
}

/// measure performance

let iterations = 10000

func iterationExistential() -> CFTimeInterval {
    let string = "hi there"
    let upperManipulator = UppercaseManipulator()
    let lowerManipulator = LowercaseManipulator()
    var manipulator: StringManipulating
    
    let start = CFAbsoluteTimeGetCurrent()
    
    for _ in 0..<iterations {
        manipulator = upperManipulator
        let newString = manipulate(string: string,
                                   using: manipulator)
        manipulator = lowerManipulator
        let _ = manipulate(string: newString,
                           using: manipulator)
    }
    return CFAbsoluteTimeGetCurrent() - start
}

func iterationGeneric() -> CFTimeInterval {
    let string = "hi there"
    let upperManipulator = UppercaseManipulator()
    let lowerManipulator = LowercaseManipulator()
        
    let start = CFAbsoluteTimeGetCurrent()
    for _ in 0..<iterations {
        let newString = genericManipulate(string: string,
                                          using: upperManipulator)
        let _ = genericManipulate(string: newString,
                                             using: lowerManipulator)
    }
    return CFAbsoluteTimeGetCurrent() - start
}

for _ in 0..<3 {
    var interval = iterationExistential()
    print("iterationProtocol took \(interval)")
    interval = iterationGeneric()
    print("iterationGeneric took \(interval)")
}
