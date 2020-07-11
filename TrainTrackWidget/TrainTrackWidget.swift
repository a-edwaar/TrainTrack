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
        let entry = SimpleEntry(date: Date(), station: Station(id: "BHM", name: "Birmingham New Street", departures: Services(all: [Service(id: "1", platform: "1b", operatorName: "Virgin", origin: "London", destination: "Edinburgh", status: .late, aimedDepartureTime: "16:40", aimedArrivalTime: "16:39", expDepartureTime: "16:42", expArrivalTime: "16:40", expDepartureMins: 4, expArrivalMins: 2)]), arrivals: nil), type: .departure)
        completion(entry)
    }

    public func timeline(with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        /// get update for station
        RequestService().getStationUpdate(station: "BWT"){ result in
            switch result{
            case .success(var station):
                /// get top service for that station
                let departures = Array(station.getServices(type: .departure).all.prefix(1))
                station.departures?.all = departures
                /// set delay for 2 minute so it auto fetches next update
                let entry = SimpleEntry(date: Date(), station: station, type: .departure)
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
    public let station: Station
    public let type: Type
}

struct PlaceholderView : View {
    var body: some View {
        Text("Placeholder View")
    }
}

struct TrainTrackWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ServiceView(service: entry.station.getServices(type: entry.type).all[0], type: entry.type).padding()
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
            ServiceView(service: Service(id: "1", platform: "1b", operatorName: "Virgin", origin: "London", destination: "Birmingham new street", status: .late, aimedDepartureTime: "16:40", aimedArrivalTime: "16:39", expDepartureTime: "16:42", expArrivalTime: "16:40", expDepartureMins: 4, expArrivalMins: 2), type: .departure)
            Divider()
            ServiceView(service: Service(id: "1", platform: "1b", operatorName: "Virgin", origin: "London", destination: "Birmingham new street", status: .cancelled, aimedDepartureTime: "16:40", aimedArrivalTime: "16:39", expDepartureTime: "16:42", expArrivalTime: "16:40", expDepartureMins: 4, expArrivalMins: 2), type: .departure)
            Divider()
            ServiceView(service: Service(id: "1", platform: "1b", operatorName: "Virgin", origin: "London", destination: "Birmingham new street", status: .onTime, aimedDepartureTime: "16:40", aimedArrivalTime: "16:39", expDepartureTime: "16:42", expArrivalTime: "16:40", expDepartureMins: 4, expArrivalMins: 2), type: .departure)
            Spacer()
        }
        .padding()
        .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
