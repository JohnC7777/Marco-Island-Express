//
//  TipPicker.swift
//  Marco Island Express
//
//  Created by United States MO on 2/8/24.
//

import SwiftUI

struct TipPicker: View {
    
    @State private var customTipAlert : Bool = false
    @Namespace private var animation
    @EnvironmentObject var vm : RideDetailsViewModel

    var body: some View {
        HStack{
            HStack(alignment: .center){
                Text("$20")
                    .fontWeight(.heavy)
                    .foregroundColor(vm.tipSelectedIndex == 1 ? .white : .black)
                    .opacity(vm.tipSelectedIndex == 1 ? 1 : 0.7)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background{
                        if vm.tipSelectedIndex == 1 {
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(Color.theme.accentColor)
                                .matchedGeometryEffect(id: "OPTION", in: animation)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture{
                        withAnimation{vm.tipSelectedIndex = 1; vm.tipAmount = 20}
                    }
                
                Text("$25")
                    .fontWeight(.heavy)
                    .foregroundColor(vm.tipSelectedIndex == 2 ? .white : .black)
                    .opacity(vm.tipSelectedIndex == 2 ? 1 : 0.7)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background{
                        if vm.tipSelectedIndex == 2 {
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(Color.theme.accentColor)
                                .matchedGeometryEffect(id: "OPTION", in: animation)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture{
                        withAnimation{vm.tipSelectedIndex = 2; vm.tipAmount = 25}
                    }
                
                Text("$30")
                    .fontWeight(.heavy)
                    .foregroundColor(vm.tipSelectedIndex == 3 ? .white : .black)
                    .opacity(vm.tipSelectedIndex == 3 ? 1 : 0.7)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background{
                        if vm.tipSelectedIndex == 3 {
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(Color.theme.accentColor)
                                .matchedGeometryEffect(id: "OPTION", in: animation)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture{
                        withAnimation{vm.tipSelectedIndex = 3; vm.tipAmount = 30}
                    }
                Text("$40")
                    .fontWeight(.heavy)
                    .foregroundColor(vm.tipSelectedIndex == 4 ? .white : .black)
                    .opacity(vm.tipSelectedIndex == 4 ? 1 : 0.7)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background{
                        if vm.tipSelectedIndex == 4 {
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(Color.theme.accentColor)
                                .matchedGeometryEffect(id: "OPTION", in: animation)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture{
                        withAnimation{vm.tipSelectedIndex = 4;  vm.tipAmount = 40}
                    }
                Text("Other")
                    .fontWeight(.heavy)
                    .foregroundColor(vm.tipSelectedIndex == 5 ? .white : .black)
                    .opacity(vm.tipSelectedIndex == 5 ? 1 : 0.7)
                    .padding(.vertical, 8)
                    .frame(width: 100)
                    .background{
                        if vm.tipSelectedIndex == 5 {
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(Color.theme.accentColor)
                                .matchedGeometryEffect(id: "OPTION", in: animation)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture{
                        vm.tipAmount = nil
                        customTipAlert = true
                        withAnimation{vm.tipSelectedIndex = 5}
                    }
                
            }
            .background{
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color(.systemGray5))
            }
            .alert("Tip", isPresented: $customTipAlert) {
                TextField("Amount", value: $vm.tipAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .onChange(of: vm.tipAmount) { newValue in
                        if newValue ?? 0.00 < 0.00 {
                            vm.tipAmount = 0.00 // Set the value to 0 if it's negative
                        }
                    }
                //Button("Submit")
            } message: {
                Text("Enter Custom Tip Amount")
            }
        }
    }
}
