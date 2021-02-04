class SmsNotificationModel {
  String dteCreatedDate;
  String strBookingReference;
  String customerName;
  String strPageName;
  String body;
  String msgto;
  String msgStatus;

  SmsNotificationModel(
      {this.dteCreatedDate,
      this.strBookingReference,
      this.customerName,
      this.strPageName,
      this.body,
      this.msgto,
      this.msgStatus});

  SmsNotificationModel.fromJson(Map<String, dynamic> json) {
    dteCreatedDate = json['dteCreatedDate'];
    strBookingReference = json['strBookingReference'];
    customerName = json['customerName'];
    strPageName = json['strPageName'];
    body = json['body'];
    msgto = json['msgto'];
    msgStatus = json['msgStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dteCreatedDate'] = this.dteCreatedDate;
    data['strBookingReference'] = this.strBookingReference;
    data['customerName'] = this.customerName;
    data['strPageName'] = this.strPageName;
    data['body'] = this.body;
    data['msgto'] = this.msgto;
    data['msgStatus'] = this.msgStatus;
    return data;
  }
}
