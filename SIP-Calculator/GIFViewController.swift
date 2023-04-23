//
//  GIFViewController.swift
//  SIP_Calculator
//
//  Created by Hiren Lakhatariya on 15/04/23.
//

import UIKit

class GIFViewController: UIViewController {
    
    @IBOutlet weak var GIF: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(GIF)
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4)
        {
            self.performSegue(withIdentifier: "suege", sender: self)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            self.loadGIF()
        }
    }
    
    func loadGIF()
    {
        GIF.loadGif(name: "output-onlinegiftools")
    }
    
}
