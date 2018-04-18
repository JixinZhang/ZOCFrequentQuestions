//
//  ViewController.swift
//  PassingDataForwarSwift
//
//  Created by AlexZhang on 2018/4/12.
//  Copyright © 2018 Jixin. All rights reserved.
//

import UIKit

let cellIdentifier = "cellIdentifier"
let segueCellIdentifier = "segueCellIdentifier"


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var dataArray = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Passing Data";
        configTableView()
        configDataSource()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    func configDataSource() {
        dataArray = [["Passing Data Forward","Passing Data Back","Passing Data UserDefaults","Passing Data Singleton","Passing Data Notification"],["Passing Data Forward using Segues"]]
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data:[String] = dataArray[section]
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 20));
        headerView.backgroundColor = UIColor.lightGray
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell
        if (indexPath.section == 0) {
            cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: segueCellIdentifier, for: indexPath)
        }
        var data:[String] = self.dataArray[indexPath.section]
        let title = data[indexPath.row]
        cell.textLabel?.text = title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            return
        }
        
        let data:[String] = self.dataArray[indexPath.section]
        let title = data[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewControllerA = storyboard.instantiateViewController(withIdentifier: "ViewControllerA") as! ViewControllerA
        viewControllerA.titleString = title
        viewControllerA.type = title
        
        self.navigationController?.pushViewController(viewControllerA, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ((segue.identifier?.compare("showDetail" as String)) != nil) {
            let viewControllerB = segue.destination as! ViewControllerB
            viewControllerB.textFieldContent = "This view controller was pushed by segue"
            viewControllerB.hideTextField = true
            viewControllerB.hideBackButton = true
        }
    }
}

