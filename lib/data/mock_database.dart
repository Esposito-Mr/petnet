import '../models/category_model.dart';
import '../models/ngo_model.dart';
import '../models/pet_model.dart';
import '../models/post_model.dart';
import '../models/product_model.dart';
import '../models/user_model.dart';

// Model for service filter chips
class ServiceFilter {
  final String id;
  final String name;

  const ServiceFilter({required this.id, required this.name});
}

class MockDatabaseService {
  // --- MOCK USERS ---
  final _fulana = const User(
    id: 'user_01',
    name: 'Fulana Ciclana',
    profileImageUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
  );
  final _ciclana = const User(
    id: 'user_02',
    name: 'Ciclana Ciclana',
    profileImageUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=464&q=80',
  );
  final _ciclano = const User(
    id: 'user_03',
    name: 'Ciclano Fulano',
    profileImageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
  );

  // --- MOCK POSTS ---
  late final List<Post> _posts;

  // --- MOCK PETS ---
  final List<Pet> _pets = [
    const Pet( id: 'pet_01', name: 'Abely', imageUrl: 'https://images.unsplash.com/photo-1537151625747-768eb6cf92b2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80', associationName: 'Associação de Proteção Meu Amigo Focinho', location: 'Moca, SÃO PAULO, SP', gender: 'female', ),
    const Pet( id: 'pet_02', name: 'Amora', imageUrl: 'https://images.unsplash.com/photo-1598133894008-61f7fdb84a74?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80', associationName: 'Associação de Proteção Meu Amigo Focinho', location: 'Miguel Sutil, CUIABÁ, MT', gender: 'female', ),
    const Pet( id: 'pet_03', name: 'Bella', imageUrl: 'https://images.unsplash.com/photo-1596854407944-bf87f6fdd49e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=580&q=80', associationName: 'Associação de Proteção Meu Amigo Focinho', location: 'Aracaju, ARACAJU, SE', gender: 'female', ),
    const Pet( id: 'pet_04', name: 'Billy', imageUrl: 'https://images.unsplash.com/photo-1518020382113-a7e8fc38eac9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=417&q=80', associationName: 'Associação de Proteção Meu Amigo Focinho', location: 'Rio Claro, RIO CLARO, SP', gender: 'male', ),
    const Pet( id: 'pet_05', name: 'Max', imageUrl: 'https://images.unsplash.com/photo-1574144611937-09059ae0024b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=580&q=80', associationName: 'ONG Patinhas', location: 'Centro, SÃO PAULO, SP', gender: 'male', ),
    const Pet( id: 'pet_06', name: 'Buddy', imageUrl: 'https://images.unsplash.com/photo-1552053831-71594a27632d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=388&q=80', associationName: 'ONG Patinhas', location: 'Tatuapé, SÃO PAULO, SP', gender: 'male', ),
  ];

  // --- MOCK PRODUCTS ---
  final List<Product> _products = [
    const Product(id: 'prod_01', name: 'Coleira personalizada', brand: 'Petz', price: 49.99, imageUrl: 'https://via.placeholder.com/150/FF8C00/FFFFFF?Text=Coleira'),
    const Product(id: 'prod_02', name: 'Petisco para cães Ossinho Delicioso', brand: 'Petz', price: 79.99, imageUrl: 'https://via.placeholder.com/150/4682B4/FFFFFF?Text=Petisco'),
    const Product(id: 'prod_03', name: 'Pote de ração Inox Antiderrapante', brand: 'Petz', price: 25.90, imageUrl: 'https://via.placeholder.com/150/32CD32/FFFFFF?Text=Pote'),
    const Product(id: 'prod_04', name: 'Ração Gourmet Premium Sabor Frango', brand: 'Petz', price: 40.90, imageUrl: 'https://via.placeholder.com/150/DC143C/FFFFFF?Text=Racao'),
  ];

  // --- MOCK CATEGORIES ---
   final List<Category> _dogCategories = [
    const Category(id: 'cat_d_01', name: 'Anti-pulgas', imageUrl: 'https://via.placeholder.com/80/87CEEB/FFFFFF?Text=AntiPulga'),
    const Category(id: 'cat_d_02', name: 'Escova', imageUrl: 'https://via.placeholder.com/80/FFA07A/FFFFFF?Text=Escova'),
    const Category(id: 'cat_d_03', name: 'Limpeza', imageUrl: 'https://via.placeholder.com/80/98FB98/FFFFFF?Text=Limpeza'),
    const Category(id: 'cat_d_04', name: 'Coleiras', imageUrl: 'https://via.placeholder.com/80/FFD700/FFFFFF?Text=Coleira'),
    const Category(id: 'cat_d_05', name: 'Roupinhas', imageUrl: 'https://via.placeholder.com/80/FF69B4/FFFFFF?Text=Roupa'),
  ];
   final List<Category> _catCategories = [
    const Category(id: 'cat_c_01', name: 'Arranhadores', imageUrl: 'https://via.placeholder.com/80/BA55D3/FFFFFF?Text=Arranhador'),
    const Category(id: 'cat_c_02', name: 'Brinquedos', imageUrl: 'https://via.placeholder.com/80/7FFFD4/FFFFFF?Text=Brinquedo'),
    const Category(id: 'cat_c_03', name: 'Caixa de areia', imageUrl: 'https://via.placeholder.com/80/D2691E/FFFFFF?Text=Areia'),
    const Category(id: 'cat_c_04', name: 'Petiscos', imageUrl: 'https://via.placeholder.com/80/6495ED/FFFFFF?Text=Petisco'),
    const Category(id: 'cat_c_05', name: 'Caminhas', imageUrl: 'https://via.placeholder.com/80/DC143C/FFFFFF?Text=Cama'),
  ];

   // --- MOCK SERVICE FILTERS ---
   final List<ServiceFilter> _serviceFilters = [
     const ServiceFilter(id: 'sf_01', name: 'Banho e tosa'),
     const ServiceFilter(id: 'sf_02', name: 'Clínicas veterinárias'),
     const ServiceFilter(id: 'sf_03', name: 'Adestramento'),
     const ServiceFilter(id: 'sf_04', name: 'Pet Sitter'),
     const ServiceFilter(id: 'sf_05', name: 'Pet Shop'),
     const ServiceFilter(id: 'sf_06', name: 'Creche Pet'),
     const ServiceFilter(id: 'sf_07', name: 'Transporte'),
   ];

   // --- MOCK NGOs ---
   final List<NGO> _ngos = [
     NGO(id: 'ngo_01', name: 'Aban associação dos amigos', logoUrl: 'https://via.placeholder.com/100/FFD700/000000?Text=NGO1', lastActionTimestamp: DateTime.now().subtract(const Duration(hours: 2))),
     NGO(id: 'ngo_02', name: 'Vira Lata Vira Amigo', logoUrl: 'https://via.placeholder.com/100/ADFF2F/000000?Text=NGO2', lastActionTimestamp: DateTime.now().subtract(const Duration(minutes: 30))),
     NGO(id: 'ngo_03', name: 'Ong Amaio', logoUrl: 'https://via.placeholder.com/100/FF69B4/000000?Text=NGO3', lastActionTimestamp: DateTime.now().subtract(const Duration(days: 1))),
     NGO(id: 'ngo_04', name: 'Associação Focinho Feliz', logoUrl: 'https://via.placeholder.com/100/87CEEB/000000?Text=NGO4', lastActionTimestamp: DateTime.now().subtract(const Duration(hours: 5))),
     NGO(id: 'ngo_05', name: 'Projeto Patinhas Carentes', logoUrl: 'https://via.placeholder.com/100/FFA07A/000000?Text=NGO5', lastActionTimestamp: DateTime.now().subtract(const Duration(minutes: 15))),
     NGO(id: 'ngo_06', name: 'Amigos de Quatro Patas', logoUrl: 'https://via.placeholder.com/100/98FB98/000000?Text=NGO6', lastActionTimestamp: DateTime.now().subtract(const Duration(days: 3))),
     NGO(id: 'ngo_07', name: 'Instituto Cão Amigo', logoUrl: 'https://via.placeholder.com/100/DDA0DD/000000?Text=NGO7', lastActionTimestamp: DateTime.now().subtract(const Duration(hours: 1))),
     NGO(id: 'ngo_08', name: 'Protetores Independentes', logoUrl: 'https://via.placeholder.com/100/EEE8AA/000000?Text=NGO8', lastActionTimestamp: DateTime.now().subtract(const Duration(hours: 8))),
     NGO(id: 'ngo_09', name: 'Grupo Salva Pet', logoUrl: 'https://via.placeholder.com/100/B0C4DE/000000?Text=NGO9', lastActionTimestamp: DateTime.now().subtract(const Duration(minutes: 5))),
   ];


  MockDatabaseService() {
    // Initialize Posts
    _posts = [
      Post( id: 'post_01', author: _fulana, text: 'Dia de levar a princesa para passear!', imageUrl: 'https://images.unsplash.com/photo-1548681528-6a5c45b66b42?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80', timestamp: DateTime.now().subtract(const Duration(minutes: 6)), ),
      Post( id: 'post_02', author: _ciclana, text: 'Bom dia, rede! Alguma recomendação de petsitters na região de São Paulo?', timestamp: DateTime.now().subtract(const Duration(minutes: 11)), ),
      Post( id: 'post_03', author: _ciclano, text: 'Hoje experimentei passear com o Doug perto da estação Vila Mendes e foi ótimo. Tinha bastante espaço, recomendo.', imageUrl: 'https://images.unsplash.com/photo-1537151608828-ea2b11777ee8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=394&q=80', timestamp: DateTime.now().subtract(const Duration(minutes: 18)), ),
    ];
  }

  // --- PUBLIC APIs ---
  Future<List<Post>> getFeedPosts() async { await Future.delayed(const Duration(seconds: 1)); return _posts; }
  Future<List<Pet>> getAdoptablePets() async { await Future.delayed(const Duration(milliseconds: 800)); return _pets; }
  Future<List<Product>> getRecommendedProducts() async { await Future.delayed(const Duration(milliseconds: 600)); return _products; }
  Future<List<Category>> getDogCategories() async { await Future.delayed(const Duration(milliseconds: 300)); return _dogCategories; }
  Future<List<Category>> getCatCategories() async { await Future.delayed(const Duration(milliseconds: 300)); return _catCategories; }
  Future<List<ServiceFilter>> getServiceFilters() async { await Future.delayed(const Duration(milliseconds: 200)); return _serviceFilters; }
  Future<List<NGO>> getNGOsSortedByActivity() async {
    await Future.delayed(const Duration(milliseconds: 700));
    _ngos.sort((a, b) => b.lastActionTimestamp.compareTo(a.lastActionTimestamp));
    return _ngos;
  }
}