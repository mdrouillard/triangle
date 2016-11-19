
import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var pointTextField: UITextField!
    @IBOutlet weak var dueTextField: UITextField!
    @IBOutlet weak var teamTextField: UITextField!
    @IBOutlet weak var platformTextField: UITextField!
    @IBOutlet weak var pointValueTextField: UITextField!
    
    @IBOutlet weak var showWeeks: UILabel!
    


    // MARK: Text Field Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

    
    // MARK: Touch events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pointTextField.delegate = self
        
    }
    
    
    
    @IBAction func calculateButton(_ sender: Any) {
        // Figure out how many weeks of works exist based on points, team size and number of platforms
        
        let points = Double(pointTextField.text!)
        let developers = Double(teamTextField.text!)
        let platforms = Double(platformTextField.text!)
        let pointValue = Double(pointValueTextField.text!)
        
        
        let devDays = points!/pointValue!
        let platformDays = devDays/platforms!
        let devPerPlatform = developers!/platforms!
        let weeksToFinish = platformDays/devPerPlatform/5
            
        showWeeks.text! = "That's \(weeksToFinish) week(s) of work for your team"
        
    }

}
