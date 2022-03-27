//
//  RoomStatusViewController.swift
//  VM


import UIKit
import MBProgressHUD

class RoomStatusViewController: UIViewController {
    
    var rooms:[RoomStatus] = []
    var backgroundView = UIView()
    
    @IBOutlet var roomsListView: UIView!
    @IBOutlet var roomsTableView: UITableView!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var maxOccupancyLabel: UILabel!
    @IBOutlet var roomStatusLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRoomsData()
        roomsListView.frame=CGRect(x: 20, y: (view.frame.size.height-200)/2, width: (view.frame.size.width-40), height: 200)
        
        
        view.addSubview(roomsTableView)
    }
    
    
    func getRoomsData () {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)

        guard let url = URL(string: API_S.BaseURL + "rooms") else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            
            guard let data = data else { return }
            
            do {
                self.rooms = try JSONDecoder().decode([RoomStatus].self, from: data)
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.roomsTableView.reloadData()
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
        backgroundView.addSubview(roomsListView)
        
    }
    @IBAction func closeStatusPopUp (_ sender: Any) {
        backgroundView .removeFromSuperview()
        roomsListView.removeFromSuperview()
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
extension RoomStatusViewController : UITableViewDelegate,UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Room", for: indexPath)
        
        
        cell.textLabel?.text = "Room No :  " + self.rooms[indexPath.row].id
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let isOccupied = rooms[indexPath.row].isOccupied
        var statusString = ""
        if !(isOccupied){
            print(true)
            statusString = "Vacant"
        }
        else {
            statusString = "Occupied"
        }
        
        idLabel.text = ": " + rooms[indexPath.row].id
        roomStatusLabel.text = ": " + statusString
        maxOccupancyLabel.text = ": " + String(rooms[indexPath.row].maxOccupancy)
        
        moreOptionsClicked()
    }
    
}
