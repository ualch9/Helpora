//
//  HPAIndex.swift
//  Helpora
//
//  Created by Alan Chu on 3/9/18.
//  Copyright © 2018 Aeta. All rights reserved.
//

import Foundation

public struct HPAIndex: Codable {
    /// The index of `sections`.
    public typealias SectionIndex = Int
    
    // MARK: - Identify
    /// A non-localized unique (preferably reverse-domain) string to identify this Index.
    public let identifier: String
    
    /// A localized name to describe this Index.
    public var name: String
    
    /// The Locale for this Index.
    public var locale: Locale {
        didSet {
            for index in sections.indices {
                sections[index].locale = locale
            }
        }
    }
    
    /// User-facing localized title.
    public var title: String
    
    // MARK: - Meta
    public var version: String
    public var author: String?
    public var copyright: String?
    
    // MARK: - Pages
    /// This optional page appears above the index tableview.
    /// As an introduction page, its contents are centered.
    public var introductionPage: HPAPage?
    
    public var style: HPAStyles?
    
    public var sections: [HPASection]
    
    // MARK: - Methods
    public enum CodingKeys: String, CodingKey {
        case identifier
        case name
        case locale
        case title
        case version
        case author
        case introductionPage = "introduction_page"
        case style
        case sections
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.identifier = try values.decode(String.self, forKey: .identifier)
        
        let _name = try values.decode(String.self, forKey: .name)
        self.name = _name
        
        let _locale = try? values.decode(String.self, forKey: .locale)
        self.locale = Locale(identifier: _locale ?? "en_US")
        
        self.title = (try? values.decode(String.self, forKey: .title)) ?? _name
        self.version = (try? values.decode(String.self, forKey: .version)) ?? "1.0"
        self.author = try? values.decode(String.self, forKey: .author)
        
        self.introductionPage = try? values.decode(HPAPage.self, forKey: .introductionPage)
        
        self.style = try? values.decode(HPAStyles.self, forKey: .style)
        
        let _sections = try? values.decode([HPASection].self, forKey: .sections)
        self.sections = _sections ?? []
    }
    
    /// - parameter title: defaults to `name`.
    /// - parameter version: defaults to `"1.0"`.
    /// - parameter author: defaults to `nil`.
    public init(identifier: String, name: String, locale: Locale, title: String? = nil, version: String = "1.0", author: String? = nil) {
        self.identifier = identifier
        self.name = name
        self.locale = locale
        self.title = title ?? name
        self.version = version
        self.author = author
        self.sections = []
    }
    
    /// - parameter identifier: Identifier will add the Index's to the prefix of the provided `identifier` parameter.
    /// For example, if the index's identifier is `"com.helpora"`, and you provide `"section_one"` as the section's
    /// identifier, that section's identifier will be `"com.helpora.section_one"` when using this method to add a
    /// section.
    public mutating func addSection(identifier: String, name: String, description: String? = nil) -> SectionIndex {
        let concatIdentifier = self.identifier + "." + identifier
        sections.append(HPASection(identifier: concatIdentifier, name: name, description: description, locale: self.locale))
        
        return sections.count - 1
    }
}
