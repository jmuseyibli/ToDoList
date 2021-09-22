//
//  CalendarView.swift
//  ShoppingList
//
//  Created by Javid Museyibli on 18.09.21.
//

import SwiftUI
import ElegantCalendar

struct CalendarView: View, ElegantCalendarDataSource {

    @ObservedObject var viewModel = ShoppingListViewModel()
    @ObservedObject var calendarManager: ElegantCalendarManager

    init() {
        let year = Calendar.current.component(.year, from: Date())

        let firstOfThisYear = Calendar.current.date(from: DateComponents(year: year, month: 1, day: 1))!
        let firstOfNextYear = Calendar.current.date(from: DateComponents(year: year + 1, month: 1, day: 1))
        let lastOfYear = Calendar.current.date(byAdding: .day, value: -1, to: firstOfNextYear!)!
        // Get the last day of the current year

        let configuation = CalendarConfiguration(
            startDate: firstOfThisYear,
            endDate: lastOfYear)

        calendarManager = ElegantCalendarManager(configuration: configuation, initialMonth: Date())

        viewModel.getList()
        calendarManager.datasource = self
    }
    
    var body: some View {
        NavigationView {

            ElegantCalendarView(calendarManager: calendarManager)
                .theme(CalendarTheme(primary: Color(.systemGray4), titleColor: .primary, textColor: .primary, todayTextColor: .white, todayBackgroundColor: .blue))

                .onAppear {
                    viewModel.getList()
                    calendarManager.scrollBackToToday(animated: true)
                }

        }
    }
}

extension CalendarView {
    func calendar(viewForSelectedDate date: Date, dimensions size: CGSize) -> AnyView {
        let startOfDay = Calendar.current.startOfDay(for: date)
        guard let items = viewModel.itemsByDate[startOfDay] else { return Text("No items found").erased }
        
        return VStack {
            ForEach(items) { item in
                CalendarListItem(shoppingItem: .constant(item))
            }
        }.erased

    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
