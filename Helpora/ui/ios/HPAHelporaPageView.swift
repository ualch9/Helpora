//
//  HPAHelporaPageView.swift
//  Helpora
//
//  Created by Alan Chu on 3/20/18.
//  Copyright © 2018 Aeta. All rights reserved.
//

import UIKit

public class HPAHelporaPageView: UIViewController {
    public private(set) var page: HPAPage {
        didSet {
            self.updateViews()
        }
    }
    
    public private(set) var style: HPAStyles {
        didSet {
            self.updateViews()
        }
    }
    
    public init(_ page: HPAPage, withStyle style: HPAStyles? = nil) {
        self.page = page
        self.style = style ?? .style(.defaultStyle)
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        self.updateViews()
        super.viewDidLoad()
    }
    
    public func updateViews() {
        self.title = self.page.name
        
        if let contents = self.page.attributedString(with: self.style) {
            let text = UITextView(frame: self.view.frame)
            text.attributedText = contents
            text.isEditable = false
            text.isScrollEnabled = true
            
            self.view = text
            self.view.backgroundColor = .white
            print(contents)
        } else {
            fatalError("Unable to get attributed string") // TODO: error gracefully
        }
    }
}
