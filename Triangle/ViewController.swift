
import UIKit

// Global variables
var dueDate: Date? = nil
var weeksOfWork = ""
var isItPossible = ""
var timeOptions = ""
var scopeOptions = ""
var teamOptions = ""


class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var pointTextField: UITextField!
    @IBOutlet weak var dueTextField: UITextField!
    @IBOutlet weak var teamTextField: UITextField!
    @IBOutlet weak var platformTextField: UITextField!
    @IBOutlet weak var pointValueTextField: UITextField!
    
    @IBOutlet weak var showWeeks: UILabel!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var enoughRunway: UILabel!
    @IBOutlet weak var scopeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    // need to store the date in var and use it for the calcs
    let today = Date()
    
    func daysBetweenDates(startDate: Date, endDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.day], from: startDate, to: endDate)
        return components.day!
    }
    
    
    // MARK: Due date field date picker
    
    @IBAction func textFieldEditing(_ sender: UITextField) {
       let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(ViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dueTextField.text = dateFormatter.string(from: sender.date)
        dueDate = sender.date
    }
    
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
    
        // Text field delegates for enabling the calculate button
        pointTextField.delegate = self
        teamTextField.delegate = self
        pointValueTextField.delegate = self
        platformTextField.delegate = self
    }
    
    
    // MARK: Enable button ... this works but can't figure out how to get the unwrapped values. There has to be a better way to do this
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let pointsPresent = pointTextField.text else {
            return
        }
        guard let developersPresent = teamTextField.text else {
            return
        }
        
        guard let valuePresent = pointValueTextField.text else {
            return
        }
        
        guard let platformPresent = platformTextField.text else {
            return
        }
        
        
        let isFormValid: Bool
        
        if pointsPresent.isEmpty || developersPresent.isEmpty || valuePresent.isEmpty || platformPresent.isEmpty {
            isFormValid = false
        } else {
            isFormValid = true
        }
        
        calculateButton.isEnabled = isFormValid
    }
    


    @IBAction func calculateButton(_ sender: Any) {
        // Figure out how many weeks of works exist based on points, team size and number of platforms
        
      
       guard let pointsString = pointTextField.text, let points = Double(pointsString) else {
            return
        }
        guard let developersString = teamTextField.text, let developers = Double(developersString) else {
            return
        }
        guard let platformsString = platformTextField.text, let platforms = Double(platformsString) else {
            return
        }
        
        guard let pointValueString = pointValueTextField.text, let pointValue = Double(pointValueString) else {
            return
        }
 
        
        let devDays = points/pointValue
        let devPerPlatform = developers/platforms
        let weeksToFinish = devDays/devPerPlatform/5
        
            
        showWeeks.text = "That's \(weeksToFinish) week(s) of work for your team"
        weeksOfWork = "That's \(weeksToFinish) week(s) of work for your team"

        
        // calculation based on due date. Currently unwrapping with ! again.
        if dueDate != nil {
        let NumOfDays: Int = daysBetweenDates(startDate: Date(), endDate: dueDate!)
        print("Num of Days until due date: \(NumOfDays)")
            
            
        // calculate time until due date
        let daysUntilDue = Double(NumOfDays)
        let weeksUntilDue = Double(NumOfDays)/5
            print("Num of weeks until due date:\(weeksUntilDue)")
            print("Num of days until due date: \(daysUntilDue)")
        
        // how many weeks of work total
        let weekDelta = abs(weeksToFinish - weeksUntilDue)
        print("That's a \(weekDelta) week delta of work based on your current team size")
            
        
        // team size based on due date
            let canTeamFinish: Bool
            if weeksUntilDue < weeksToFinish {
                canTeamFinish = false
                isItPossible = "You're not going to make the deadline!"
            } else {
                canTeamFinish = true
                isItPossible = "You should be able to make the date!"
            }
    
            enoughRunway.text = isItPossible
            
            // Calculate scenarios
            let dayDelta = weekDelta * 5
            let pointOverage = dayDelta * pointValue


            
            if canTeamFinish == false {
                timeOptions = "You'll need to move your delivery date \(dayDelta) to complete all the scope"
                scopeOptions = "You'll need to cut \(pointOverage) points per platform to make your due date of \(dueTextField.text) for that amount of work"
                
                // print to debug:
                print("There are \(dayDelta) days more work than the team can complete")
                print("You'll need to cut \(pointOverage) points per platform to make your due date for that amount of work")

                
            } else {
                timeOptions = "You could release \(dayDelta) days earlier than your planned due date"
                scopeOptions = "You could add \(pointOverage) points per platform and still make your due date of \(dueTextField.text)"
                
                print("There are \(dayDelta) days more time than there is of scope")
                print("You could add \(pointOverage) points per platform and still make your due date")
            }
            scopeLabel.text = scopeOptions
            timeLabel.text = timeOptions
            
        }
    }

}
