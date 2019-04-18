//
//  HPAHelporaTableViewController.swift
//  Helpora
//
//  Created by Alan Chu on 3/17/18.
//  Copyright © 2018 Aeta. All rights reserved.
//

import UIKit
import Down

/// # TODO:
/// - Navigate with deep link.
/// - Provide fallback back to host app via uri scheme ("register" function)

public class HPAHelporaTableViewController: UITableViewController {
    public fileprivate(set) var helporaIndex: HPAIndex
    public fileprivate(set) var lastUpdated: Date?
    
    public init(withIndex index: HPAIndex) {
        self.helporaIndex = index
        super.init(style: .plain)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = helporaIndex.name
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        if let introPage = self.helporaIndex.introductionPage,
            let contents = introPage.attributedString(with: self.helporaIndex.style) {
//            let view = try! DownView(frame: .zero, markdownString: introPage.contents)
//            self.tableView.tableHeaderView = view
//            view.sizeToFit()
            let text = UITextView(frame: .zero)
            text.attributedText = contents
            text.isUserInteractionEnabled = false
            text.isScrollEnabled = false
            text.adjustsFontForContentSizeCategory = true
            text.textAlignment = .center
            
            self.tableView.tableHeaderView = text
            text.textContainerInset = self.tableView.contentInset
            text.contentInset = self.tableView.contentInset
            text.sizeToFit()
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return helporaIndex.sections.count
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return helporaIndex.sections[section].pages.count
    }
    
    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return helporaIndex.sections[section].name
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = helporaIndex.sections[indexPath.section].pages[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let page = helporaIndex.sections[indexPath.section].pages[indexPath.row]
        let style = helporaIndex.style
        self.navigationController?.pushViewController(HPAHelporaPageView(page, withStyle: style), animated: true)
    }
}
