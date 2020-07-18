//
//  TrainTrackWidget.swift
//  TrainTrackWidget
//
//  Created by Archie Edwards on 07/07/2020.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    public typealias Entry = SimpleEntry

    public func snapshot(with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), services: [
            Service(id: "id", platform: "10a", station: "Southamption", status: .cancelled, scheduledTime: "16:22", expMins: 60)
        ])
        completion(entry)
    }

    public func timeline(with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        /// get update for station
        RequestService().getStationUpdate(StationRequest(station: Station(id: "BHM", name: "Birmingham New Street"), filterStation: nil, type: .departure)){ result in
            switch result{
            case .success(var services):
                /// get top service for that station
                services = Array(services.prefix(1))
                /// set delay for 2 minute so it auto fetches next update
                let entry = SimpleEntry(date: Date(), services: services)
                let expiryDate = Calendar
                    .current.date(byAdding: .minute, value: 2,
                                          to: Date()) ?? Date()
                let timeline = Timeline(entries: [entry], policy: .after(expiryDate))
                completion(timeline)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
    public let services: [Service]
}

struct PlaceholderView : View {
    var body: some View {
        Text("Placeholder View")
    }
}

struct TrainTrackWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ServiceView(service: entry.services[0]).padding()
    }
}

@main
struct TrainTrackWidget: Widget {
    private let kind: String = "TrainTrackWidget"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider(), placeholder: PlaceholderView()) { entry in
            TrainTrackWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
    }
}

struct TrainTrackWidget_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            Spacer()
            ServiceView(service: Service(id: "id", platform: "1b", station: "Birmingham New Street", status: .onTime, scheduledTime: "14:44", expMins: 10))
            Divider()
            ServiceView(service: Service(id: "id", platform: "12b", station: "Manchester", status: .late, scheduledTime: "15:00", expMins: 20))
            Divider()
            ServiceView(service: Service(id: "id", platform: "10a", station: "Southamption", status: .cancelled, scheduledTime: "16:22", expMins: 60))
            Spacer()
        }
        .padding()
        .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
