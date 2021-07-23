


class AlertModel {
    AlertModel({
        this.key,
        this.value,
    });

    String? key;
    Value? value;

    factory AlertModel.fromJson(Map<String, dynamic> json) => AlertModel(
        key: json["key"],
        value: Value.fromJson(json["value"]),
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "value": value!.toJson(),
    };
}

class Value {
    Value({
        this.type,
        this.subscriptionArn,
        this.status,
    });

    String? type;
    String? subscriptionArn;
    String? status;

    factory Value.fromJson(Map<String, dynamic> json) => Value(
        type: json["type"],
        subscriptionArn: json["subscriptionArn"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "subscriptionArn": subscriptionArn,
        "status": status,
    };
}