//
//  EmployeeViewController.swift
//  VM
//

import UIKit
import Kingfisher
import MBProgressHUD


class EmployeeViewController: UIViewController {
    
    var peps:[People] = []
    var backgroundView = UIView()
    
    @IBOutlet var detailsView: UIView!
    @IBOutlet var detailsScroll: UIScrollView!
    @IBOutlet var avtarImageView: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var jobtitleLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var joinedDateLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPeopleData()
            
        detailsView.frame=CGRect(x: 20, y: (view.frame.size.height-380)/2, width: (view.frame.size.width-40), height: 400)
        
        detailsScroll.frame=CGRect(x: 0, y: 44, width: detailsView.frame.size.width, height: 320)

        view.addSubview(tableView)

    }
    
    func getPeopleData () {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        
        guard let url = URL(string: API_S.BaseURL + "people") else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                self.peps = try JSONDecoder().decode([People].self, from: data)
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.tableView.reloadData()
                }
            }
            catch{
                MBProgressHUD.hide(for: self.view, animated: true)
                print("Unexpected error: \(error).")
            }
        }.resume()
    }
        
    func moreOptionsClicked(){

        backgroundView = UIView(frame:CGRect(x:0,y:0,width:self.view.frame.size.width,height:self.view.frame.size.height))
        backgroundView.backgroundColor = UIColorFromHex(rgbValue:0x696969, alpha: 0.5)
        self.view.addSubview(backgroundView)
        backgroundView.addSubview(detailsView)

   }

    @IBAction func closeDetailsPopUp (_ sender: Any) {
        backgroundView .removeFromSuperview()
        detailsView.removeFromSuperview()
    }
    @IBAction func backHomeButton (_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)

    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}

extension EmployeeViewController : UITableViewDelegate,UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return peps.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let title = self.peps[indexPath.row].firstName + " " + self.peps[indexPath.row].lastName
        
        cell.textLabel?.text = title
        
        return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let title = self.peps[indexPath.row].firstName + " " + self.peps[indexPath.row].lastName

        let dateString = peps[indexPath.row].createdAt
        let splitDate = dateString.components(separatedBy: "T")
        let profileImage = peps[indexPath.row].avatar

        nameLabel.text = title
        idLabel.text = peps[indexPath.row].id
        jobtitleLabel.text = peps[indexPath.row].jobtitle
        emailLabel.text = peps[indexPath.row].email
        joinedDateLabel.text = (splitDate[0])
        avtarImageView.kf.setImage(with: URL(string: profileImage ))

        moreOptionsClicked()
    }

}
