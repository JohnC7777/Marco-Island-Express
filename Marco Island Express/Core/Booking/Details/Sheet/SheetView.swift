//
//  SheetView.swift
//  Marco Island Express
//
//  Created by United States MO on 1/17/24.
//

import SwiftUI

struct SheetView: View {
    
    @EnvironmentObject var vm : RideDetailsViewModel

    var body: some View {
        VStack(alignment:.leading){
            SuggestedRidesView()
                .padding(.top)
            
            Divider()
                .padding(.vertical, 5)
            
            HStack{
                Text("NOTES")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.leading)
                    .foregroundStyle(Color.theme.secondaryTextColor)
                TextField(text: $vm.notes, label: {
                    Text("Please enter some notes")
                })
                .textFieldStyle(.roundedBorder)
                .padding(.trailing)
            }
            
            HStack{
                Text("CHILD SEAT")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.leading)
                    .foregroundStyle(Color.theme.secondaryTextColor)
                Picker("Car Seat Type", selection: $vm.carSeat){
                    ForEach(CarSeatType.allCases) { seatType in
                        Text(seatType.rawValue).tag(seatType)
                    }
                }
                .foregroundStyle(Color.theme.primaryTextColor)
            }
            
            Divider()
            
            HStack{
                HStack{
                    Spacer()
                    Image(systemName: "creditcard")
                    Text("Payment")
                    Image(systemName: "chevron.down")
                    Spacer()
                }
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.theme.secondaryBackgroundColor)
                }
                
                HStack{
                    Spacer()
                    Image(systemName: "calendar")
                    Text("Time")
                    Image(systemName: vm.showDatePicker ? "chevron.up" : "chevron.down")
                    Spacer()
                }
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.theme.secondaryBackgroundColor)
                }
                .onTapGesture {
                    withAnimation{
                        vm.showDatePicker = true
                    }
                }
                .popover(isPresented: $vm.showDatePicker, arrowEdge: .bottom) {
                    DatePicker("Select Date", selection: $vm.selectedDate, displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding(15)
                        .padding(.bottom)
                        .padding(.horizontal)
                        .frame(width: 400)
                        .presentationCompactAdaptation(.popover)
                }
            }
            .padding(.horizontal)
            
            HStack{
                Spacer()
                Text("REVIEW")
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.vertical)
            .background{
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.theme.accentColor)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .padding(.bottom, 15)
        .background{
            UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 10, topTrailing: 10))
                .foregroundStyle(Color.theme.backgroundColor)
        }
    }
}

#Preview {
    SheetView()
        .preferredColorScheme(.dark)
}

