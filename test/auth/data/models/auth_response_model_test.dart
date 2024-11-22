import 'package:flutter_test/flutter_test.dart';
import 'package:app_frotas/app/modules/auth/data/models/auth_response_model.dart';

void main() {
  group('AuthResponseModel', () {
    test('deve criar um AuthResponseModel válido a partir de JSON', () {
      final json = {
        'response_code': 0,
        'message': 'sucesso',
        'data': {
          'authorization': {
            'type': 'Bearer',
            'expires_in': 3600,
            'token': 'mockToken',
          },
          'driver_data': {
            'name': 'João da Silva',
            'cpf': '12345678900',
          },
          'clients': [
            {
              'branch': 1,
              'code': 100,
              'name': 'Cliente 1',
              'driver_code': 1234,
              'parameters': {
                'change_password': true,
                'aviation': false,
              },
            }
          ],
        },
      };

      final model = AuthResponseModel.fromJson(json);

      expect(model.responseCode, 0);
      expect(model.message, 'sucesso');
      expect(model.data.authorization.token, 'mockToken');
      expect(model.data.driverData.name, 'João da Silva');
      expect(model.data.clients[0].name, 'Cliente 1');
    });

    test('deve converter um AuthResponseModel para JSON corretamente', () {
      final model = AuthResponseModel(
        responseCode: 0,
        message: 'sucesso',
        data: DataModel(
          authorization: AuthorizationModel(
            type: 'Bearer',
            expiresIn: 3600,
            token: 'mockToken',
          ),
          driverData: DriverDataModel(
            name: 'João da Silva',
            cpf: '12345678900',
          ),
          clients: [
            ClientModel(
              branch: 1,
              code: 100,
              name: 'Cliente 1',
              driverCode: 1234,
              parameters: ParametersModel(
                changePassword: true,
                aviation: false,
              ),
            )
          ],
        ),
      );

      final json = model.toJson();

      expect(json['response_code'], 0);
      expect(json['message'], 'sucesso');
      expect(json['data']['authorization']['token'], 'mockToken');
      expect(json['data']['driver_data']['name'], 'João da Silva');
      expect(json['data']['clients'][0]['name'], 'Cliente 1');
    });
  });
}
