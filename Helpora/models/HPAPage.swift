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
    
    public var attributedString: NSAttributedString? {
        return try? Down(markdownString: contents).toAttributedString()
    }
    
    public init(name: String, keywords: [String]? = nil) {
        self.name = name
        self.keywords = keywords
        self.contents = ""
    }
}
