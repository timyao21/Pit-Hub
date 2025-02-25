//
//  HomeMapView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/16/25.
//

import SwiftUI
import MapKit


struct CircuitMapView: View {
    let circuit: CLLocationCoordinate2D
    @State var position: MapCameraPosition
    @State private var isFullScreen = false  // New state variable
    
    init(lat: String, long: String) {
        let latitude = Double(lat) ?? 0.0
        let longitude = Double(long) ?? 0.0
        self.circuit = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        // Start with a very large span (zoomed out)
        _position = State(initialValue: .region(
            MKCoordinateRegion(
                center: circuit,
                span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
            )
        ))
    }
    
    var body: some View {
        
        Map(position: $position){
            Marker(NSLocalizedString("Circuit", comment: "Circuit Marker"),systemImage: "flag.pattern.checkered.2.crossed" ,coordinate: circuit)
        }
        .safeAreaInset(edge: .trailing) {
            VStack(spacing: 6){
                Spacer()
                Button{
                    position = .region(MKCoordinateRegion(center: circuit, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)))
                } label: {
                    Image(systemName: "point.forward.to.point.capsulepath.fill")
                        .font(.title3)
                        .padding(3)
                        .background(.white)
                        .cornerRadius(8)
                        .shadow(radius: 5)
                }
                Button{
                    position = .region(MKCoordinateRegion(center: circuit, span: MKCoordinateSpan(latitudeDelta: 8.0, longitudeDelta: 8.0)))
                } label: {
                    Image(systemName: "building.2.fill")
                        .font(.title3)
                        .padding(3)
                        .background(.white)
                        .cornerRadius(8)
                        .shadow(radius: 5)
                }
                Button{
                    position = .region(MKCoordinateRegion(center: circuit, span: MKCoordinateSpan(latitudeDelta: 300.0, longitudeDelta: 300.0)))
                } label: {
                    Image(systemName: "globe.asia.australia.fill")
                        .font(.title3)
                        .padding(3)
                        .background(.white)
                        .cornerRadius(8)
                        .shadow(radius: 5)
                }
                Button{
                    isFullScreen = true
                } label: {
                    Image(systemName: "arrow.down.backward.and.arrow.up.forward.rectangle.fill")
                        .font(.title3)
                        .padding(3)
                        .background(.white)
                        .cornerRadius(8)
                        .shadow(radius: 5)
                }
                .padding(.top, 15)
            }
            .background(.clear)
            .padding()
            .padding(.bottom, 25)
        }
        .mapStyle(.standard(elevation: .automatic))
        .frame(height: 300)
        .cornerRadius(20)
        .fullScreenCover(isPresented: $isFullScreen) {
            // Present a full screen map view
            FullScreenMapView(circuit: circuit, isPresented: $isFullScreen)
        }
//        .onAppear(){
//            withAnimation(.easeOut(duration: 1.0)) {
//                position = .region(
//                    MKCoordinateRegion(
//                        center: circuit,
//                        span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
//                    )
//                )
//            }
//        }
    }
}

struct FullScreenMapView: View {
    let circuit: CLLocationCoordinate2D
    @Binding var isPresented: Bool
    @State private var position: MapCameraPosition = .automatic
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Map(position: $position) {
                Marker(NSLocalizedString("Circuit", comment: "Circuit Marker"),
                       systemImage: "flag.pattern.checkered.2.crossed",
                       coordinate: circuit)
            }
            .ignoresSafeArea() // Ensure the map fills the screen
            
            // A close button to dismiss the full screen view
            Button {
                isPresented = false
                
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.largeTitle)
                    .padding(3)
                    .background(Color.white.opacity(0.8))
                    .clipShape(Circle())
            }
            .padding()
        }
        .onAppear {
            // Optionally adjust the map’s camera position here
            position = .region(MKCoordinateRegion(center: circuit,
                                                  span: MKCoordinateSpan(latitudeDelta: 20.0, longitudeDelta: 20.0)))
        }
    }
}

struct HomeMapView_Previews: PreviewProvider {
    static var previews: some View {
        CircuitMapView(lat: "37.7749", long: "-122.4194") // Example coordinates for San Francisco
    }
}
