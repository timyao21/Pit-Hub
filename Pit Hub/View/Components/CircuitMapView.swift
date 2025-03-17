import SwiftUI
import MapKit

// MARK: - Region Extensions
extension MKCoordinateRegion {
    static func focused(for coordinate: CLLocationCoordinate2D) -> MKCoordinateRegion {
        MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        )
    }
    
    static func city(for coordinate: CLLocationCoordinate2D) -> MKCoordinateRegion {
        MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 8.0, longitudeDelta: 8.0)
        )
    }
    
    static func global(for coordinate: CLLocationCoordinate2D) -> MKCoordinateRegion {
        MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 300.0, longitudeDelta: 300.0)
        )
    }
}

// MARK: - Reusable Button Style Modifier
struct ControlButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .padding(8)
            .background(Color(.systemBackground).opacity(0.8))
            .clipShape(Circle())
    }
}

extension View {
    func controlButtonStyle() -> some View {
        self.modifier(ControlButtonModifier())
    }
}

// MARK: - Reusable Zoom Controls
struct ZoomControls: View {
    let circuit: CLLocationCoordinate2D
    @Binding var position: MapCameraPosition
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            Button {
                withAnimation {
                    position = .region(.focused(for: circuit))
                }
            } label: {
                Image(systemName: "point.forward.to.point.capsulepath.fill")
            }
            .controlButtonStyle()
            
            Button {
                withAnimation {
                    position = .region(.city(for: circuit))
                }
            } label: {
                Image(systemName: "building.2.fill")
            }
            .controlButtonStyle()
            
            Button {
                withAnimation {
                    position = .region(.global(for: circuit))
                }
            } label: {
                Image(systemName: "globe.asia.australia.fill")
            }
            .controlButtonStyle()
            Spacer().frame(height: 20)
        }
        .padding()
    }
}

// MARK: - Reusable Map Style Toggle
struct MapStyleToggle: View {
    @Binding var isHybrid: Bool
    
    var body: some View {
        Button {
            withAnimation {
                isHybrid.toggle()
            }
        } label: {
            Image(systemName: isHybrid ? "map.fill" : "map")
        }
        .controlButtonStyle()
    }
}

// MARK: - Main Circuit Map View
struct CircuitMapView: View {
    let circuit: CLLocationCoordinate2D
    @State var position: MapCameraPosition
    @State private var isLoading = true
    @State private var isFullScreen = false
    @State private var isHybrid = false

    init(lat: String, long: String) {
        let latitude = Double(lat) ?? 0.0
        let longitude = Double(long) ?? 0.0
        self.circuit = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        _position = State(initialValue: .region(
            MKCoordinateRegion(
                center: circuit,
                span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
            )
        ))
    }
    
    var body: some View {
        ZStack{
            Map(position: $position) {
                Marker(
                    LocalizedStringKey("Circuit"),
                    systemImage: "flag.pattern.checkered.2.crossed",
                    coordinate: circuit
                )
            }
            .disabled(true)
            .mapStyle(isHybrid ? .hybrid : .standard(elevation: .automatic))
            .safeAreaInset(edge: .leading) {
                ZoomControls(circuit: circuit, position: $position)
            }
            .safeAreaInset(edge: .trailing) {
                VStack(spacing: 12) {
                    Spacer()
                    MapStyleToggle(isHybrid: $isHybrid)
                    Button {
                        isFullScreen = true
                    } label: {
                        Image(systemName: "arrow.down.backward.and.arrow.up.forward.rectangle.fill")
                    }
                    .controlButtonStyle()
                    Spacer().frame(height: 20)
                }
                .padding()
            }
            .fullScreenCover(isPresented: $isFullScreen) {
                FullScreenMapView(circuit: circuit, isPresented: $isFullScreen)
            }
            .frame(height: 300)
            .cornerRadius(20)
            .shadow(radius:3,x: 3,y: 3)
            .onAppear(){
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isLoading = false
                }
            }
            
            // Loading Overlay
            if isLoading {
                LoadingOverlay()
                    .frame(height: 300)
                    .cornerRadius(20)
            }
            
        }
    }
}

// MARK: - Full Screen Map View
struct FullScreenMapView: View {
    let circuit: CLLocationCoordinate2D
    @Binding var isPresented: Bool
    @State private var position: MapCameraPosition = .automatic
    @State private var isHybrid = false

    var body: some View {
        ZStack {
            Map(position: $position) {
                Marker(
                    NSLocalizedString("Circuit", comment: "Circuit Marker"),
                    systemImage: "flag.pattern.checkered.2.crossed",
                    coordinate: circuit
                )
            }
            .mapStyle(isHybrid ? .hybrid : .standard(elevation: .automatic))
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    Button {
                        isPresented = false
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                    }
                    .font(.largeTitle)
                    .padding(3)
                    .background(Color.white.opacity(0.8))
                    .clipShape(Circle())
                    .padding()
                }
                Spacer()
            }
            
            // Left side: Zoom Controls
            ZoomControls(circuit: circuit, position: $position)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Right side: Map Style Toggle
            VStack {
                Spacer()
                MapStyleToggle(isHybrid: $isHybrid)
                Spacer().frame(height: 20)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .onAppear {
            position = .region(
                MKCoordinateRegion(
                    center: circuit,
                    span: MKCoordinateSpan(latitudeDelta: 20.0, longitudeDelta: 20.0)
                )
            )
        }
    }
}

// MARK: - Preview
struct HomeMapView_Previews: PreviewProvider {
    static var previews: some View {
        CircuitMapView(lat: "37.7749", long: "-122.4194")
    }
}
