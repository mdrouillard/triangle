
import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var pointTextField: UITextField!
    @IBOutlet weak var dueTextField: UITextField!
    @IBOutlet weak var teamTextField: UITextField!

  

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
        print(pointTextField, dueTextField, teamTextField)
        
    }
}

