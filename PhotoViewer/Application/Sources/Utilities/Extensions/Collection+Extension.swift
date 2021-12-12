//
//  Collection+Extension.swift
//  PhotoViewer
//
//  Created by David Duarte on 11/12/2021.
//

import UIKit

extension Collection where Indices.Iterator.Element == Index {
   public subscript(safe index: Index) -> Iterator.Element? {
     return (startIndex <= index && index < endIndex) ? self[index] : nil
   }
}
