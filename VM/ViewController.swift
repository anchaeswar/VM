//
//  ViewController.swift
//  VM


import UIKit

class ViewController: UIViewController{
    
    @IBOutlet var EmployeeDetailsButton: UIButton!
    @IBOutlet var RoomsListButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EmployeeDetailsButton.layer.borderWidth = 1
        EmployeeDetailsButton.layer.cornerRadius = 5
        EmployeeDetailsButton.layer.borderColor = UIColor.white.cgColor
        
        RoomsListButton.layer.borderWidth = 1
        RoomsListButton.layer.cornerRadius = 5
        RoomsListButton.layer.borderColor = UIColor.white.cgColor

    }
    
    
    @IBAction func btnEmployeeDetails(_ sender: Any) {
        let empvc = self.storyboard?.instantiateViewController(withIdentifier: "employeedetails") as! EmployeeViewController
        
        empvc.modalPresentationStyle = .fullScreen
        self.present(empvc, animated: true, completion: nil)
    }
    @IBAction func btnRoomStaus(_ sender: Any) {
        let rsvc = self.storyboard?.instantiateViewController(withIdentifier: "roomstatus") as! RoomStatusViewController

        rsvc.modalPresentationStyle = .fullScreen
        self.present(rsvc, animated: true, completion: nil)
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
