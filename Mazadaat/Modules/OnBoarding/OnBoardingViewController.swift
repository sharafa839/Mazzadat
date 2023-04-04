//
//  OnBoardingViewController.swift
//  Mazadaat
//
//  Created by Sharaf on 28/03/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class OnBoardingViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var startButton: CustomButton!
    @IBOutlet weak var welcomeSubTitleLabel: UILabel!
    @IBOutlet weak var welcomeTitleLabel: UILabel!
    @IBOutlet weak var viewOfImage: UIView!
    //MARK: -  LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startButton.setTitle("Next", for: .normal)
    }
    
    //MARK: - Methods
    @IBAction func nextActionButton(_ sender: CustomButton) {
        let viewModel = OnBoardingViewModel()
        let onBoardingScreens = OnBoardingScreensViewController(viewModel: viewModel)
        navigationController?.pushViewController(onBoardingScreens, animated: true)
    }
    

    
}


extension UIFont{
    static func ArchivoRegular(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "Archivo-Regular", size: size)!
    }
    
    static func Archivo(_ size: CGFloat, weight: FontWeight = .regular) -> UIFont {
        UIFont(name: "Archivo-\(weight.value)", size: size) ?? .systemFont(ofSize: size)
    }
}

enum FontWeight:String {
    case regular
    case Black
    case Bold
    case Light
    case Thin
    var value: String { rawValue.capitalizingFirstLetter() }
}
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}

struct ButtonStyle {
    var name:String
    var color:UIColor
    var titleColor:UIColor
    init(name:String,color:UIColor,titleColor:UIColor) {
        self.name = name
        self.color = color
        self.titleColor = titleColor
    }
    
}

