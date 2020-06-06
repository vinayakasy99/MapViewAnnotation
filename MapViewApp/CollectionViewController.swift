import UIKit
import MapKit

struct PlacesOnMap {
    var name: String
    var latitude: Double
    var longitude: Double

init(name: String, latitude: Double, longitude: Double) {
    self.name = name
    self.latitude = latitude
    self.longitude = longitude
    }
}

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, MKMapViewDelegate {
   
    @IBOutlet weak var mapView1: MKMapView!
    var placesVal = [PlacesOnMap(name: "place 1", latitude: 12.9716, longitude: 77.5946),
                     PlacesOnMap(name: "place 2", latitude: 12.2958, longitude: 76.6394),
    PlacesOnMap(name: "place 3", latitude: 11.4102, longitude: 76.6950)
    ]
    var buildings = [PlacesOnMap(name: "buildings 1", latitude: 12.9716, longitude: 77.5946),
    PlacesOnMap(name: "buildings 2",  latitude: 12.2958, longitude: 76.6394)
    ]
    var recreation = [PlacesOnMap(name: "recreation 1", latitude: 28.54693, longitude: -81.393071),
    PlacesOnMap(name: "recreation 2", latitude: 28.538523, longitude: -81.385399),
    PlacesOnMap(name: "recreation 3", latitude: 28.542817, longitude: -81.378117),
    PlacesOnMap(name: "recreation 4", latitude: 28.538985, longitude: -81.404694)
    ]
  
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    var items = ["Places", "Buildings", "Recreations"]


    // MARK: - UICollectionViewDataSource protocol

    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }

    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell

        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.myLabel.text = self.items[indexPath.item]
        cell.backgroundColor = UIColor.cyan // make cell more visible in our example project

        return cell
    }

    // MARK: - UICollectionViewDelegate protocol

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        if(indexPath.item == 0){
                  setPlacesAnnotations()
              }else if(indexPath.item == 1){
                  setBuildingsAnnotations()
              }else{
                  setRecreationAnnotations()
              }
              mapView1.delegate = self
    }
    
    func setPlacesAnnotations() {
           let places = placesVal.map { placeOnMap -> MKPointAnnotation in
           let place = MKPointAnnotation()
           place.coordinate =  CLLocationCoordinate2D(latitude: placeOnMap.latitude, longitude: placeOnMap.longitude)
           place.title = placeOnMap.name
           return place
           }
           mapView1.removeAnnotations(mapView1.annotations)
           mapView1.addAnnotations(places)
       }

       func setBuildingsAnnotations() {
           let places = buildings.map { placeOnMap -> MKPointAnnotation in
           let place = MKPointAnnotation()
           place.coordinate =  CLLocationCoordinate2D(latitude: placeOnMap.latitude, longitude: placeOnMap.longitude)
           place.title = placeOnMap.name
           return place
           }
           mapView1.removeAnnotations(mapView1.annotations)
           mapView1.addAnnotations(places)
       }

       func setRecreationAnnotations() {
           let places = recreation.map { placeOnMap -> MKPointAnnotation in
           let place = MKPointAnnotation()
           place.coordinate =  CLLocationCoordinate2D(latitude: placeOnMap.latitude,  longitude: placeOnMap.longitude)
           place.title = placeOnMap.name
           return place
           }
           mapView1.removeAnnotations(mapView1.annotations)
           mapView1.addAnnotations(places)
       }

       
       func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard let annotationTitle = view.annotation?.title else
                  {
                      print("Unable to retrieve details")
                   return
                  }
         print("User tapped on annotation with title: \(annotationTitle!)")
       }
    
}
extension CollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 3
        var widthRemainingForCellContent = collectionView.bounds.width
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            let borderSize: CGFloat = flowLayout.sectionInset.left + flowLayout.sectionInset.right
            widthRemainingForCellContent -= borderSize + ((cellsAcross - 1) * flowLayout.minimumInteritemSpacing)
        }
        let cellWidth = widthRemainingForCellContent / cellsAcross
        return CGSize(width: cellWidth, height: cellWidth)
    }

}
