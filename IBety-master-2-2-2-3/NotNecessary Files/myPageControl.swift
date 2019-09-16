
import UIKit

class myPageControl: UIPageControl {
    
    var activeImage: UIImage
    var inactiveImage: UIImage
    
    required init?(coder aDecoder: NSCoder) {
        activeImage = UIImage(named: "active0")!
        inactiveImage = UIImage(named: "inactive0")!
        super.init(coder: aDecoder)
    }
    
    func updateDots()
    {
      //self.wid
      //  self.subviews[0].frame=CGRect.init(x: 0, y: 0, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
        for i in 0 ..< self.subviews.count
        {
            let dot : UIImageView = imageViewForSubview(view: subviews[i])
            
           // print("\(dot.frame.width)")
            if (i == self.currentPage) {
                activeImage=UIImage(named: "active\(i)")!
                dot.image = activeImage
            }
            else {
                inactiveImage=UIImage(named: "inactive\(i)")!
                dot.image = inactiveImage
            }
        }
    }
    
    func imageViewForSubview(view: UIView) -> UIImageView {
        var dot: UIImageView? = nil
        
            for subview: UIView in view.subviews {
                if (subview is UIImageView) {
                    dot = (subview as! UIImageView)
                }
            }
            if dot == nil {
                dot = UIImageView(frame: CGRect(x: view.frame.width/2-1.5, y: view.frame.height/2-1.5, width: view.frame.size.width/2, height: view.frame.size.height/2))}
        if let dot = dot{
//                dot.frame.origin = CGPoint(x: view.frame.size.width / 2 - dot.frame.width / 2,
//                                           y: view.frame.size.height / 2 - dot.frame.height / 2)
            view.addSubview(dot)}
        
        return dot!
    }
    
    func setPage(page: Int) {
        super.currentPage = page
        self.updateDots()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard !subviews.isEmpty else { return }
        let spacing: CGFloat = 30
        //let height = spacing
        var total: CGFloat = spacing
        updateDots()
        for view in subviews {
           // view.layer.cornerRadius = 0
            var width = view.frame.width
            print("\(width) mostafa")
            view.transform = CGAffineTransform.init(scaleX: 5, y: 5)
            view.frame.origin.x = total
            view.frame.origin.y = frame.size.height / 2 - view.frame.height / 2
            width = view.frame.width
            print("\(width) *******")
            total += width + spacing
            print("\(total) &&&&&&&&")
        }
        total -= spacing
        print("\(total) &&&&&&&&")
        frame.origin.x = frame.origin.x + frame.size.width / 2 - total / 2
        print("\(frame.origin.x) &&&&&&&&")
        frame.size.width = total
        print("\(frame.size.width) &&&&&&&&")
        
        
        
    }
    
   
    
}
