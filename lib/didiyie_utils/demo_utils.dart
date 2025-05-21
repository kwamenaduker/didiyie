import 'package:didiyie/didiyie_models/food_model.dart';

// A utility class to help with demos
class DemoUtils {
  // Static counter to cycle through demo foods
  static int _demoCounter = 0;
  
  // Demo mode flag - default to true for easy demo
  static bool isDemoMode = true;
  
  // Store the last demo food generated for access by the result screen
  static Food? lastDemoFood;
  
  // Toggle demo mode
  static void toggleDemoMode() {
    isDemoMode = !isDemoMode;
    _demoCounter = 0; // Reset counter when toggling
  }
  
  // Get the next demo food in the cycle
  static Food getNextDemoFood() {
    final foods = [
      _createDemoFood('Fufu and Light Soup'),
      _createDemoFood('Waakye'),
      _createDemoFood('Jollof Rice'),
    ];
    
    // Get food, then increment counter
    final food = foods[_demoCounter % foods.length];
    _demoCounter++;
    return food;
  }
  
  // Create a demo food with predefined values
  static Food _createDemoFood(String name) {
    // Set specific values based on the food type
    String id = name.toLowerCase().replaceAll(' ', '_');
    String category = _getCategoryForFood(name);
    String image = _getImageForFood(name);
    int calories = _getCaloriesForFood(name);
    double protein = _getProteinForFood(name);
    double carbs = _getCarbsForFood(name);
    double fat = _getFatForFood(name);
    String description = _getDescriptionForFood(name);
    String culturalContext = _getCulturalContextForFood(name);
    List<String> healthBenefits = _getHealthBenefitsForFood(name);
    List<String> similarFoods = _getSimilarFoodsForFood(name);
    
    return Food(
      id: id,
      name: name,
      category: category,
      calories: calories,
      carbs: carbs,
      protein: protein,
      fat: fat,
      image: image,
      description: description,
      culturalContext: culturalContext,
      healthBenefits: healthBenefits,
      similarFoods: similarFoods,
      confidence: 0.95, // High confidence for demo
    );
  }
  
  // Helper methods to get realistic values for each food
  static String _getCategoryForFood(String name) {
    if (name.contains('Jollof')) return 'Rice Dishes';
    if (name.contains('Fufu')) return 'Starchy Staples';
    if (name.contains('Waakye')) return 'Rice Dishes';
    return 'Ghanaian Food';
  }
  
  static String _getImageForFood(String name) {
    if (name.contains('Jollof')) return 'assets/images/jollof.jpg';
    if (name.contains('Fufu')) return 'assets/images/fufu.jpg';
    if (name.contains('Waakye')) return 'assets/images/waakye.jpg';
    return 'assets/images/placeholder.jpg';
  }
  
  static int _getCaloriesForFood(String name) {
    if (name.contains('Jollof')) return 350;
    if (name.contains('Fufu')) return 280;
    if (name.contains('Waakye')) return 320;
    return 300;
  }
  
  static double _getProteinForFood(String name) {
    if (name.contains('Jollof')) return 8.5;
    if (name.contains('Fufu')) return 3.2;
    if (name.contains('Waakye')) return 12.0;
    return 8.0;
  }
  
  static double _getCarbsForFood(String name) {
    if (name.contains('Jollof')) return 62.0;
    if (name.contains('Fufu')) return 70.5;
    if (name.contains('Waakye')) return 58.0;
    return 60.0;
  }
  
  static double _getFatForFood(String name) {
    if (name.contains('Jollof')) return 12.0;
    if (name.contains('Fufu')) return 0.8;
    if (name.contains('Waakye')) return 6.5;
    return 6.0;
  }
  
  static String _getDescriptionForFood(String name) {
    if (name.contains('Jollof')) {
      return 'A flavorful one-pot rice dish cooked with tomatoes, peppers, and aromatic spices. Jollof Rice is a staple at celebrations and gatherings throughout Ghana and West Africa.';
    }
    if (name.contains('Fufu')) {
      return 'A soft, dough-like staple food made from boiled and pounded cassava or plantains. Served with Light Soup, a spicy broth often made with goat meat, fish or chicken, seasoned with local herbs and spices.';
    }
    if (name.contains('Waakye')) {
      return 'A traditional Ghanaian dish of rice and beans cooked together with dried millet leaves, giving it a characteristic red-brown color. Usually served with stew, spaghetti, gari, and protein.';
    }
    return 'A traditional Ghanaian dish loved for its rich flavors and cultural significance.';
  }
  
  static String _getCulturalContextForFood(String name) {
    if (name.contains('Jollof')) {
      return 'Jollof Rice is a symbol of celebration in Ghana and throughout West Africa. It\'s often served at parties, weddings, and important gatherings. There\'s a friendly rivalry between countries like Ghana, Nigeria, and Senegal about which country makes the best version.';
    }
    if (name.contains('Fufu')) {
      return 'Fufu is a staple food throughout Ghana and parts of West Africa. Traditionally, it\'s pounded using a wooden mortar and pestle, often by two people working in rhythm. Eating fufu involves tearing a small piece with your right hand, making an indentation, and using it to scoop up soup.';
    }
    if (name.contains('Waakye')) {
      return 'Waakye originated in Northern Ghana but has become popular throughout the country, especially as a breakfast or lunch meal. It\'s commonly sold by street vendors and in small restaurants, and each region has its own variation of accompaniments.';
    }
    return 'This food has deep cultural roots in Ghanaian cuisine and is enjoyed by many across the country.';
  }
  
  static List<String> _getHealthBenefitsForFood(String name) {
    if (name.contains('Jollof')) {
      return [
        'Rich in carbohydrates for energy',
        'Contains lycopene from tomatoes, which has antioxidant properties',
        'Provides essential minerals depending on the vegetables added',
        'Good source of plant proteins when combined with beans'
      ];
    }
    if (name.contains('Fufu')) {
      return [
        'High in carbohydrates providing sustained energy',
        'Light Soup contains vegetables with vitamins and minerals',
        'Contains protein from meat or fish in the soup',
        'Low in fat when served with fish or lean meat'
      ];
    }
    if (name.contains('Waakye')) {
      return [
        'Combines complete proteins from rice and beans',
        'Good source of dietary fiber',
        'Contains essential minerals like iron and zinc',
        'Provides complex carbohydrates for sustained energy'
      ];
    }
    return [
      'Good source of energy',
      'Contains essential nutrients',
      'Part of traditional balanced diet'
    ];
  }
  
  static List<String> _getSimilarFoodsForFood(String name) {
    if (name.contains('Jollof')) {
      return ['Fried Rice', 'Waakye', 'Thieboudienne (Senegalese Jollof)'];
    }
    if (name.contains('Fufu')) {
      return ['Banku', 'Tuo Zaafi', 'Kenkey', 'Akple'];
    }
    if (name.contains('Waakye')) {
      return ['Jollof Rice', 'Red-Red', 'Gari and Beans'];
    }
    return ['Jollof Rice', 'Fufu and Light Soup', 'Waakye'];
  }
}
