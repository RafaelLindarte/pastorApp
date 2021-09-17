// To parse this JSON data, do
//
//     final alertModel = alertModelFromJson(jsonString);

import 'dart:convert';

AlertModel alertModelFromJson(String str) => AlertModel.fromJson(json.decode(str));

String alertModelToJson(AlertModel data) => json.encode(data.toJson());

class AlertModel {
    AlertModel({
        this.ok,
        this.alerts,
    });

    bool? ok;
    Alerts? alerts;

    factory AlertModel.fromJson(Map<String, dynamic> json) => AlertModel(
        ok: json["ok"],
        alerts: Alerts.fromJson(json["alerts"]),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "alerts": alerts!.toJson(),
    };
}

class Alerts {
    Alerts({
        this.items,
        this.count,
        this.scannedCount,
        this.lastEvaluatedKey,
    });

    List<Item>? items;
    int? count;
    int? scannedCount;
    LastEvaluatedKey? lastEvaluatedKey;

    factory Alerts.fromJson(Map<String, dynamic> json) => Alerts(
        items: List<Item>.from(json["Items"].map((x) => Item.fromJson(x))),
        count: json["Count"],
        scannedCount: json["ScannedCount"],
        lastEvaluatedKey: LastEvaluatedKey.fromJson(json["LastEvaluatedKey"]),
    );

    Map<String, dynamic> toJson() => {
        "Items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "Count": count,
        "ScannedCount": scannedCount,
        "LastEvaluatedKey": lastEvaluatedKey!.toJson(),
    };
}

class Item {
    Item({
        this.eventMunicipalities,
        this.eventDay,
        this.station,
        this.eventDate,
        this.eventDepth,
        this.eventLocation,
        this.eventType,
        this.eventTime,
    });

    dynamic eventMunicipalities;
    String? eventDay;
    String? station;
    String? eventDate;
    dynamic eventDepth;
    dynamic eventLocation;
    String? eventType;
    String? eventTime;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        eventMunicipalities: json["eventMunicipalities"],
        eventDay: json["eventDay"],
        station: json["Station"],
        eventDate: json["eventDate"],
        eventDepth: json["eventDepth"],
        eventLocation: json["eventLocation"],
        eventType: json["eventType"],
        eventTime: json["eventTime"],
    );

    Map<String, dynamic> toJson() => {
        "eventMunicipalities": eventMunicipalities,
        "eventDay": eventDay,
        "Station": station,
        "eventDate": eventDate,
        "eventDepth": eventDepth,
        "eventLocation": eventLocation,
        "eventType": eventType,
        "eventTime": eventTime,
    };
}

class LastEvaluatedKey {
    LastEvaluatedKey({
        this.id,
        this.createdAt,
        this.eventType,
    });

    String? id;
    int? createdAt;
    String? eventType;

    factory LastEvaluatedKey.fromJson(Map<String, dynamic> json) => LastEvaluatedKey(
        id: json["id"],
        createdAt: json["createdAt"],
        eventType: json["eventType"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt,
        "eventType": eventType,
    };
}


/*
.......##.......##..######..##.....##....###....##....##.########...#######..........##....##..#######........##.....##....###....##....##...........###....##.......########.########..########....###.....######........##.......##......########...#######..########........########.####.########.##.....##.########...#######.........######..########.......##.....##.####.########..#######...........###.....######..####...
......##.......##..##....##.##.....##...##.##...###...##.##.....##.##.....##.........###...##.##.....##.......##.....##...##.##....##..##...........##.##...##.......##.......##.....##....##......##.##...##....##......##.......##.......##.....##.##.....##.##.....##..........##.....##..##.......###...###.##.....##.##.....##.......##....##.##.............##.....##..##.......##..##.....##.........##.##...##....##..##....
.....##.......##...##.......##.....##..##...##..####..##.##.....##.##.....##.........####..##.##.....##.......##.....##..##...##....####...........##...##..##.......##.......##.....##....##.....##...##..##...........##.......##........##.....##.##.....##.##.....##..........##.....##..##.......####.####.##.....##.##.....##.......##.......##.............##.....##..##......##...##.....##........##...##..##........##....
....##.......##....##.......##.....##.##.....##.##.##.##.##.....##.##.....##.........##.##.##.##.....##.......#########.##.....##....##...........##.....##.##.......######...########.....##....##.....##..######.....##.......##.........########..##.....##.########...........##.....##..######...##.###.##.########..##.....##........######..######.........#########..##.....##....##.....##.......##.....##..######...##....
...##.......##.....##.......##.....##.#########.##..####.##.....##.##.....##.........##..####.##.....##.......##.....##.#########....##...........#########.##.......##.......##...##......##....#########.......##...##.......##..........##........##.....##.##...##............##.....##..##.......##.....##.##........##.....##.............##.##.............##.....##..##....##.....##.....##.......#########.......##..##....
..##.......##......##....##.##.....##.##.....##.##...###.##.....##.##.....##.........##...###.##.....##.......##.....##.##.....##....##...........##.....##.##.......##.......##....##.....##....##.....##.##....##..##.......##...........##........##.....##.##....##...........##.....##..##.......##.....##.##........##.....##.......##....##.##.............##.....##..##...##......##.....##.......##.....##.##....##..##....
.##.......##........######...#######..##.....##.##....##.########...#######..........##....##..#######........##.....##.##.....##....##...........##.....##.########.########.##.....##....##....##.....##..######..##.......##............##.........#######..##.....##..........##....####.########.##.....##.##.........#######.........######..########.......##.....##.####.########..#######........##.....##..######..####...
*/


class NotMoreAlerts {
    NotMoreAlerts({
        this.items,
        this.count,
        this.scannedCount,
    });

    List<Item>? items;
    int? count;
    int? scannedCount;

    factory NotMoreAlerts.fromJson(Map<String, dynamic> json) => NotMoreAlerts(
        items: List<Item>.from(json["Items"].map((x) => Item.fromJson(x))),
        count: json["Count"],
        scannedCount: json["ScannedCount"],
    );

    Map<String, dynamic> toJson() => {
        "Items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "Count": count,
        "ScannedCount": scannedCount,
    };
}

