//
//  HPAPage.swift
//  Helpora
//
//  Created by Alan Chu on 3/14/18.
//  Copyright © 2018 Aeta. All rights reserved.
//

import Foundation
import Down

public typealias Markdown = String

public struct HPAPage: Codable {
    public var name: String
    public var keywords: [String]?
    public var contents: Markdown

    public init(name: String, keywords: [String]? = nil) {
        self.name = name
        self.keywords = keywords
        self.contents = ""
    }
    
    public func attributedString(with style: HPAStyles? = nil) -> NSAttributedString? {
        let css: CascadingStylesheet
        if let style = style {
            switch style {
            case .cascadingStylesheet(let cascadingStylesheet):
                css = cascadingStylesheet
            case .style(let hpaStyle):
                css = hpaStyle.stylesheet
            }
        } else {
            css = HPAStyle.defaultStyle.stylesheet
        }

        return try? Down(markdownString: contents).toAttributedString(.default, stylesheet: css)
    }
}
