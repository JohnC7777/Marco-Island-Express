//
//  SearchView.swift
//  Marco Island Express
//
//  Created by United States MO on 1/13/24.
//

import SwiftUI

struct SearchView: View {
    
    
    @FocusState.Binding var focusedField: SearchField?
    @Binding var whereIsUser: SearchUserState?
    @EnvironmentObject var vm : LocationSearchViewModel
    
    var body: some View {
        VStack{
            HStack{
                VStack{
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 24)
                    Rectangle()
                        .fill(.black)
                        .frame(width: 6, height: 6)
                }
                
                VStack{
                    //TODO: separate these into a custom component?
                    TextField("Pickup Location", text: $vm.fromQueryFragment)
                        .frame(height: 32)
                        .backgroundStyle(Color(.systemGroupedBackground))
                        .padding(.trailing)
                        .onTapGesture {
                            focusedField = .from
                            whereIsUser = .from
                        }
                        .focused($focusedField, equals: .from)
                        .submitLabel(.search)
                    
                    TextField("Dropoff Location", text: $vm.toQueryFragment)
                        .frame(height: 32)
                        .background(Color(.systemGray4))
                        .padding(.trailing)
                        .padding(.trailing)
                        .onTapGesture {
                            focusedField = .to
                            whereIsUser = .to
                        }
                        .focused($focusedField, equals: .to)
                        .submitLabel(.search)
                    
                }
                .onSubmit {
                    switch whereIsUser {
                    
                    case .from:
                        whereIsUser = .lookingFrom
                        break
                        
                    case .to:
                        whereIsUser = .lookingTo
                        break
                        
                    default:
                        print("")
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 64)
            
            Divider()
                .padding(.vertical)
            
            
            //Scroll View
            ScrollView{
                VStack(alignment: .leading){
                    ForEach(vm.results, id: \.self){ result in
                        LocationSearchResultCell(title: result.title, subtitle: result.subtitle)
                            .onTapGesture {
                                
                                switch whereIsUser {
                                case .from:
                                    vm.fromQueryFragment = result.title
                                    vm.fromResult = result
                                    whereIsUser = .to
                                    focusedField = .to
                                    break
                                    
                                case .lookingFrom:
                                    vm.fromQueryFragment = result.title
                                    vm.fromResult = result
                                    whereIsUser = .to
                                    focusedField = .to
                                    break
                                
                                case .to:
                                    vm.toQueryFragment = result.title
                                    vm.toResult = result
                                    whereIsUser = .done
                                    withAnimation(.spring()){
                                        vm.configureSearchResultsFor(vm.fromResult, vm.toResult)
                                    }

                                    break
                                    
                                case .lookingTo:
                                    vm.toQueryFragment = result.title
                                    vm.toResult = result
                                    whereIsUser = .done
                                    withAnimation(.spring()){
                                        vm.configureSearchResultsFor(vm.fromResult, vm.toResult)
                                    }
                                    break
                                    
                                default:
                                    break
                                }
                            }
                    }
                }
            }
        }
        .background(Color.theme.backgroundColor)
    }
}

struct SearchView_Previews: PreviewProvider {
    @FocusState static var focusedField: SearchField?
    @State static var whereIsUser: SearchUserState? = nil
    
    static var previews: some View {
        let mockViewModel = LocationSearchViewModel()

        return SearchView(
            focusedField: $focusedField,
            whereIsUser: $whereIsUser
        )
        .environmentObject(mockViewModel)
    }
}
