//
//  ViewController.swift
//  ExamQuiz
//
//  Created by SD on 13/05/2026.
//

import UIKit

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

    
    let jsonPath = Bundle.main.path(forResource: "localQuizData", ofType: "json")

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func DidTapYellowController(_ sender: UIButton) {
//        categoryQuestions = quizQuestions.filter({ $0.category == .yellow })
//        showQuestion()
        RedButton.isHidden = true
        OrangeButton.isHidden = true
        YellowButton.isHidden = false
        GreenButton.isHidden = true
        BlueButton.isHidden = true
        HideCategoryButton.isHidden = true
        ShowCategoryButton.isHidden = false
//        BackgroundLabel.backgroundColor = .yellow
//        QuestionLabel.textColor = .black
    }
    
    @IBAction func DidTapRedController(_ sender: UIButton) {
        //        categoryQuestions = quizQuestions.filter({ $0.category == .yellow })
        //        showQuestion()
                RedButton.isHidden = false
                OrangeButton.isHidden = true
                YellowButton.isHidden = true
                GreenButton.isHidden = true
                BlueButton.isHidden = true
                HideCategoryButton.isHidden = true
                ShowCategoryButton.isHidden = false
        //        BackgroundLabel.backgroundColor = .yellow
        //        QuestionLabel.textColor = .black
    }
    
    @IBAction func DidTapBlueController(_ sender: UIButton) {
        //        categoryQuestions = quizQuestions.filter({ $0.category == .yellow })
        //        showQuestion()
                RedButton.isHidden = true
                OrangeButton.isHidden = true
                YellowButton.isHidden = true
                GreenButton.isHidden = true
                BlueButton.isHidden = false
                HideCategoryButton.isHidden = true
                ShowCategoryButton.isHidden = false
        //        BackgroundLabel.backgroundColor = .yellow
        //        QuestionLabel.textColor = .black
    }
    
    @IBAction func DidTapOrangeController(_ sender: UIButton) {
        //        categoryQuestions = quizQuestions.filter({ $0.category == .yellow })
        //        showQuestion()
                RedButton.isHidden = true
                OrangeButton.isHidden = false
                YellowButton.isHidden = true
                GreenButton.isHidden = true
                BlueButton.isHidden = true
                HideCategoryButton.isHidden = true
                ShowCategoryButton.isHidden = false
        //        BackgroundLabel.backgroundColor = .yellow
        //        QuestionLabel.textColor = .black
    }
    
    @IBAction func DidTapGreenController(_ sender: UIButton) {
        //        categoryQuestions = quizQuestions.filter({ $0.category == .yellow })
        //        showQuestion()
                RedButton.isHidden = true
                OrangeButton.isHidden = true
                YellowButton.isHidden = true
                GreenButton.isHidden = false
                BlueButton.isHidden = true
                HideCategoryButton.isHidden = true
                ShowCategoryButton.isHidden = false
        //        BackgroundLabel.backgroundColor = .yellow
        //        QuestionLabel.textColor = .black
    }
    
    @IBAction func DidTapNextQuestionController(_ sender: UIButton) {
    }
    
    @IBAction func DidTapHideAnswerController(_ sender: UIButton) {
    }
    
    @IBAction func DidTapHideCategoryController(_ sender: UIButton) {
    }
    
    @IBAction func DidTapShowCategoryController(_ sender: UIButton) {
    }
}

