class AuthResponseModel {
  final int responseCode;
  final String message;
  final DataModel data;

  AuthResponseModel({
    required this.responseCode,
    required this.message,
    required this.data,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      responseCode: json['response_code'],
      message: json['message'],
      data: DataModel.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'response_code': responseCode,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class DataModel {
  final AuthorizationModel authorization;
  final DriverDataModel driverData;
  final List<ClientModel> clients;

  DataModel({
    required this.authorization,
    required this.driverData,
    required this.clients,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      authorization: AuthorizationModel.fromJson(json['authorization']),
      driverData: DriverDataModel.fromJson(json['driver_data']),
      clients: (json['clients'] as List)
          .map((client) => ClientModel.fromJson(client))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'authorization': authorization.toJson(),
      'driver_data': driverData.toJson(),
      'clients': clients.map((client) => client.toJson()).toList(),
    };
  }
}

class AuthorizationModel {
  final String type;
  final int expiresIn;
  final String token;

  AuthorizationModel({
    required this.type,
    required this.expiresIn,
    required this.token,
  });

  factory AuthorizationModel.fromJson(Map<String, dynamic> json) {
    return AuthorizationModel(
      type: json['type'],
      expiresIn: json['expires_in'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'expires_in': expiresIn,
      'token': token,
    };
  }
}

class DriverDataModel {
  final String name;
  final String cpf;

  DriverDataModel({
    required this.name,
    required this.cpf,
  });

  factory DriverDataModel.fromJson(Map<String, dynamic> json) {
    return DriverDataModel(
      name: json['name'],
      cpf: json['cpf'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cpf': cpf,
    };
  }
}

class ClientModel {
  final int branch;
  final int code;
  final String name;
  final int driverCode;
  final ParametersModel parameters;

  ClientModel({
    required this.branch,
    required this.code,
    required this.name,
    required this.driverCode,
    required this.parameters,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      branch: json['branch'],
      code: json['code'],
      name: json['name'],
      driverCode: json['driver_code'],
      parameters: ParametersModel.fromJson(json['parameters']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'branch': branch,
      'code': code,
      'name': name,
      'driver_code': driverCode,
      'parameters': parameters.toJson(),
    };
  }
}

class ParametersModel {
  final bool changePassword;
  final bool aviation;

  ParametersModel({
    required this.changePassword,
    required this.aviation,
  });

  factory ParametersModel.fromJson(Map<String, dynamic> json) {
    return ParametersModel(
      changePassword: json['change_password'],
      aviation: json['aviation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'change_password': changePassword,
      'aviation': aviation,
    };
  }
}
