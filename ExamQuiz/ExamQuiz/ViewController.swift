//
//  ViewController.swift
//  ExamQuiz
//
//  Created by SD on 13/05/2026.
//

import UIKit

import SwiftyJSON

struct Question {
    let category: String
    let qaNumber: Int
    let question: String
    let answer: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var RedButton: UIButton!
    @IBOutlet weak var BlueButton: UIButton!
    @IBOutlet weak var OrangeButton: UIButton!
    @IBOutlet weak var YellowButton: UIButton!
    @IBOutlet weak var GreenButton: UIButton!
    
    @IBOutlet weak var HideAnswerButton: UIButton!
    @IBOutlet weak var NextQuestionButton: UIButton!
    
    @IBOutlet weak var HideCategoryButton: UIButton!
    @IBOutlet weak var ShowCategoryButton: UIButton!
    
    @IBOutlet weak var AnswerField: UILabel!
    @IBOutlet weak var AnswerLabel: UILabel!
    @IBOutlet weak var QuestionField: UILabel!
    
    var quizQuestions: Array<[String: Any]> = []
    var categoryQuestions: Array<[String: Any]> = []
    var currentCategory: String = ""
    var i: Int = 0
    var isAnswerHidden: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let jsonPath = Bundle.main.path(forResource: "localQuizData", ofType: "json") else { return }
        let url = URL(fileURLWithPath: jsonPath)
        do {
            let data = try Data(contentsOf: url)
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>] {
                quizQuestions = jsonArray
//                print(quizQuestions)
            } else {
                print("bad json")
            }
        } catch {
            print(error)
        }
        
        ShowCategoryButton.isHidden = true
    }

    @IBAction func DidTapYellowController(_ sender: UIButton) {
        categoryQuestions = quizQuestions.filter { $0["category"] as! String == "yellow" }
        currentCategory = "yellow"
//        showQuestion()
        self.resetButtons()
        self.setCategoryClasses()
    }
    
    @IBAction func DidTapRedController(_ sender: UIButton) {
        categoryQuestions = quizQuestions.filter { $0["category"] as! String == "red" }
        currentCategory = "red"
        //        showQuestion()
        self.resetButtons()
        self.setCategoryClasses()
    }
    
    @IBAction func DidTapBlueController(_ sender: UIButton) {
        categoryQuestions = quizQuestions.filter { $0["category"] as! String == "blue" }
        currentCategory = "blue"
        //        showQuestion()
        self.resetButtons()
        self.setCategoryClasses()
    }
    
    @IBAction func DidTapOrangeController(_ sender: UIButton) {
        categoryQuestions = quizQuestions.filter { $0["category"] as! String == "orange" }
        currentCategory = "orange"
        //        showQuestion()
        self.resetButtons()
        self.setCategoryClasses()
    }
    
    @IBAction func DidTapGreenController(_ sender: UIButton) {
        categoryQuestions = quizQuestions.filter { $0["category"] as! String == "green" }
        currentCategory = "green"
        //        showQuestion()
        self.resetButtons()
        self.setCategoryClasses()
    }
    
    @IBAction func DidTapNextQuestionController(_ sender: UIButton) {
        i += 1
    }
    
    @IBAction func DidTapHideAnswerController(_ sender: UIButton) {
        // If hidden when clicked
        if isAnswerHidden == true {
            isAnswerHidden = false
            AnswerField.isHidden = false
            HideAnswerButton.setTitle("Verberg Antwoord", for: .normal)
            
        } else { // If not hidden when clicked
            isAnswerHidden = true
            AnswerField.isHidden = true
            HideAnswerButton.setTitle("Toon Antwoord", for: .normal)
            
        }
    }
    
    @IBAction func DidTapHideCategoryController(_ sender: UIButton) {
        self.resetButtons()
        self.setCategoryClasses()
    }
    
    @IBAction func DidTapShowCategoryController(_ sender: UIButton) {
        RedButton.isHidden = false
        OrangeButton.isHidden = false
        YellowButton.isHidden = false
        GreenButton.isHidden = false
        BlueButton.isHidden = false
        
        ShowCategoryButton.isHidden = true
        HideCategoryButton.isHidden = false
    }
    
    func setCategoryClasses() {
        QuestionField.textColor = .black
        ShowCategoryButton.isHidden = false
        HideCategoryButton.isHidden = true
        
        HideAnswerButton.isHidden = false
        NextQuestionButton.isHidden = false
        
        switch currentCategory {
        case "yellow":
            YellowButton.isHidden = false
            QuestionField.backgroundColor = .yellow
        case "red":
            RedButton.isHidden = false
            QuestionField.backgroundColor = .red
        case "orange":
            OrangeButton.isHidden = false
            QuestionField.backgroundColor = .orange
        case "green":
            GreenButton.isHidden = false
            QuestionField.backgroundColor = .green
        case "blue":
            BlueButton.isHidden = false
            QuestionField.backgroundColor = .blue
            QuestionField.textColor = .white
        default:
            QuestionField.textColor = .white
        }
    }
    
    func resetButtons() {
        RedButton.isHidden = true
        OrangeButton.isHidden = true
        YellowButton.isHidden = true
        GreenButton.isHidden = true
        BlueButton.isHidden = true
        
        HideCategoryButton.isHidden = true
        ShowCategoryButton.isHidden = true
        
        HideAnswerButton.isHidden = true
        NextQuestionButton.isHidden = true
        
        QuestionField.backgroundColor = .black
        QuestionField.textColor = .white
    }
}

