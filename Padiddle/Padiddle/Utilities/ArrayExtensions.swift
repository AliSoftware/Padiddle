//
//  ArrayExtensions.swift
//  Padiddle
//
//  Created by Zev Eisenberg on 9/18/15.
//  Copyright © 2015 Zev Eisenberg. All rights reserved.
//

extension Array where Element : Equatable {
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        if let index = indexOf(object) {
            removeAtIndex(index)
        }
    }
}

extension Array {
    func zip(almostSameLengthArray otherArray: [Element]) -> [Element] {
        let selfCount = count
        let otherCount = otherArray.count
        let selfIsBigger = selfCount > otherCount
        let largerArray = selfIsBigger ? self : otherArray
        let smallerArray = selfIsBigger ? otherArray : self

        assert(largerArray.count == smallerArray.count + 1, "Arrays must differ in count by exactly 1, but they have counts \(largerArray.count) and \(smallerArray.count)")

        var newArray = [Element]()
        for (index, smallArrayElement) in smallerArray.enumerate() {
            let largeArrayElement = largerArray[index]
            newArray.append(largeArrayElement)
            newArray.append(smallArrayElement)
        }

        guard let largeLast = largerArray.last else { fatalError() }
        newArray.append(largeLast)

        return newArray
    }

    var doublets: [(Element, Element)]? {
        guard count >= 2 else { return nil }

        var output: [(Element, Element)] = []
        for i in 1..<count {
            output.append((self[i - 1], self[i]))
        }

        return output
    }
}
