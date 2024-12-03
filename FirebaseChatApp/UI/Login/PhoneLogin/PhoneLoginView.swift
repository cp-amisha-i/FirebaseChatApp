//
//  PhoneLoginView.swift
//  FirebaseChatApp
//
//  Created by Amisha Italiya on 02/12/24.
//

import SwiftUI

public struct PhoneLoginView: View {
    
    @State var viewModel: PhoneLoginViewModel
    
    public var body: some View {
        VStack(spacing: 30) {
            Text("Login to start with app")
                .font(.title.bold())
            
            PhoneLoginContentView(phoneNumber: $viewModel.phoneNumber, countries: $viewModel.countries,
                                  selectedCountry: $viewModel.currentCountry, showLoader: viewModel.showLoader)
            
            PrimaryButton(text: "Send OTP") {
                viewModel.verifyAndSendOtp()
            }
        }
        .padding(.top, -50)
        .padding(.horizontal, 16)
        .alertView.alert(isPresented: $viewModel.showAlert, alertStruct: viewModel.alert)
    }
}

private struct PhoneLoginContentView: View {

    @Binding var phoneNumber: String
    @Binding var countries: [Country]
    @Binding var selectedCountry: Country

    let showLoader: Bool

    @State var showCountryPicker = false
    @FocusState var isFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                HStack(spacing: 8) {
                    Text(selectedCountry.dialCode)
                        .foregroundStyle(.primaryText)
                        .tracking(-0.2)
                }
                .onTapGesture {
                    showCountryPicker = true
                }

                Divider()
                    .frame(height: 50)
                    .background(.divider)
                    .padding(.horizontal, 16)

                ZStack(alignment: .leading) {
                    if phoneNumber.isEmpty {
                        Text(" Enter mobile number")
                            .foregroundStyle(.disableText)
                    }
                    TextField("", text: $phoneNumber)
                        .textContentType(.telephoneNumber)
                        .keyboardType(.phonePad)
                        .foregroundStyle(.primaryText)
                        .disabled(showLoader)
                        .tint(.appPrimary)
                        .focused($isFocused)
                        .onAppear {
                            isFocused = true
                        }
                }
            }
            .frame(height: 60)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 2)
            .padding(.horizontal, 10)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.disableText.opacity(0.4), lineWidth: 1)
            )
        }
        .sheet(isPresented: $showCountryPicker) {
            PhoneLoginCountryPicker(countries: $countries, selectedCountry: $selectedCountry, isPresented: $showCountryPicker)
        }
    }
}

private struct PhoneLoginCountryPicker: View {

    @Binding var countries: [Country]
    @Binding var selectedCountry: Country
    @Binding var isPresented: Bool

    @State private var searchCountry: String = ""
    @FocusState private var isFocused: Bool

    private var filteredCountries: [Country] {
        countries.filter { country in
            searchCountry.isEmpty ? true : country.name.lowercased().contains(searchCountry.lowercased()) ||
            country.dialCode.lowercased().contains(searchCountry.lowercased())
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            Text("Countries")
                .foregroundStyle(.primaryText)
                .padding(.top, 24)
                .padding(.bottom, 16)
                .frame(maxWidth: .infinity, alignment: .center)
                .onTapGesture {
                    isFocused = false
                }

            SearchBar(text: $searchCountry, isFocused: $isFocused, placeholder: "Search")
                .padding(.vertical, -7)
                .padding(.horizontal, 3)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.disableText, lineWidth: 1)
                })
                .focused($isFocused)
                .onAppear {
                    isFocused = true
                }
                .padding([.horizontal, .bottom], 16)

            if filteredCountries.isEmpty {
                CountryNotFoundView(searchCountry: searchCountry)
            } else {
                List(filteredCountries) { country in
                    PhoneLoginCountryCell(country: country) {
                        selectedCountry = country
                        isPresented = false
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
    }
}

private struct CountryNotFoundView: View {

    let searchCountry: String

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            Text("No results found for \"\(searchCountry)\"!")
                .foregroundStyle(.disableText)
                .padding(.bottom, 60)

            Spacer()
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

private struct PhoneLoginCountryCell: View {

    let country: Country
    let onCellSelect: () -> Void

    var body: some View {
        Button(action: onCellSelect) {
            HStack(spacing: 0) {
                Text(country.flag + " " + country.name)
                    .foregroundStyle(.primaryText)
                Spacer()
                Text(country.dialCode)
                    .foregroundStyle(.primaryText)
            }
        }
    }
}
