//
//  NamazHomeView.swift
//  Namaz
//
//  Created by sarim khan on 10/09/2022.
//

import SwiftUI

struct NamazHomeView: View {
    
    @StateObject private var namazViewModel:NamazViewModel=NamazViewModel()
    let latitude :Double
    let longitude:Double
    
    
    var body: some View {
        VStack {
            switch namazViewModel.namazViewState{
            case .Initial:
                ProgressView()
                
            case .Loading:
                ProgressView()
            case .Error(let error):
                Text(error)
                
            case .Loaded(let namazModel):
                CustomView(namazModel: namazModel)
            }
        }
        .onAppear{
            namazViewModel.getNamazTiming(latitude: latitude, longitude: longitude)
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

struct CustomView: View {
    @State var namazModel:NamazModel
    var body: some View {
        VStack {
            Group {
                HStack{
                    Text(namazModel.data.date.hijri.day)
                        .font(.subheadline)
                        .fontWeight(.medium)
                    Text(namazModel.data.date.hijri.month.en)
                        .fontWeight(.medium)
                        .font(.subheadline)
                    Text(namazModel.data.date.hijri.month.ar)
                        .fontWeight(.medium)
                        .font(.subheadline)
                    Text(namazModel.data.date.hijri.year)
                        .fontWeight(.medium)
                        .font(.subheadline)
                    
                }
                
                
                
            }.padding([.top,.bottom])
            
            Group {
                HStack{
                    Text(namazModel.data.date.gregorian.day)
                        .fontWeight(.light)
                        .font(.subheadline)
                    Text(namazModel.data.date.gregorian.month.en)
                        .fontWeight(.light)
                        .font(.subheadline)
                    Text(namazModel.data.date.gregorian.year)
                        .fontWeight(.light)
                        .font(.subheadline)
                    
                }
            }
           
            
            Group {
                ExtractedView(timing: namazModel.data.timings.fajr,timeName: "Fajr")
                ExtractedView(timing: namazModel.data.timings.dhuhr,timeName:"Dhuhr")
                ExtractedView(timing: namazModel.data.timings.asr,timeName: "Asr")
                ExtractedView(timing: namazModel.data.timings.maghrib,timeName: "Maghrib")
                ExtractedView(timing: namazModel.data.timings.isha,timeName: "Isha")
                
            }
            
            Spacer()
            
            Group {
                Text(namazModel.data.meta.school)
                    .fontWeight(.light)
                    .font(.caption)
                Text(namazModel.data.meta.method.name)
                    .fontWeight(.light)
                    .font(.callout)
                Text(namazModel.data.meta.timezone)
                    .fontWeight(.light)
                    .font(.caption2)
            }
            
           
           
           
        }
        .padding(.horizontal)
        
        
    }
}

struct NamazHomeView_Previews: PreviewProvider {
    static var previews: some View {
        NamazHomeView(latitude: 0.0, longitude: 0.0)
    }
}

struct ExtractedView: View {
    let timing:String
    let timeName:String
    
    //HH:mm:ss
    
    var body: some View {
        HStack {
            Text(timeName)
                .fontWeight(.medium)
                .font(.title3)
            Spacer()
            Text(getDate(myDate:timing) ?? Date.now,format: Date.FormatStyle().hour().minute())
                .fontWeight(.medium)
                .font(.title2)
                
        }
        .padding()
        .background(Color("BackgroundColor"))
        .padding(.top)
        .cornerRadius(8)
    }
}
