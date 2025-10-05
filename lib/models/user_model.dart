enum UserRole {
  parent,
  nanny,
}

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final UserRole role;
  final String? location;
  final String? profileImageUrl;
  final DateTime? dateOfBirth;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Campos específicos para padres
  final int? numberOfChildren;
  final List<String>? childrenAges;
  final String? emergencyContact;

  // Campos específicos para niñeras
  final int? yearsOfExperience;
  final double? hourlyRate;
  final List<String>? certifications;
  final List<String>? availableServices;
  final bool? isVerified;
  final String? dni;
  final double? rating;
  final int? completedJobs;
  final String? bio;
  final List<String>? languages;
  final bool? isAvailable;
  final String? bankAccount;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.role,
    this.location,
    this.profileImageUrl,
    this.dateOfBirth,
    DateTime? createdAt,
    DateTime? updatedAt,
    // Campos para padres
    this.numberOfChildren,
    this.childrenAges,
    this.emergencyContact,
    // Campos para niñeras
    this.yearsOfExperience,
    this.hourlyRate,
    this.certifications,
    this.availableServices,
    this.isVerified,
    this.dni,
    this.rating,
    this.completedJobs,
    this.bio,
    this.languages,
    this.isAvailable,
    this.bankAccount,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  // Constructor para crear un padre
  factory UserModel.parent({
    required String id,
    required String name,
    required String email,
    String? phone,
    String? location,
    int? numberOfChildren,
    List<String>? childrenAges,
    String? emergencyContact,
  }) {
    return UserModel(
      id: id,
      name: name,
      email: email,
      phone: phone,
      role: UserRole.parent,
      location: location,
      numberOfChildren: numberOfChildren,
      childrenAges: childrenAges,
      emergencyContact: emergencyContact,
    );
  }

  // Constructor para crear una niñera
  factory UserModel.nanny({
    required String id,
    required String name,
    required String email,
    String? phone,
    String? location,
    int? yearsOfExperience,
    double? hourlyRate,
    List<String>? certifications,
    List<String>? availableServices,
    bool? isVerified,
    String? dni,
    double? rating,
    int? completedJobs,
    String? bio,
    List<String>? languages,
    bool? isAvailable,
    String? bankAccount,
  }) {
    return UserModel(
      id: id,
      name: name,
      email: email,
      phone: phone,
      role: UserRole.nanny,
      location: location,
      yearsOfExperience: yearsOfExperience,
      hourlyRate: hourlyRate,
      certifications: certifications,
      availableServices: availableServices,
      isVerified: isVerified ?? false,
      dni: dni,
      rating: rating,
      completedJobs: completedJobs ?? 0,
      bio: bio,
      languages: languages,
      isAvailable: isAvailable ?? true,
      bankAccount: bankAccount,
    );
  }

  // Método para convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role.name,
      'location': location,
      'profileImageUrl': profileImageUrl,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      // Campos para padres
      'numberOfChildren': numberOfChildren,
      'childrenAges': childrenAges,
      'emergencyContact': emergencyContact,
      // Campos para niñeras
      'yearsOfExperience': yearsOfExperience,
      'hourlyRate': hourlyRate,
      'certifications': certifications,
      'availableServices': availableServices,
      'isVerified': isVerified,
      'dni': dni,
      'rating': rating,
      'completedJobs': completedJobs,
      'bio': bio,
      'languages': languages,
      'isAvailable': isAvailable,
      'bankAccount': bankAccount,
    };
  }

  // Factory para crear desde JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      role: UserRole.values.firstWhere((e) => e.name == json['role']),
      location: json['location'],
      profileImageUrl: json['profileImageUrl'],
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      // Campos para padres
      numberOfChildren: json['numberOfChildren'],
      childrenAges: json['childrenAges']?.cast<String>(),
      emergencyContact: json['emergencyContact'],
      // Campos para niñeras
      yearsOfExperience: json['yearsOfExperience'],
      hourlyRate: json['hourlyRate']?.toDouble(),
      certifications: json['certifications']?.cast<String>(),
      availableServices: json['availableServices']?.cast<String>(),
      isVerified: json['isVerified'],
      dni: json['dni'],
      rating: json['rating']?.toDouble(),
      completedJobs: json['completedJobs'],
      bio: json['bio'],
      languages: json['languages']?.cast<String>(),
      isAvailable: json['isAvailable'],
      bankAccount: json['bankAccount'],
    );
  }

  // Método para copiar con modificaciones
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    UserRole? role,
    String? location,
    String? profileImageUrl,
    DateTime? dateOfBirth,
    DateTime? createdAt,
    DateTime? updatedAt,
    // Campos para padres
    int? numberOfChildren,
    List<String>? childrenAges,
    String? emergencyContact,
    // Campos para niñeras
    int? yearsOfExperience,
    double? hourlyRate,
    List<String>? certifications,
    List<String>? availableServices,
    bool? isVerified,
    String? dni,
    double? rating,
    int? completedJobs,
    String? bio,
    List<String>? languages,
    bool? isAvailable,
    String? bankAccount,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      location: location ?? this.location,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
      // Campos para padres
      numberOfChildren: numberOfChildren ?? this.numberOfChildren,
      childrenAges: childrenAges ?? this.childrenAges,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      // Campos para niñeras
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      certifications: certifications ?? this.certifications,
      availableServices: availableServices ?? this.availableServices,
      isVerified: isVerified ?? this.isVerified,
      dni: dni ?? this.dni,
      rating: rating ?? this.rating,
      completedJobs: completedJobs ?? this.completedJobs,
      bio: bio ?? this.bio,
      languages: languages ?? this.languages,
      isAvailable: isAvailable ?? this.isAvailable,
      bankAccount: bankAccount ?? this.bankAccount,
    );
  }

  // Getters útiles
  bool get isParent => role == UserRole.parent;
  bool get isNanny => role == UserRole.nanny;

  String get displayName => name;

  String get roleDisplayName {
    switch (role) {
      case UserRole.parent:
        return 'Padre/Madre';
      case UserRole.nanny:
        return 'Niñera';
    }
  }

  // Validaciones
  bool get isProfileComplete {
    if (isParent) {
      return name.isNotEmpty &&
             email.isNotEmpty &&
             phone != null &&
             location != null;
    } else {
      return name.isNotEmpty &&
             email.isNotEmpty &&
             phone != null &&
             location != null &&
             yearsOfExperience != null &&
             hourlyRate != null &&
             dni != null;
    }
  }

  bool get canReceiveJobs {
    return isNanny &&
           isVerified == true &&
           isAvailable == true &&
           isProfileComplete;
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, role: ${role.name})';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
