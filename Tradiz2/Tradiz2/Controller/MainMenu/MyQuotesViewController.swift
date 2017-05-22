//
//  MyQuotesViewController.swift
//  Tradiz2
//
//  Created by JIS on 5/15/17.
//  Copyright © 2017 Beautistar. All rights reserved.
//

import UIKit

class MyQuotesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    weak var delegate: LeftMenuProtocol?
    
    var w:CGFloat = 0.0
    var h:CGFloat = 0.0
    @IBOutlet weak var bgView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.removeNavigationBarItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil, completion: { (context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            guard let vc = (self.slideMenuController()?.mainViewController as? UINavigationController)?.topViewController else {
                return
            }
            if vc.isKind(of: MyQuotesViewController.self)  {
                self.slideMenuController()?.removeLeftGestures()
                self.slideMenuController()?.removeRightGestures()
            }
        })
    }
    
    func initView() {
        
        bgView.layer.masksToBounds = false;
        bgView.layer.shadowColor = UIColor.black.cgColor
        bgView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        bgView.layer.shadowOpacity = 0.5
        bgView.layer.cornerRadius = 5.0

        
        w = self.view.frame.size.width - 62.0
        h = 380.0;
    }
    
    @IBAction func backAction(_ sender: Any) {
        
        delegate?.changeViewController(LeftMenu.main)

    }

   
    // MARK: - CollectionView Datasource & delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuoteItemCell", for: indexPath) as! QuoteItemCell
        
        return cell;
    }
    
}

extension MyQuotesViewController : UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CGFloat(w), height: CGFloat(h))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
