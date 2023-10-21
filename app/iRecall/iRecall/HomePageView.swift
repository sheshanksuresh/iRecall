//
//  HomePageView.swift
//  iRecall
//
//  Created by Sheshank Personal on 2023-10-15.
//

import Foundation
import SwiftUI

struct HomePageView: View {
    @Binding var isMenuOpen: Bool
    @State private var selectedDate: Date = Date()
    @State private var isDatePickerPresented: Bool = false
    @State private var selectedMonth: Int = Calendar.current.component(.month, from: Date())
    @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())
    
    var body: some View {
        ZStack {
            VStack {
                // Menu
                BannerView(isMenuOpen: $isMenuOpen)
                
                Spacer()
                
                // Calendar and Topics
                VStack {
                    CalendarView(selectedDate: $selectedDate, selectedMonth: $selectedMonth, selectedYear: $selectedYear, isDatePickerPresented: $isDatePickerPresented)
                    Divider()
                    Text ("Today's Topics Placeholder")
                }
            }
            
            if isDatePickerPresented {
                DatePickerView(selectedMonth: $selectedMonth, selectedYear: $selectedYear, isDatePickerPresented: $isDatePickerPresented)
            }
        }
    }
}

struct BannerView: View {
    @Binding var isMenuOpen: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                withAnimation {
                    isMenuOpen.toggle()
                }
            }) {
                Image(systemName: "list.bullet")
            }
            Spacer()
            Text("User's Name") // TODO: Implement logic to replace this with logged in user's first name
            Image(systemName: "person.circle") // TODO: Implement logic to replace this with logged in user's profile picture
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
    }
}

struct CalendarView: View {
    @Binding var selectedDate: Date
    @Binding var selectedMonth: Int
    @Binding var selectedYear: Int
    @Binding var isDatePickerPresented: Bool
    let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let calendar = Calendar.current
    
    var body: some View {
        VStack(alignment: .center) {
            Button(action: {
                isDatePickerPresented.toggle()
            }) {
                Text(currentMonthAndYear)
                    .font(.headline)
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .foregroundColor(.black)
                    .cornerRadius(8)
            }
            .popover(isPresented: $isDatePickerPresented, content: {
                DatePickerView(selectedMonth: $selectedMonth, selectedYear: $selectedYear, isDatePickerPresented: .constant(true))
            })
            
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .frame(maxWidth: .infinity)
                }
            }
            
            ForEach(0..<numberOfWeeksInCurrentMonth, id: \.self) { week in
                HStack(spacing: 0) {
                    ForEach(0..<7, id: \.self) { day in
                        if let currentDay = dateForCell(week: week, day: day) {
                            Button(action: {
                                selectedDate = currentDay
                            }) {
                                Text(String(calendar.component(.day, from: currentDay)))
                                    .font(.system(size: 16))
                                    .frame(width: 26, height: 26)
                                    .padding()
                                    .background(
                                        Calendar.current.isDate(selectedDate, equalTo: currentDay, toGranularity: .day) ?
                                        Color.blue : Color.clear
                                    )
                                    .foregroundColor(
                                        Calendar.current.isDate(selectedDate, equalTo: currentDay, toGranularity: .day) ?
                                        Color.white : Color.black
                                    )
                                    .cornerRadius(20)
                            }
                        } else {
                            Text("")
                                .padding()
                                .frame(width: 26 + 31, height: 26 + 31)
                        }
                    }
                }
            }
        }
    }
    
    var currentMonthAndYear: String {
        let dateComponents = DateComponents(year: selectedYear, month: selectedMonth)
        if let date = calendar.date(from: dateComponents) {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM yyyy"
            return formatter.string(from: date)
        } else {
            return "Invalid Date"
        }
    }
    
    var numberOfWeeksInCurrentMonth: Int {
        let calendar = Calendar.current
//        let range = calendar.range(of: .weekOfMonth, in: .month, for: Date())!
        let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: Date()))!
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        let daysInMonth = calendar.range(of: .day, in: .month, for: Date())!.count
        return firstWeekday + daysInMonth <= 36 ? 5 : 6
    }
    
    var daysInCurrentMonth: Int {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: Date())!
        return range.count
    }
    
    func dateForCell(week: Int, day: Int) -> Date? {
        let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: Date()))!
        let firstWeekday = calendar.component(.weekday, from: firstOfMonth)
        let dayOffset = (week * 7) + day - (firstWeekday - 1)
        if dayOffset < 0 || dayOffset >= daysInCurrentMonth {
            return nil
        }
        return calendar.date(byAdding: .day, value: dayOffset, to: firstOfMonth)
    }
}

struct DatePickerView: View {
    @Binding var selectedMonth: Int
    @Binding var selectedYear: Int
    @Binding var isDatePickerPresented: Bool
    
    var months: [String] = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    let years: [String] = Array(2000...2100).map { String($0) }
    
    var body: some View {
        VStack (spacing: 20){
            HStack {
                Button("Cancel") {
                    isDatePickerPresented = false
                }
                Spacer()
                Button("Done") {
                    isDatePickerPresented = false
                }
            }
            .padding()
            
            Divider()
            
            HStack {
                Picker(selection: $selectedMonth, label: Text("")) {
                    ForEach(months, id: \.self) { month in
                        Text(month).tag(Int(month) ?? 1)
                    }
                }
                .frame(width: UIScreen.main.bounds.width/2)
                .clipped()
                
                Picker(selection: $selectedYear, label: Text("")) {
                    ForEach(years, id: \.self) { year in
                        Text(year).tag(Int(year) ?? 1)
                    }
                }
                .frame(width: UIScreen.main.bounds.width/2)
                .clipped()
            }
        }
        .background(Color.white)
        .cornerRadius(20)
        .frame(height: UIScreen.main.bounds.height/2)
        .offset(y: isDatePickerPresented ? UIScreen.main.bounds.height/4 : UIScreen.main.bounds.height)
        .animation(.easeInOut(duration: 0.3))
    }
}
#Preview {
    HomePageView(isMenuOpen: .constant(false))
}
