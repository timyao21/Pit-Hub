//
//  HomeMapView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/16/25.
//

import SwiftUI
import MapKit


struct CircuitMapView: View {
    let coordinate: CLLocationCoordinate2D
    
    @State var postion: MapCameraPosition = .automatic
    
    init(lat: String, long: String) {
        let latitude = Double(lat) ?? 0.0
        let longitude = Double(long) ?? 0.0
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var body: some View {
        
        Map(position: $postion){
            Marker("Circuit", coordinate: coordinate)
        }
        .frame(height: 300)
        .cornerRadius(15)
        .onAppear() {
            let mapSpan = MKCoordinateSpan(latitudeDelta: 0.75, longitudeDelta: 0.75)
            let mapRegion = MKCoordinateRegion(center: coordinate, span: mapSpan)
            postion = .region(mapRegion)
        }
        
    }
}

struct HomeMapView_Previews: PreviewProvider {
    static var previews: some View {
        CircuitMapView(lat: "37.7749", long: "-122.4194") // Example coordinates for San Francisco
    }
}
