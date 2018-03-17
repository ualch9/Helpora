//
//  HPASection.swift
//  Helpora
//
//  Created by Alan Chu on 3/14/18.
//  Copyright © 2018 Aeta. All rights reserved.
//

import Foundation

public struct HPASection: Codable {
    public var identifier: String
    public var name: String
    public var description: String?
    public var locale: Locale
    public var pages: [HPAPage]
    
    public init(identifier: String, name: String, description: String? = nil, locale: Locale) {
        self.identifier = identifier
        self.name = name
        self.description = description
        self.locale = locale
        self.pages = []
    }
}
