import '../../models/user_model.dart';

class AuthService {
  static UserModel? _currentUser;

  static UserModel? get currentUser => _currentUser;

  static bool get isLoggedIn => _currentUser != null;

  static bool get isParent => _currentUser?.role == UserRole.parent;

  static bool get isNanny => _currentUser?.role == UserRole.nanny;

  // Método para login
  static Future<bool> login(String email, String password, UserRole role) async {
    // Aquí simularemos el login con datos de prueba
    // En una app real, esto se conectaría a un backend

    await Future.delayed(const Duration(seconds: 1)); // Simular llamada API

    if (role == UserRole.parent) {
      _currentUser = UserModel(
        id: '1',
        name: 'Carlos Mendoza',
        email: email,
        phone: '+51 987 654 321',
        role: UserRole.parent,
        location: 'Lima, Perú',
        numberOfChildren: 2,
        childrenAges: ['3 años', '6 años'],
      );
    } else {
      _currentUser = UserModel(
        id: '2',
        name: 'María Elena Quispe',
        email: email,
        phone: '+51 999 888 777',
        role: UserRole.nanny,
        location: 'San Isidro, Lima',
        yearsOfExperience: 5,
        hourlyRate: 12.0,
        certifications: ['Primeros Auxilios MINSA', 'Educación Inicial'],
        availableServices: ['Cuidado diario', 'Emergencia'],
        isVerified: true,
        dni: '12345678',
        rating: 4.8,
        completedJobs: 156,
      );
    }

    return true;
  }

  // Método para registro
  static Future<bool> register(UserModel user, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // Simular llamada API

    _currentUser = user;
    return true;
  }

  // Método para logout
  static void logout() {
    _currentUser = null;
  }

  // Verificar si la niñera está verificada
  static bool isNannyVerified() {
    if (_currentUser?.role != UserRole.nanny) return false;
    return _currentUser?.isVerified ?? false;
  }

  // Obtener documentos requeridos para niñeras
  static List<String> getRequiredDocuments() {
    return [
      'DNI o Carnet de Extranjería',
      'Certificado de Antecedentes Penales',
      'Certificado de Antecedentes Policiales',
      'Certificado Médico',
      'Constancia de Estudios o Certificaciones',
    ];
  }

  // Validar DNI peruano (8 dígitos)
  static bool validateDNI(String dni) {
    if (dni.length != 8) return false;
    return RegExp(r'^\d{8}$').hasMatch(dni);
  }

  // Validar teléfono peruano
  static bool validatePeruvianPhone(String phone) {
    // Formato: +51 9XX XXX XXX o 9XX XXX XXX
    return RegExp(r'^(\+51\s?)?9\d{8}$').hasMatch(phone.replaceAll(' ', ''));
  }
}
