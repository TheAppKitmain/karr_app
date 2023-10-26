class CarDetailDataClass {
  String? make;
  String? model;
  String? dateOfFirstRegistration;
  String? yearOfManufacture;
  String? cylinderCapacity;
  String? co2Emissions;
  String? fuelType;
  String? transmission;
  String? taxStatus;
  String? colour;
  String? typeApproval;
  String? wheelPlan;
  String? revenueWeight;
  String? taxDetails;
  String? motDetails;
  String? vin;
  bool? taxed;
  bool? mot;

  CarDetailDataClass(
      {this.make,
        this.model,
        this.dateOfFirstRegistration,
        this.yearOfManufacture,
        this.cylinderCapacity,
        this.co2Emissions,
        this.fuelType,
        this.transmission,
        this.taxStatus,
        this.colour,
        this.typeApproval,
        this.wheelPlan,
        this.revenueWeight,
        this.taxDetails,
        this.motDetails,
        this.vin,
        this.taxed,
        this.mot});

  CarDetailDataClass.fromJson(Map<String, dynamic> json) {
    make = json['make'];
    model = json['model'];
    dateOfFirstRegistration = json['dateOfFirstRegistration'];
    yearOfManufacture = json['yearOfManufacture'];
    cylinderCapacity = json['cylinderCapacity'];
    co2Emissions = json['co2Emissions'];
    fuelType = json['fuelType'];
    transmission = json['transmission'];
    taxStatus = json['taxStatus'];
    colour = json['colour'];
    typeApproval = json['typeApproval'];
    wheelPlan = json['wheelPlan'];
    revenueWeight = json['revenueWeight'];
    taxDetails = json['taxDetails'];
    motDetails = json['motDetails'];
    vin = json['vin'];
    taxed = json['taxed'];
    mot = json['mot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['make'] = this.make;
    data['model'] = this.model;
    data['dateOfFirstRegistration'] = this.dateOfFirstRegistration;
    data['yearOfManufacture'] = this.yearOfManufacture;
    data['cylinderCapacity'] = this.cylinderCapacity;
    data['co2Emissions'] = this.co2Emissions;
    data['fuelType'] = this.fuelType;
    data['transmission'] = this.transmission;
    data['taxStatus'] = this.taxStatus;
    data['colour'] = this.colour;
    data['typeApproval'] = this.typeApproval;
    data['wheelPlan'] = this.wheelPlan;
    data['revenueWeight'] = this.revenueWeight;
    data['taxDetails'] = this.taxDetails;
    data['motDetails'] = this.motDetails;
    data['vin'] = this.vin;
    data['taxed'] = this.taxed;
    data['mot'] = this.mot;
    return data;
  }
}
