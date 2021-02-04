class EmailNotificationModel {
  int intId;
  int intUserId;
  int intCustomerId;
  int intAppointmentId;
  String strEmail;
  String strPageName;
  String strActionName;
  String dteCreatedDate;
  String strMailContent;
  String mailChimpId;
  int intAutoMailid;
  bool isPartnerEmail;
  String strAttachmentPath;
  int intgroupid;
  bool bisfromPartner;
  bool bisfromCustomer;
  bool isGroupBillEmail;
  String strGroupBillIDs;
  String strGroupCustomerIDs;
  bool bisReadByCustomer;
  int intSupplierId;
  int intSupplierUserId;
  int intEngineerId;
  String strActionby;
  String customerName;
  String supplierCompany;
  String engineerName;

  EmailNotificationModel(
      {this.intId,
      this.intUserId,
      this.intCustomerId,
      this.intAppointmentId,
      this.strEmail,
      this.strPageName,
      this.strActionName,
      this.dteCreatedDate,
      this.strMailContent,
      this.mailChimpId,
      this.intAutoMailid,
      this.isPartnerEmail,
      this.strAttachmentPath,
      this.intgroupid,
      this.bisfromPartner,
      this.bisfromCustomer,
      this.isGroupBillEmail,
      this.strGroupBillIDs,
      this.strGroupCustomerIDs,
      this.bisReadByCustomer,
      this.intSupplierId,
      this.intSupplierUserId,
      this.intEngineerId,
      this.strActionby,
      this.customerName,
      this.supplierCompany,
      this.engineerName});

  EmailNotificationModel.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    intUserId = json['intUserId'];
    intCustomerId = json['intCustomerId'];
    intAppointmentId = json['intAppointmentId'];
    strEmail = json['strEmail'];
    strPageName = json['strPageName'];
    strActionName = json['strActionName'];
    dteCreatedDate = json['dteCreatedDate'];
    strMailContent = json['strMailContent'];
    mailChimpId = json['mailChimpId'];
    intAutoMailid = json['intAutoMailid'];
    isPartnerEmail = json['isPartnerEmail'];
    strAttachmentPath = json['strAttachmentPath'];
    intgroupid = json['intgroupid'];
    bisfromPartner = json['bisfromPartner'];
    bisfromCustomer = json['bisfromCustomer'];
    isGroupBillEmail = json['isGroupBillEmail'];
    strGroupBillIDs = json['strGroupBillIDs'];
    strGroupCustomerIDs = json['strGroupCustomerIDs'];
    bisReadByCustomer = json['bisReadByCustomer'];
    intSupplierId = json['intSupplierId'];
    intSupplierUserId = json['intSupplierUserId'];
    intEngineerId = json['intEngineerId'];
    strActionby = json['strActionby'];
    customerName = json['customerName'];
    supplierCompany = json['supplierCompany'];
    engineerName = json['engineerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['intUserId'] = this.intUserId;
    data['intCustomerId'] = this.intCustomerId;
    data['intAppointmentId'] = this.intAppointmentId;
    data['strEmail'] = this.strEmail;
    data['strPageName'] = this.strPageName;
    data['strActionName'] = this.strActionName;
    data['dteCreatedDate'] = this.dteCreatedDate;
    data['strMailContent'] = this.strMailContent;
    data['mailChimpId'] = this.mailChimpId;
    data['intAutoMailid'] = this.intAutoMailid;
    data['isPartnerEmail'] = this.isPartnerEmail;
    data['strAttachmentPath'] = this.strAttachmentPath;
    data['intgroupid'] = this.intgroupid;
    data['bisfromPartner'] = this.bisfromPartner;
    data['bisfromCustomer'] = this.bisfromCustomer;
    data['isGroupBillEmail'] = this.isGroupBillEmail;
    data['strGroupBillIDs'] = this.strGroupBillIDs;
    data['strGroupCustomerIDs'] = this.strGroupCustomerIDs;
    data['bisReadByCustomer'] = this.bisReadByCustomer;
    data['intSupplierId'] = this.intSupplierId;
    data['intSupplierUserId'] = this.intSupplierUserId;
    data['intEngineerId'] = this.intEngineerId;
    data['strActionby'] = this.strActionby;
    data['customerName'] = this.customerName;
    data['supplierCompany'] = this.supplierCompany;
    data['engineerName'] = this.engineerName;
    return data;
  }
}
