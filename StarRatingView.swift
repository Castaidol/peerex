//
//  StarRatingView.swift
//  Peerex
//
//  Created by Gabriele Castaldo on 20/12/16.
//  Copyright © 2016 Gabriele Castaldo. All rights reserved.
//

import UIKit

protocol StarRatingViewDelegate: class {
    func starRatingViewTap(starRatingView: StarRatingView)
}

class StarRatingView: UIView {

    weak var delegate: StarRatingViewDelegate?
    
    var ratingCount: Int = 0
    
    var arrayOfStars: [UIButton] = []
    var numberOfStars: Int = 0
    /*
     var star1: UIButton
     var star2: UIButton
     var star3: UIButton
     var star4: UIButton
     var star5: UIButton
     */
    
    func setup(numberOfStars: Int) {
        self.numberOfStars = numberOfStars
        
        for _ in 0...numberOfStars-1 {
            arrayOfStars.append(UIButton())
        }
        
        let totalWidth = self.frame.size.width
        let totalHeight = self.frame.size.height
        let dividedWidth = totalWidth / CGFloat(numberOfStars)
        
        for x in 0...numberOfStars-1 {
            let star = arrayOfStars[x]
            star.frame = CGRect(x: CGFloat(x) * dividedWidth, y: 0, width: dividedWidth, height: totalHeight)
            star.setImage(UIImage(named:"rate-big-nonselected.png"), for: .normal)
            star.setImage(UIImage(named:"rate-big-selected.png"), for: .selected)
            star.imageView?.contentMode = .scaleAspectFit
            star.addTarget(self, action: #selector(starTapped), for: .touchUpInside)
            self.addSubview(star)
            
            
            
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        
        
        super.init(coder: aDecoder)
        
        
    }
    
    func starTapped(sender: Any?){
        
        var selectedIndex: Int = -1
        
        for x in 0...numberOfStars-1{
            
            let star = arrayOfStars[x]
            
            let selectedStar = sender as! UIButton
            
            if selectedStar == star{
                
                selectedIndex = x
                
                break
                
            }
            
            
        }
        
        ratingCount = selectedIndex + 1
        
        for x in 0...numberOfStars-1{
            
            let star = arrayOfStars[x]
            
            if x <= selectedIndex{
                
                star.isSelected = true
            }
            else if x > selectedIndex{
                
                star.isSelected = false
                
            }
            
        }
        
        
        //in this context to notify feedback vc that this rating view was molested
        delegate?.starRatingViewTap(starRatingView: self)
        
        
    }
}
