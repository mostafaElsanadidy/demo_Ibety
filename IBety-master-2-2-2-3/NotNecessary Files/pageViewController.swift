//
//  pageViewController.swift
//  IBety
//
//  Created by Mohamed on 6/18/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class pageViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var pageControl: myPageControl!
    
    @IBOutlet weak var infoBttn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var productsBttn: UIButton!
    @IBOutlet weak var proDataBttn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = true
        infoBttn.layer.cornerRadius = 15.0
        productsBttn.layer.cornerRadius = 15.0
        proDataBttn.layer.cornerRadius = 15.0
    
        
        //scrollView.addSubview(infoBttn)
        
       
        
        view.bringSubviewToFront(scrollView)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let frame1 = proDataBttn.frame
        let frame2 = productsBttn.frame
        let frame3 = infoBttn.frame
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: frame1.width+frame1.origin.x, y: frame1.origin.y+frame1.height/2))
        path.addLine(to: CGPoint(x: frame2.origin.x, y: frame1.origin.y+frame1.height/2))
        
        path.move(to: CGPoint.init(x: frame2.origin.x+frame2.width, y: frame1.origin.y+frame1.height/2))
        path.addLine(to: CGPoint(x: frame3.origin.x, y: frame1.origin.y+frame1.height/2))
        
        //        let path2 = UIBezierPath(roundedRect: view.bounds, cornerRadius: 15.0)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = #colorLiteral(red: 0.8924478889, green: 0.8924478889, blue: 0.8924478889, alpha: 1)
        shapeLayer.fillColor = UIColor.brown.cgColor
     
        scrollView.layer.addSublayer(shapeLayer)
        
    setupSlideScrollView()
        
    }
    
    
    
    func setupSlideScrollView() {

        // frame = scrollView.frame

//        if var view = self.view.viewWithTag(200){
//            let demoView = DemoView(frame: view.frame)
//            view = demoView}

            let frame = scrollView.frame
            scrollView.contentSize.width = scrollView.frame.size.width * 3
            scrollView.contentSize.height = view.frame.size.height
            scrollView.isPagingEnabled = true



                let slide1:ProjectInfoView = Bundle.main.loadNibNamed("ProjectInfoView", owner: self, options: nil)?.first as! ProjectInfoView
                slide1.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: view.frame.size.height)
                scrollView.addSubview(slide1)

                let slide2:ProjectProductView = Bundle.main.loadNibNamed("ProjectProductView", owner: self, options: nil)?.first as! ProjectProductView
                slide2.frame = CGRect(x: frame.size.width , y: 0, width: frame.size.width, height: view.frame.size.height)
                scrollView.addSubview(slide2)

                let slide3:ProjectDataView = Bundle.main.loadNibNamed("ProjectDataView", owner: self, options: nil)?.first as! ProjectDataView
                slide3.frame = CGRect(x: frame.size.width * 2, y: 0, width: frame.size.width, height: view.frame.size.height)
                scrollView.addSubview(slide3)

      }



    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)

        let mainBttns: [UIButton] = [proDataBttn, productsBttn, infoBttn]

        if pageIndex == 0{

           updateButtons2(mainBttns: mainBttns, selectedIndex: 0)
        }
        if pageIndex == 1{

            updateButtons2(mainBttns: mainBttns, selectedIndex: 1)

        }
        if pageIndex == 2{
            updateButtons2(mainBttns: mainBttns, selectedIndex: 2)
        }
    }


    func updateButtons2(mainBttns:[UIButton], selectedIndex:Int){

        for i in 0 ..< mainBttns.count{
            if i == selectedIndex{

                mainBttns[i].backgroundColor = #colorLiteral(red: 0.5687007308, green: 0.08060152084, blue: 0.267926693, alpha: 1)

                mainBttns[i].setImage(UIImage(named: "active\(i)"), for: .normal)
            }
            else{

                mainBttns[i].backgroundColor = #colorLiteral(red: 0.9458244443, green: 0.9458244443, blue: 0.9458244443, alpha: 1)
                mainBttns[i].setImage(UIImage(named: "inactive\(i)"), for: .normal)
            }
        }
    }


    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


