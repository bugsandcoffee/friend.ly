//
//  ContentView.swift
//  friend.ly
//
//  Created by Bugs and Coffee on 2021-09-24.
//

import SwiftUI

struct ContentView: View {
    @State var navInt:Int = 1
    var body: some View {
        VStack {
            HStack {
                Button(action: {self.navInt = 0}) {
                    Image("profile")
                }
                Spacer()
                Button(action: {self.navInt = 1}) {
                    Image("tinder-icon").resizable().aspectRatio(contentMode:.fit).frame(height:45)
                }
                Spacer()
                Button(action: {self.navInt = 2}) {
                    Image("chats")
                }
            }.padding(.horizontal)
            if navInt == 1 {
                ZStack {
                    ForEach(Card.data.reversed()) { card in
                        CardView(card: card).padding(8)
                    }
                }.zIndex(1.0)
                
                HStack(spacing: 0) {
                    Button(action: {}) {
                        Image("refresh")
                    }
                    Button(action: {}) {
                        Image("dismiss")
                    }
                    Button(action: {}) {
                        Image("super_like")
                    }
                    Button(action: {}) {
                        Image("like")
                    }
                    Button(action: {}) {
                        Image("boost")
                    }
                }
            } else if navInt == 2 {
                ZStack {
                    MessengerView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11 Pro")
    }
}

struct CardView: View {
    @State var card: Card
    let cardGradient = Gradient(colors: [Color.black.opacity(0), Color.black.opacity(0.5)])
    var body: some View {
        ZStack (alignment: .topLeading) {
            Image(card.imageName).resizable()
            LinearGradient(gradient: cardGradient, startPoint: .top, endPoint: .bottom)
            VStack {
                Spacer()
                VStack {
                    HStack {
                        Text(card.name).font(.largeTitle).fontWeight(.bold)
                        Text(String(card.age)).font(.title)
                    }
                    Text(card.bio)
                }
                .padding()
                .foregroundColor(.white)
            }
            HStack {
                Image("yes")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .opacity(Double(card.x/10 - 1))
                Spacer()
                Image("nope")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .opacity(Double(card.x/10 * -1 - 1))
            }
        }
        .cornerRadius(8)
        .offset(x: card.x, y: card.y)
        .rotationEffect(.init(degrees: card.degree))
        .gesture (
            DragGesture()
                .onChanged { value in
                    withAnimation(.default) {
                        card.x = value.translation.width
                        card.y = value.translation.height
                        card.degree = 7 * (value.translation.width > 0 ? 1 : -1)
                    }
                    
                }
                .onEnded {value in
                    withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 50, damping: 8, initialVelocity: 0)) {
                        switch value.translation.width {
                            case 0...100:
                                card.x = 0; card.degree = 0; card.y = 0
                            case let x where x > 100:
                                card.x = 500; card.degree = 12
                            case (-100)...(-1):
                                card.x = 0; card.degree = 0; card.y = 0
                            case let x where x < -100:
                                card.x = -500; card.degree = -12
                            default: card.x = 0; card.y = 0
                        }
                    }
                }
        )
    }
}

struct MessengerView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            TopView()
            Centerview()
            Spacer()
        }
    }
}

struct TopView : View {
    var body : some View {
        VStack(spacing: 20) {
            HStack {
                Text("Messages")
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(Color.black.opacity(0.7))
                    .padding(20)
                Spacer()
                Button(action: {
                    
                }) {
                    Image("menu")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.black.opacity(0.4))
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 18) {
                    ForEach(1...7, id: \.self) {i in
                        Button(action: {
                            
                        }) {
                            Image("p\(i)")
                                .resizable()
                                .frame(width: 40, height: 60)
                                .cornerRadius(20)
                        }
                    }
                }
            }.padding(20)
        }
    }
}

struct Centerview : View {
    var body : some View {
        List(dataM) {i in
            cellView(dataM : i).padding(10)
        }
    }
}

struct cellView : View {
    
    var dataM : Msg
    var body : some View {
        HStack(spacing: 12) {
            Image(dataM.img)
                .resizable()
                .frame(width: 30, height: 40)
            VStack(alignment: .leading, spacing: 12) {
                Text(dataM.name).fontWeight(.bold)
                Text(dataM.msg).font(.caption)
            }
            Spacer(minLength: 0)
            VStack {
                Text(dataM.date)
                Spacer()
            }
        }
    }
}

struct Msg : Identifiable {
    var id : Int
    var name : String
    var msg: String
    var date : String
    var img : String
}

var dataM = [
    Msg(id: 0, name: "Emily", msg: "Hello!", date: "25/03/20", img: "p1"),
    Msg(id: 1, name: "Emma", msg: "How are you?", date: "25/04/21", img: "p2"),
    Msg(id: 2, name: "Julia", msg: "Hi Martin. What are you up to tonight?", date: "21/02/19", img: "p3"),
]
