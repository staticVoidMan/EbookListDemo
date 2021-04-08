//
//  UIFontExtension.swift
//  EbookListDemo
//
//  Created by Amin Siddiqui on 09/04/21.
//

import UIKit

extension UIFont {
    
    static func preferredFont(forTextStyle style: TextStyle, weight: Weight) -> UIFont {
        let metrics = UIFontMetrics(forTextStyle: style)
        let desc = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        let font = UIFont.systemFont(ofSize: desc.pointSize, weight: weight)
        return metrics.scaledFont(for: font)
    }
    
}
