//
//  ArticleViewController.swift
//  AppStore
//
//  Created by c.c on 2019/6/11.
//  Copyright © 2019 RayWenderlich.com. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate
{

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var closeButton: UIButton!
    
    var cardView: UIView!
    var cardViewType: CardViewType
    var textLabel: UILabel!
    
    var panGestureRecognizer : UIPanGestureRecognizer!
    var interactionController: UIPercentDrivenInteractiveTransition?
    
    init(_ cardViewType: CardViewType) {
        self.cardViewType = cardViewType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        putCardView()
        putTextLabel()
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.panRecognized))
        panGestureRecognizer.delegate = self
        scrollView.addGestureRecognizer(panGestureRecognizer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateUI()
    }
    
    @IBAction func handleDismiss(_ sender: UIButton) {
        self.transitioningDelegate = self
        self.closeButton.isHidden = true
        
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc func panRecognized(gesture: UIPanGestureRecognizer) {
        
        guard interactionController != nil else { return }
        
        switch gesture.state
        {
        case .began:
            break
            
        case .changed:
            let percent = gesture.translation(in: gesture.view).y / 420
            interactionController?.update(percent)
            
        case .cancelled:
            fallthrough
            
        case .ended:
            
            if
                gesture.velocity(in: gesture.view).y < 0 ||
                gesture.state == .cancelled ||
                (gesture.velocity(in: gesture.view).y == 0 &&
                gesture.translation(in: gesture.view).y < 210)
            {
                print("cancel")
                interactionController?.cancel()
                
                closeButton.isHidden = false
                scrollView.isScrollEnabled = true
                
            } else {
                print("finish")
                interactionController?.finish()
            }
            
            interactionController = nil
            
        default: ()
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.contentOffset.y < 0 && scrollView.isTracking else { return }
        
        closeButton.isHidden = true
        scrollView.isScrollEnabled = false
        
        interactionController = UIPercentDrivenInteractiveTransition()
        transitioningDelegate = self
        
        dismiss(animated: true, completion: nil)
    }

}


extension ArticleViewController: UIViewControllerTransitioningDelegate
{
    
    // MARK: UIViewControllerTransitioningDelegate
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ArticleViewDismissTransitioning()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController
    }
    
}


// MARK: - 初始化视图

extension ArticleViewController {
    
    private func putCardView() {
        cardView = cardViewType.createCardView()
        
        cardView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 420)
        cardView.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        scrollView.addSubview(cardView)
    }
    
    private func putTextLabel() {
        textLabel = UILabel()
        textLabel.attributedText = getAttributeText()
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 0
        
        let targetSize = textLabel.sizeThatFits(CGSize.init(width: self.view.bounds.width - 30, height: CGFloat.infinity))
        textLabel.frame = CGRect(x: 15, y: 420, width: self.view.bounds.width - 30, height: targetSize.height)
        textLabel.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        
        scrollView.insertSubview(textLabel, belowSubview: cardView)
    }
    
    private func updateUI() {
        cardView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 420)
        
        let targetSize = textLabel.sizeThatFits(CGSize.init(width: self.view.bounds.width - 30, height: CGFloat.infinity))
        
        textLabel.frame = CGRect(x: 15, y: 420, width: self.view.bounds.width - 30, height: targetSize.height)
        scrollView.contentSize = CGSize(width: view.bounds.width, height: textLabel.frame.maxY + 120)
    }
    
    private func getAttributeText() -> NSAttributedString {
        let firstString = "Lorem Ipsum is simply "
        let firstAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .medium),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        
        let firstAttributedString = NSMutableAttributedString(string: firstString, attributes: firstAttributes)
        
        let secondString = "dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.\n\nIt has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\n\nContrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. \n\nLorem Ipsum comes from sections 1.10.32 and 1.10.33 of 'de Finibus Bonorum et Malorum' (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, 'Lorem ipsum dolor sit amet..', comes from a line in section 1.10.32. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from 'de Finibus Bonorum et Malorum' by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham. Where can I get some? There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."
        
        let secondAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .regular),
            NSAttributedString.Key.foregroundColor: UIColor.gray
        ]
        let secondAttributedString = NSMutableAttributedString(string: secondString, attributes: secondAttributes)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.2
        
        let attributedString = NSMutableAttributedString(attributedString: firstAttributedString)
        attributedString.append(secondAttributedString)
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        
        return attributedString
    }
    
}
