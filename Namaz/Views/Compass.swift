//
//  Compass.swift
//  Namaz
//
//  Created by sarim khan on 17/11/2022.
//

import SwiftUI

struct Marker: Hashable {
    let degrees: Double
    let label: String

    init(degrees: Double, label: String = "") {
        self.degrees = degrees
        self.label = label
    }

    func degreeText() -> String {
        return String(format: "%.0f", self.degrees)
    }

    static func markers() -> [Marker] {
        return [
            Marker(degrees: 0, label: "N"),
            Marker(degrees: 30),
            Marker(degrees: 60),
            Marker(degrees: 90, label: "E"),
            Marker(degrees: 120),
            Marker(degrees: 150),
            Marker(degrees: 180, label: "S"),
            Marker(degrees: 210),
            Marker(degrees: 240),
            Marker(degrees: 270, label: "W"),
            Marker(degrees: 300),
            Marker(degrees: 330)
        ]
    }
}

struct CompassMarkerView: View {
    let marker: Marker
    let compassDegress: Double

    var body: some View {
        VStack {
            Text(marker.degreeText())
                .fontWeight(.light)
                .rotationEffect(self.textAngle())
            
            Capsule()
                .frame(width: self.capsuleWidth(),
                       height: self.capsuleHeight())
                .foregroundColor(self.capsuleColor())
            
            Text(marker.label)
                .fontWeight(.bold)
                .rotationEffect(self.textAngle())
                .padding(.bottom, 180)
        }.rotationEffect(Angle(degrees: marker.degrees))
    }
    
    private func capsuleWidth() -> CGFloat {
        return self.marker.degrees == 270 ? 7 : 3
    }

    private func capsuleHeight() -> CGFloat {
        return self.marker.degrees == 270 ? 45 : 30
    }

    private func capsuleColor() -> Color {
        return self.marker.degrees == 270 ? .red : .gray
    }

    private func textAngle() -> Angle {
        return Angle(degrees: -self.compassDegress - self.marker.degrees)
    }
}

struct Compass: View {
    @StateObject private var locationService:LocationService=LocationService()
    var body: some View {
        
        VStack{
//            Capsule()
//                           .frame(width: 5,
//                                  height: 50)

                       ZStack {
                           ForEach(Marker.markers(), id: \.self) { marker in
                               CompassMarkerView(marker: marker,
                                                 compassDegress: locationService.magneticHeading)
                           }
                       }
                       .frame(width: 300,
                              height: 300)
                       .rotationEffect(Angle(degrees: locationService.magneticHeading))
                       .statusBar(hidden: true)
            
            Text("Qibla is in west direstion")
        }
       // Text("\(locationService.magneticHeading)")
        
//        VStack {
//                   Capsule()
//                       .frame(width: 5,
//                              height: 50)
//
//                   ZStack {
//                       ForEach(Marker.markers(), id: \.self) { marker in
//                           CompassMarkerView(marker: marker,
//                                             compassDegress: self.compassHeading.degrees)
//                       }
//                   }
//                   .frame(width: 300,
//                          height: 300)
//                   .rotationEffect(Angle(degrees: self.compassHeading.degrees))
//                   .statusBar(hidden: true)
//               }
        
    }
}

struct Compass_Previews: PreviewProvider {
    static var previews: some View {
        Compass()
    }
}
