import 'dart:io';
import 'dart:math';
import '../lib/error.dart';
import '../lib/magazine.dart';
import '../lib/user.dart';
import '../lib/book.dart';
import '../lib/library.dart';

void main() async {
  final Library library = Library();

  // Cargar datos iniciales
  try {
    print('Iniciando carga de datos...');
    await library.loadInitialData();
    library.showCataloge();
    print('Datos cargados exitosamente.\n');
  } catch (err) {
    print('Error al cargar datos: $err');
  }

  String optionMenu;

  do {
    // Mostrar menú
    menu();

    // Leer opción del usuario
    optionMenu = stdin.readLineSync()?.trim() ?? '';

    // Procesar opción
    switch (optionMenu) {
      case '1':
        // Registrar usuario
        print('REGISTRAR NUEVO USUARIO\n');
        print('Nombre: ');
        final String name = stdin.readLineSync()?.trim() ?? '';
        if (name.isNotEmpty) {
          library.addUser(User(name: name, id: getUserID()));
          print('\nUsuario registrado con éxito.\n');
        } else {
          print('\nError: El nombre no puede estar vacío.\n');
        }
        break;

      case '2':
        // Buscar Revista por titulo
        try {
          print('\nBUSCAR REVISTA\n');
          print('\nIngrese el título a buscar: ');
          // Buscar revista
          final String title = stdin.readLineSync()?.trim() ?? '';
          Magazine? magazine = library.findMagazineByTitle(title);
          // Validar revista
          magazineValidate(magazine);
          print('\nResultado de búsqueda:');
          // Mostrar revistas 
          magazine!.showInfo();
        } on UserException catch (err) {
          print(err);
        } on ObjectException catch (err) {
          print(err);
        }
        break;

      case '3':
        // Buscar Libro por título
        try {
          print('BUSCAR BOOK\n');
          print('Ingrese el título a buscar: ');
          final String title = stdin.readLineSync()?.trim() ?? '';
          Book? book = library.findBookByTitle(title);
          bookValidate(book);
          print('\nResultado de búsqueda:');
          book!.showInfo();
        } on UserException catch (err) {
          print(err);
        } on ObjectException catch (err) {
          print(err);
        }
        break;

      case '4':
        // Leer revista
        try {
          print('LEER REVISTA\n');
          // Buscar usuario
          print('Usuario a prestar: ');
          final String name = stdin.readLineSync()?.trim() ?? '';
          User? user = library.findUserByName(name);
          // Buscar revista
          print('Título de la  revista a leer: ');
          final String title = stdin.readLineSync()?.trim() ?? '';
          Magazine? magazine = library.findMagazineByTitle(title);
          // Validar usuario y revista
          userValidate(user);
          magazineValidate(magazine);
          // Leer revista
          Future.delayed(Duration(seconds: 2));
          library.readUserMegazine(user!, magazine!);
        } on UserException catch (err) {
          print(err);
        } on ObjectException catch (err) {
          print(err);
        }
        break;

      case '6':
        // Prestar libro
        try {
          print('PRESTAR\n');
          // // Buscar usuario
          print('Usuario a prestar: ');
          final String name = stdin.readLineSync()?.trim() ?? '';
          User? user = library.findUserByName(name);
          // Buscar libro
          print('Título del libro a leer: ');
          final String title = stdin.readLineSync()?.trim() ?? '';
          Book? book = library.findBookByTitle(title);
          // validar usuario y libro
          userValidate(user);
          bookValidate(book);
          // Prestar libro
          Future.delayed(Duration(seconds: 2));
          library.lendBookUser(user!, book!);
        } on UserException catch (err) {
          print(err);
        } on ObjectException catch (err) {
          print(err);
        }
        break;

      case '7':
        // Devolver Libro
        try {
          print('\nDEVOLVER LIBRO');
          // // Buscar usuario
          print('Usuario que va a devolver : ');
          final String name = stdin.readLineSync()?.trim() ?? '';
          User? user = library.findUserByName(name);
          // Buscar libro
          print('Título del libro a devolver: ');
          final String title = stdin.readLineSync()?.trim() ?? '';
          Book? book = library.findBookByTitle(title);
          // validar usuario y libro
          userValidate(user);
          bookValidate(book);
          // Devolver libro
          Future.delayed(Duration(seconds: 2));
          library.returnUserBook(user!, book!);
        } on UserException catch (err) {
          print(err);
        } on ObjectException catch (err) {
          print(err);
        }
        break;

      case '5':
        // Devolver Revista
        try {
          print('DEVOLVER REVISTA\n');
          // Buscar usuario
          print('Usuario que va a devolver : ');
          final String name = stdin.readLineSync()?.trim() ?? '';
          User? user = library.findUserByName(name);
          // Buscar revista
          print('Título de la revista a devolver: ');
          final String title = stdin.readLineSync()?.trim() ?? '';
          Magazine? magazine = library.findMagazineByTitle(title);
          // Validar usuario y revista
          userValidate(user);
          magazineValidate(magazine);
          // devolver revista
          Future.delayed(Duration(seconds: 2));
          library.returnUserMagazine(user!, magazine!);
        } on UserException catch (err) {
          print(err);
        } on ObjectException catch (err) {
          print(err);
        }
        break;

      case '8':
        // Mostrar catálogo completo
        print('CATÁLOGO COMPLETO\n');
        library.showCataloge();
        break;

      case '9':
        // Mostrar historial de usuarios
        print('USUARIOS REGISTRADOS\n');
        library.showUsers();
        break;

      case '10':
        // Mostrar historial de usuario
        try {
          print('MOSTRAR HISTORIAL DE USUARIO\n');
          // Buscar usuario
          print('Nombre de usuario: ');
          final String name = stdin.readLineSync()?.trim() ?? '';
          User? user = library.findUserByName(name);
          // Validar usuario
          userValidate(user);
          // mostrar historial
          user!.showHistorial();
        } on UserException catch (err) {
          print(err);
        }
        break;

      case '11':
        // Salir
        print('Saliendo del sistema...\n');
        break;

      default:
        print('\nOpción no válida. Por favor intente nuevamente.\n');
    }
  } while (optionMenu != '11');
}

void menu() {
  print('''
    ++++++++++++  MENÚ PRINCIPAL  +++++++++++++++++
    (1). Registrar usuario.
    (2). Buscar Revista por Título.
    (3). Buscar Libro por Título.
    (4). Leer Revista. 
    (5). Devolver Revista.
    (6). Prestrar Libro.
    (7). Devolver Libro. 
    (8). Mostrar Catálogo completo.
    (9). Mostrar usuarios registrados.
    (10). Mostrar historial de usuario.
    (11). Salir.
    
    Ingrese una opción: ''');
}

String getUserID() {
  return (Random.secure().hashCode / 100000).round().toString();
}

void userValidate(User? user) {
  if (user == null) {
    throw UserException('Usuario no encontrado');
  }
}

void bookValidate(Book? book) {
  if (book == null) {
    throw ObjectException('Libro no encontado');
  }
}

void magazineValidate(Magazine? magazine) {
  if (magazine == null) {
    throw ObjectException('Revista no encontrada');
  }
}
