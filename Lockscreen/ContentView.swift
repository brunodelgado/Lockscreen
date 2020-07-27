//
//  ContentView.swift
//  Lockscreen
//
//  Created by Bruno Delgado on 16/07/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            GeometryReader { geo in
                Image("wallpaper")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
            }
            
            VStack(spacing: 0) {
                TopView()
                Spacer()
                if UIDevice.current.userInterfaceIdiom == .phone {
                    BottomView()
                        .padding(.bottom)
                }
            }
        }
    }
}

struct TopView: View {
    @State private var time: String = ""
    @State private var day: String = ""
    @State private var currentDate = Date() {
        didSet {
            self.time = TopView.timeFormatter.string(from: currentDate)
            self.day = TopView.dayFormatter.string(from: currentDate)
        }
    }

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private static var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    private static var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "EEEE, d MMMM"
        return formatter
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "lock.open.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .padding(.bottom)
                .foregroundColor(.white)
            
            Text(time)
                .font(Font.system(size: 80, weight: .thin))
                .foregroundColor(Color.white)
                .onReceive(timer) { input in
                    self.currentDate = input
                }
            
            Text(day)
                .font(Font.system(size: 22))
                .foregroundColor(.white)
                .onReceive(timer) { input in
                    self.currentDate = input
                }
        }
    }
}

struct BottomView: View {
    var body: some View {
        HStack {
            Button(action: { }) {
                Image(systemName: "flashlight.off.fill")
                    .font(.system(size: 20, weight: .light))
                    .frame(width: 50, height: 50)
                    .background(Color.black.opacity(0.3))
                    .clipShape(Circle())
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            Button(action: { }) {
                Image(systemName: "camera.fill")
                    .font(.system(size: 20, weight: Font.Weight.light))
                    .frame(width: 50, height: 50)
                    .background(Color.black.opacity(0.3))
                    .clipShape(Circle())
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 46)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.colorScheme, .light)
        //ContentView().environment(\.colorScheme, .dark)
    }
}
