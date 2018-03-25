//
//  HPAHelporaView.swift
//  Helpora
//
//  Created by Alan Chu on 3/20/18.
//  Copyright © 2018 Aeta. All rights reserved.
//

import UIKit

public class HPAHelporaView: UINavigationController {
    public init(withIndex index: HPAIndex) {
        super.init(rootViewController: HPAHelporaTableViewController(withIndex: index))
    }
    
    // Keep this because of odd runtime error.
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissHelporaView))
    }
    
    @objc public func dismissHelporaView() {
        self.dismiss(animated: true, completion: nil)
    }
}
