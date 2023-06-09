//
//  SecondaryViewController.swift
//  Demo App 1
//
//  Created by BrainX Technologies on 03/05/2023.
//

import SVGKit
import UIKit

class PreferrenceViewController: UIViewController {

    @IBOutlet weak var crossButtonImageView: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var applyButtonView: UIView!
    @IBOutlet weak var clearButtonView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    let langArray: [String] = ["Python", "Interior Painting", "Electrician", "Inappropriate client behavior", "Gardener", "Carpenter", "House cleaning"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        let preferrenceTableViewCellNib = UINib(nibName: PreferrenceTableViewCell.nibName, bundle: nil)
        tableView.register(preferrenceTableViewCellNib, forCellReuseIdentifier: PreferrenceTableViewCell.reusableCellIdentifier)
        tableView.rowHeight = 55
        
        clearButtonView.layer.cornerRadius = 10
        applyButtonView.layer.cornerRadius = 10
        
        clearButtonView.layer.borderWidth = 1
        clearButtonView.layer.borderColor = CGColor(red: 246/255, green: 178/255, blue: 51/255, alpha: 1.0)
        
        let crossSVG = SVGKImage(named: "cross")
        crossButtonImageView.image = crossSVG?.uiImage
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCrossButtonTap(_:)))
        crossButtonImageView.isUserInteractionEnabled = true
        crossButtonImageView.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let bottomBorder = CALayer()
        bottomBorder.backgroundColor = CGColor(red: 199/255, green: 199/255, blue: 202/255, alpha: 1.0)
        bottomBorder.frame = CGRect(x: 0, y: headView.frame.size.height - 1, width: headView.frame.size.width, height: 1)
        headView.layer.addSublayer(bottomBorder)
    }

    @objc func handleCrossButtonTap(_ gesture: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func apply(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clear(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension PreferrenceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return langArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PreferrenceTableViewCell.reusableCellIdentifier, for: indexPath) as! PreferrenceTableViewCell
        cell.languageLabel.text = langArray[indexPath.row]
        
        let uncheckedIcon = SVGKImage(named: "cce")
        cell.checkBoxImage.image = uncheckedIcon?.uiImage
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? PreferrenceTableViewCell {
            if cell.isChecked {
                let uncheckedIcon = SVGKImage(named: "cce")
                cell.checkBoxImage.image = uncheckedIcon?.uiImage
            } else {
                let checkedIcon = SVGKImage(named: "ccm")
                cell.checkBoxImage.image = checkedIcon?.uiImage
            }
            cell.isChecked = !cell.isChecked
        }
    }
}
