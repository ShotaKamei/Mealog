//
//  TabBarController.swift
//  Mealog
//
//  Created by 亀井翔太 on 2022/09/18.
//

import UIKit

class TabBarController: UITabBarController{

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self  // delegateを設定
        let MainView  = UIStoryboard(name: "MainView", bundle: nil)
        let MainViewController = MainView.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        let MypageView  = UIStoryboard(name: "MypageView", bundle: nil)
        let MypageViewController = MypageView.instantiateViewController(withIdentifier: "MypageViewController") as! MypageViewController
        let FakeViewController = FakeViewController()
        MainViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 0)
        FakeViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        MypageViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        viewControllers = [MainViewController, FakeViewController, MypageViewController]
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension TabBarController: UITabBarControllerDelegate {
    // shouldSelectメソッドを実装
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == tabBarController.viewControllers?[1] {
            if let newVC = UIStoryboard(name: "SelectorView", bundle: nil).instantiateInitialViewController() {
                newVC.modalPresentationStyle = .fullScreen
                            tabBarController.present(newVC, animated: true, completion: nil)
                            return false
                        }
        }
        return true
    }
}
