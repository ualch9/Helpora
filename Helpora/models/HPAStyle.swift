//
//  HPAStyle.swift
//  Helpora
//
//  Created by Alan Chu on 3/18/18.
//  Copyright © 2018 Aeta. All rights reserved.
//

import UIKit

public typealias CascadingStylesheet = String

public enum HPAStyles: Codable {
    case cascadingStylesheet(CascadingStylesheet)
    case style(HPAStyle)
    
    public var int: Int {
        switch self {
        case .cascadingStylesheet(_):
            return 0
        case .style(_):
            return 1
        }
    }
    
    public enum CodingKeys: String, CodingKey {
        case type
        case value
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(Int.self, forKey: .type)
        
        switch type {
        case 0:
            let value = try container.decode(CascadingStylesheet.self, forKey: .value)
            self = .cascadingStylesheet(value)
        case 1:
            let value = try container.decode(HPAStyle.self, forKey: .value)
            self = .style(value)
        default:
            let context = DecodingError.Context(codingPath: [CodingKeys.type],
                                                debugDescription: "An out-of-range HPAStyles integer was encountered. See HPAStyles.int for valid values.")
            throw DecodingError.typeMismatch(Int.self, context)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.int, forKey: .type)
        switch self {
        case .cascadingStylesheet(let css):
            try container.encode(css, forKey: .value)
        case .style(let style):
            try container.encode(style, forKey: .value)
        }
    }
}

public struct HPAStyle: Codable {
    public enum CSSSelector: String, Codable {
        case h1
        case h2
        case h3
        case h4
        case h5
        case h6
        case p
        
        case li
        
        case a
        
        case blockquote
        case code
    }
    
    // MARK: - Attributes
    /// The styles of this `HPAStyle`. Please note the `Stylesheet properties` when
    /// generating a CSS.
    public var styles: [CSSSelector: UIFont]
    
    // MARK: - Stylesheet properties
    /// if `true`,
    /// ```
    /// * {
    ///     font-family: -apple-system;
    /// }
    /// ```
    /// Sometimes, this will be overridden if you have a selector using a system
    /// font. Set `ignoreFontFamilyInCSS` to `true` to fix this problem. Do note,
    /// if you have any other custom font families, it won't be applied to the
    /// `stylesheet`.
    public var useAppleSystemFontUniversally: Bool = false
    
    /// Don't apply `font-family` attribute when accessing `stylesheet`.
    /// This is useful when you are using system fonts which generate names that
    /// are different from the actual CSS font family name.
    public var ignoreFontFamilyInCSS: Bool = false
    
    /// The generated Cascading Stylesheet from `styles`.
    ///
    /// It observes the following properties of `HPAStyle`:
    /// - `useAppleSystemFontUniversally`
    /// - `ignoreFontFamilyInCSS`
    public var stylesheet: CascadingStylesheet {
        var css = ""
        if useAppleSystemFontUniversally {
            css.append("*{font-family:-apple-system;}")
        }
        
        for style in styles {
            var familyName = style.value.familyName
            if familyName.first == "." {
                familyName = String(familyName.dropFirst())
            }
            
            if ignoreFontFamilyInCSS {
                css.append("\(style.key){font-size:\(style.value.pointSize);}")
            } else {
                css.append("""
                    \(style.key){
                        font-family: \(familyName);
                        font-size: \(style.value.pointSize);
                    }
                """)
            }
        }
        
        return css
    }
    
    // MARK: - Initializers
    public init(withStyles styles: [CSSSelector: UIFont], useAppleSystemFontUniversally: Bool = false) {
        self.styles = styles
        self.useAppleSystemFontUniversally = useAppleSystemFontUniversally
    }
    
    // MARK: Codable methods
    public enum CodingKeys: String, CodingKey {
        case styles
        case ignoreFontFamilyInCSS = "ignore_font_family_in_css"
        case useAppleSystemFontUniversally = "use_apple_system_font_universally"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let encodedStyles = try container.decode([CSSSelector: Data].self, forKey: .styles)
        
        let decodedStyles = try encodedStyles.mapValues { data -> UIFont in
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            guard let font = unarchiver.decodeObject() as? UIFont else {
                let context = DecodingError.Context(codingPath: [CodingKeys.styles],
                                                    debugDescription: "Error while attempting to unarchive UIFont from Data because Data is not a UIFont. \n Data Dump: \(data)")
                throw DecodingError.typeMismatch(UIFont.self, context)
            }
            
            return font
        }
        
        self.styles = decodedStyles
        self.ignoreFontFamilyInCSS = try container.decode(Bool.self, forKey: .ignoreFontFamilyInCSS)
        self.useAppleSystemFontUniversally = try container.decode(Bool.self, forKey: .useAppleSystemFontUniversally)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let encodedStyles = styles.mapValues { font -> Data in
            // UIFont is not Codable, so archive as a Data.
            let archiver = NSKeyedArchiver()
            archiver.encode(font)
            return archiver.encodedData
        }
        
        try container.encode(encodedStyles, forKey: .styles)
        try container.encode(ignoreFontFamilyInCSS, forKey: .ignoreFontFamilyInCSS)
        try container.encode(useAppleSystemFontUniversally, forKey: .useAppleSystemFontUniversally)
    }
}
