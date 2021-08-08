//
//  ViewController.swift
//  P2(Code)
//
//  Created by Erni Iun on 2021/08/07.
//

import UIKit

class ViewController: UIViewController {

    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var totalQ = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        countries += ["us", "uk", "france"]
        
        configureBtns()
        askQ(action: nil)
    }

    func configureBtns() {
        countries.shuffle()
        
        let btn1 = UIButton(frame: CGRect(x: 107, y: 111, width: 200, height: 100))
        btn1.layer.borderWidth = 1
        btn1.layer.borderColor = UIColor.lightGray.cgColor
        btn1.setImage(UIImage(named: countries[0]), for: .normal)
        btn1.tag = 0
        btn1.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        
        let btn2 = UIButton(frame: CGRect(x: 107, y: 252, width: 200, height: 100))
        btn2.layer.borderWidth = 1
        btn2.layer.borderColor = UIColor.lightGray.cgColor
        btn2.setImage(UIImage(named: countries[1]), for: .normal)
        btn2.tag = 1
        btn2.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        
        let btn3 = UIButton(frame: CGRect(x: 107, y: 393, width: 200, height: 100))
        btn3.layer.borderWidth = 1
        btn3.layer.borderColor = UIColor(red: 0.1, green: 1.0, blue: 0.1, alpha: 1.0).cgColor
        btn3.setImage(UIImage(named: countries[2]), for: .normal)
        btn3.tag = 2
        btn3.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)

        view.addSubview(btn1)
        view.addSubview(btn2)
        view.addSubview(btn3)
        
        btn1.translatesAutoresizingMaskIntoConstraints = false
        btn2.translatesAutoresizingMaskIntoConstraints = false
        btn3.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            btn1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            btn1.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            btn2.topAnchor.constraint(equalTo: btn1.bottomAnchor, constant: 16),
            btn2.centerXAnchor.constraint(equalTo: btn1.centerXAnchor),

            btn3.topAnchor.constraint(equalTo: btn2.bottomAnchor, constant: 16),
            btn3.centerXAnchor.constraint(equalTo: btn2.centerXAnchor),
        ])
    }
    
    func askQ(action: UIAlertAction!) {
        correctAnswer = Int.random(in: 0...2)
        title = "\(countries[correctAnswer].uppercased()). Score: \(score)"
    }
    
    func startNewGame(action: UIAlertAction!) {
        score = 0
        totalQ = 0
        
        askQ(action: nil)
    }
    
    @objc func btnTapped(_ sender: UIButton) {
        var title: String
        
        totalQ += 1
        
        if sender.tag ==  correctAnswer {
            title = "Correct!"
            score += 1
        } else {
            title = "Wrong! That's the flag of \(countries[sender.tag].uppercased())."
            score -= 1
        }
        
        if totalQ < 3 {
            let ac = UIAlertController(title: title, message: "Your score: \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQ))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Final", message: "Your final score: \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Start new game", style: .default, handler: startNewGame))
            present(ac, animated: true)
        }

    }

}

