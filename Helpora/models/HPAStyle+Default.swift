//
//  HPAStyle+Default.swift
//  Helpora
//
//  Created by Alan Chu on 3/19/18.
//  Copyright © 2018 Aeta. All rights reserved.
//

import UIKit

extension HPAStyle {
    /// The default style does not follow its corresponding names because
    /// it does not match with the rest of the default interface.:
    /// ```
    /// h1 ≠ .title1
    /// h2 ≠ .title2
    /// etc...
    /// ```
    ///
    /// Instead, Helpora uses a more suitable text style as a default:
    /// ```
    /// h1  == .title3
    /// h2  == .headline
    /// h3  == .subheadline
    /// h4  == .callout
    /// p   == .body
    /// li  == .body
    /// ```
    /// If you wish to change the values, you can create a mutatable
    /// copy of `defaultStyle`.
    public static var defaultStyle: HPAStyle {
        let fonts: [CSSSelector: UIFont] = [
            .h1: .preferredFont(forTextStyle: .title3),
            .h2: .preferredFont(forTextStyle: .headline),
            .h3: .preferredFont(forTextStyle: .subheadline),
            .h4: .preferredFont(forTextStyle: .callout),
            .p: .preferredFont(forTextStyle: .body),
            .li: .preferredFont(forTextStyle: .body)
        ]
        
        var style = HPAStyle(withStyles: fonts, useAppleSystemFontUniversally: true)
        style.ignoreFontFamilyInCSS = true
        return style
    }
}
