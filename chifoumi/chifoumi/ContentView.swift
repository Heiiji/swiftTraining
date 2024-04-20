//
//  ContentView.swift
//  chifoumi
//
//  Created by Julien Juret on 27/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State var showAlert = false
    @State var showSheet = false
    @State var timer: Timer?
    
    @State var score = 0;
    @State var computerChoice = 0;
    @State var myChoice = 0;
    
    let icons = ["rock", "paper", "shotgun"]
    var pierreCasseCiseaux = "La pierre casse le shotgun"
    var ciseauxCoupePapier = "Le shotgun perce le papier"
    var paperEnveloppePierre = "Le papier enveloppe la pierre"
    var gagne = "C'est gagné!"
    var perdu = "Perdu ! Essaye encore"
    var draw = "Match nul"
    var drawExplain = "Vous avez choisi le même objet"
    
    var body: some View {
        GeometryReader { proxy in
            let idealSize = proxy.size.width / 3
            VStack {
                Text("Chi-Fou-Mi")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                    .bold()
                Divider()
                    .frame(height: 2)
                    .overlay(.blue)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                HStack {
                    Image(icons[myChoice])
                        .resizable()
                        .frame(width: idealSize, height: idealSize)
                    Spacer()
                    Text("VS")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.red)
                    Spacer()
                    Image(icons[computerChoice])
                        .resizable()
                        .frame(width: idealSize, height: idealSize)
                }.padding()
                Spacer()
                Text("Score: \(score)")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .italic()
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                Spacer()
                Button("Choisir") {
                    showSheet.toggle()
                }.buttonStyle(.borderedProminent)
            }
        }
        .onAppear() {
            playTimer()
        }
        // Aletres et Dialog
        .alert(handleResults().title, isPresented: $showAlert, actions: {
            Button("OK") {
                DispatchQueue.main.async {
                    self.score = self.handleResults().won ? self.score + 1 : self.score
                    self.playTimer()
                }
            }
        }, message: {
            Text(handleResults().message)
        })
        .confirmationDialog("Choisissez votre arme", isPresented: $showSheet) {
            Button("Pierre") {
                self.myChoice = 0
                self.play()
            }
            Button("Papier") {
                self.myChoice = 1
                self.play()
            }
            Button("Shotgun") {
                self.myChoice = 2
                self.play()
            }
        }
    }
    
    func handleResults() -> (title: String, message: String, won: Bool) {
        if (myChoice == computerChoice) {
            return(draw, drawExplain, false)
        } else if (myChoice == 0 && computerChoice == 2) {
            return(gagne, pierreCasseCiseaux, true)
        } else if (myChoice == 1 && computerChoice == 0) {
            return(gagne, paperEnveloppePierre, true)
        } else if (myChoice == 2 && computerChoice == 1) {
            return(gagne, ciseauxCoupePapier, true)
        } else if (myChoice == 0 && computerChoice == 1) {
            return(perdu, paperEnveloppePierre, false)
        } else if (myChoice == 1 && computerChoice == 2) {
            return(perdu, ciseauxCoupePapier, false)
        } else {
            return(perdu, pierreCasseCiseaux, false)
        }
    }
    
    // Timer
    func play() {
        stopTimer()
        showAlert = true
    }
    
    func playTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true, block: { t in
            if self.computerChoice == 2 {
                self.computerChoice = 0
            } else {
                self.computerChoice += 1
            }
        })
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
