//
//  ViewController.swift
//  ScrollViewChange-PoC
//
//  Created by Aditya Vikram Godawat on 1/4/18.
//  Copyright © 2018 Aditya Vikram Godawat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var heightConstraint: NSLayoutConstraint!
    
    let aView = Bundle.main.loadNibNamed("TestingView", owner: self, options: nil)?.first as! TestingView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        aView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aView)

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": aView]))
        
        // align aView from the bottom
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[view]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": aView]))
        
        // height constraint
        heightConstraint = NSLayoutConstraint(item: aView, attribute: NSLayoutAttribute.height, relatedBy: .equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 200)
        
        self.aView.addConstraint(heightConstraint)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}

extension ViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        if scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y <= 160 {
            heightConstraint.constant = 200 - scrollView.contentOffset.y
            aView.setNeedsUpdateConstraints()
        } else if scrollView.contentOffset.y > 16 {
            heightConstraint.constant = 40
            aView.setNeedsUpdateConstraints()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       
        UIView.animate(withDuration: 0.6) {
            self.aView.layoutIfNeeded()

        }
    }
}
