//
//  ViewController.swift
//  Map_Pin_PList
//
//  Created by 장규식 on 2017. 9. 19..
//  Copyright © 2017년 D7702_10. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {


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
        
        var annotations = [MKPointAnnotation]() //plist 데이터를 배열에 저장

        // optional binding
        if let myItems = content {
            // Dictionary Array에서 값 뽑기
            for item in myItems {
                let lat = (item as AnyObject).value(forKey: "lat")
                let long = (item as AnyObject).value(forKey: "long")
                let title = (item as AnyObject).value(forKey: "title")
                let subTitle = (item as AnyObject).value(forKey: "subTitle")
                
                let annotation = MKPointAnnotation()
                
                print("lat = \(String(describing: lat))")
                
                let myLat = (lat as! NSString).doubleValue
                let myLong = (long as! NSString).doubleValue
                let myTitle = title as! String
                let mySubTitle = subTitle as! String
                
                print("myLat = \(myLat)")
                
                annotation.coordinate.latitude = myLat
                annotation.coordinate.longitude = myLong
                annotation.title = myTitle
                annotation.subtitle = mySubTitle
            
                annotations.append(annotation)
                
                myMapView.delegate = self
                
            }
        } else {
            print("contents의 값은 nil")
        }
        
        //전체 핀이 지도에 보이도록 함
        myMapView.showAnnotations(annotations, animated: true)
        
        //핀 하나가 자동으로 탭되도록 처리
        myMapView.selectAnnotation(annotations[2], animated: true)
        myMapView.addAnnotations(annotations)

    }
    func zoomToRegion(){
        //  DIT 위치정보 35.166197, 129.072594
        let center = CLLocationCoordinate2DMake(35.166197, 129.072594)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: center, span: span)
        myMapView.setRegion(region, animated: true)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "MyPin"
        var  annotationView = myMapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            if annotation.title! == "부산시민공원" {
                // 부시민공원
                annotationView?.pinTintColor = UIColor.green
                let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53)) //이미지 크기지정
                leftIconView.image = UIImage(named:"citizen_logo.png" )
                annotationView?.leftCalloutAccessoryView = leftIconView
                
            } else if annotation.title! == "동의과학대학교" {
                // 동의과학대학교
                let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
                leftIconView.image = UIImage(named:"DIT_logo.png" )
                annotationView?.leftCalloutAccessoryView = leftIconView
                
            } else if annotation.title! == "송상현광장"{
                // 송상현광장
                annotationView?.pinTintColor = UIColor.blue
                let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
                leftIconView.image = UIImage(named:"Songsang.png" )
                annotationView?.leftCalloutAccessoryView = leftIconView
            } else if annotation.title! == "집"{
                // 집
                annotationView?.pinTintColor = UIColor.blue
                let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
                leftIconView.image = UIImage(named:"home.png" )
                annotationView?.leftCalloutAccessoryView = leftIconView
            } else {
                // 양정역
                annotationView?.pinTintColor = UIColor.blue
                let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
                leftIconView.image = UIImage(named:"Yangjeong.jpg" )
                annotationView?.leftCalloutAccessoryView = leftIconView
            }
        } else {
            annotationView?.annotation = annotation
        }
        
        // 오른쪽에 버튼 생성
        let btn = UIButton(type: .detailDisclosure)
        annotationView?.rightCalloutAccessoryView = btn

        
        return annotationView
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl){
        
        let viewAnno = view.annotation
        let viewTitle: String = ((viewAnno?.title)!)!
        let viewSubTitle: String = ((viewAnno?.subtitle)!)!
        
        let ac = UIAlertController(title: viewTitle, message: viewSubTitle, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }
}

