import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/custom_button.dart';
import '../../models/user_model.dart';
import '../../core/services/auth_service.dart';
import '../../core/theme/app_theme.dart';
import '../parent/home_screen.dart';
import '../nanny/nanny_home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscure = true;
  UserRole _selectedRole = UserRole.parent;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 🚀 Logo animado
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOutBack,
                      width: 80,
                      height: 80,
                      child: Center(
                        child: Image.asset(
                          'assets/images/logo_kc.png',
                          width: 60,
                          height: 60,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 👋 Títulos
                    Text(
                      "Bienvenido a KidyCare",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Conéctate con niñeras de confianza",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Selector de tipo de usuario
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _selectedRole = UserRole.parent),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: _selectedRole == UserRole.parent
                                      ? theme.colorScheme.primary
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.family_restroom,
                                      size: 18,
                                      color: _selectedRole == UserRole.parent
                                          ? Colors.white
                                          : theme.colorScheme.onSurface.withValues(alpha: 0.6),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Padre/Madre',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: _selectedRole == UserRole.parent
                                            ? Colors.white
                                            : theme.colorScheme.onSurface.withValues(alpha: 0.6),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _selectedRole = UserRole.nanny),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: _selectedRole == UserRole.nanny
                                      ? theme.colorScheme.secondary
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.child_care,
                                      size: 18,
                                      color: _selectedRole == UserRole.nanny
                                          ? Colors.white
                                          : theme.colorScheme.onSurface.withValues(alpha: 0.6),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Niñera',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: _selectedRole == UserRole.nanny
                                            ? Colors.white
                                            : theme.colorScheme.onSurface.withValues(alpha: 0.6),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // 📧 Email
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Correo electrónico",
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa tu correo';
                        }
                        if (!value.contains('@')) {
                          return 'Ingresa un correo válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                    // 🔒 Password con mostrar/ocultar
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        labelText: "Contraseña",
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa una contraseña';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // 🔘 Botón login centrado
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: CustomButton(
                          text: _isLoading ? "Iniciando sesión..." : "Ingresar",
                          onPressed: _isLoading ? null : _handleLogin,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Separador con texto
                    Row(
                      children: [
                        Expanded(child: Divider(color: AppTheme.azulMarino.withValues(alpha: 0.3))),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "O logéate con",
                            style: GoogleFonts.poppins(
                              color: AppTheme.azulMarino.withValues(alpha: 0.6),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: AppTheme.azulMarino.withValues(alpha: 0.3))),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Icono de Google centrado
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          // Implementar autenticación con Google aquí
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Login con Google en desarrollo"),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.azulMarino.withValues(alpha: 0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/icons/google_icon.png',
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 📝 Ir a registro
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "¿No tienes cuenta? Regístrate",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final theme = Theme.of(context); // Agregar esta línea para obtener el theme

    try {
      final success = await AuthService.login(
        _emailController.text,
        _passwordController.text,
        _selectedRole,
      );

      if (success && mounted) {
        // Navegar según el rol del usuario autenticado
        if (AuthService.isParent) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else if (AuthService.isNanny) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const NannyHomeScreen()),
          );
        }
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Credenciales incorrectas'),
            backgroundColor: theme.colorScheme.secondary,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al iniciar sesión: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
