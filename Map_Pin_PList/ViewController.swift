//
//  ViewController.swift
//  Map_Pin_PList
//
//  Created by D7702_10 on 2017. 9. 19..
//  Copyright © 2017년 D7702_10. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {


    @IBOutlet weak var myMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        zoomToRegion()
        
        // plist 파일을 프로그램에 가져오기
        let path = Bundle.main.path(forResource: "ViewPoint3", ofType: "plist")
        print("path = \(String(describing: path))")
        
        // 이 프로그램에서 ViewPoint3.plist를 사용하기 위해 복사하기
        let content = NSArray(contentsOfFile: path!)
        print("content = \(String(describing: content))")

    }
    func zoomToRegion(){
        let center = CLLocationCoordinate2DMake(35.166197, 129.072594)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: center, span: span)
        myMapView.setRegion(region, animated: true)
    }




}

