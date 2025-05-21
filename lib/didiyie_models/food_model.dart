class Food {
  final String id;
  final String name;
  final String category;
  final int calories;
  final double carbs;
  final double protein;
  final double fat;
  final String image;
  final String description;
  final String culturalContext;
  final List<String> healthBenefits;
  final List<String> similarFoods;
  final double confidence; // Recognition confidence

  Food({
    required this.id,
    required this.name,
    required this.category,
    required this.calories,
    required this.carbs,
    required this.protein,
    required this.fat,
    required this.image,
    required this.description,
    required this.culturalContext,
    required this.healthBenefits,
    required this.similarFoods,
    this.confidence = 1.0,
  });

  // Constructor for creating a food object from a JSON map
  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      calories: json['calories'],
      carbs: json['carbs'],
      protein: json['protein'],
      fat: json['fat'],
      image: json['image'],
      description: json['description'],
      culturalContext: json['culturalContext'],
      healthBenefits: List<String>.from(json['healthBenefits']),
      similarFoods: List<String>.from(json['similarFoods']),
      confidence: json['confidence'] ?? 1.0,
    );
  }

  // Convert a food object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'calories': calories,
      'carbs': carbs,
      'protein': protein,
      'fat': fat,
      'image': image,
      'description': description,
      'culturalContext': culturalContext,
      'healthBenefits': healthBenefits,
      'similarFoods': similarFoods,
      'confidence': confidence,
    };
  }
}

// Sample Ghanaian foods data
final List<Map<String, dynamic>> ghanaianFoods = [
  // BREAKFAST FOODS
  {
    'id': 'koko_koose',
    'name': 'Koko and Koose',
    'category': 'Breakfast',
    'calories': 320,
    'carbs': 48.5,
    'protein': 9.8,
    'fat': 7.3,
    'image': 'assets/images/hausa_koko.jpg',
    'description': 'Millet porridge served with fried bean balls seasoned with spices.',
    'culturalContext': 'A popular breakfast combination in Ghana, especially in the northern regions. Koko is a smooth porridge while koose (bean balls) adds protein to the meal.',
    'healthBenefits': [
      'Good source of plant-based protein from the beans',
      'Provides complex carbohydrates for sustained energy',
      'Rich in dietary fiber promoting digestive health',
      'Contains various minerals including iron and magnesium'
    ],
    'similarFoods': ['Hausa Koko', 'Tom Brown', 'Oats Porridge']
  },
  {
    'id': 'chibom',
    'name': 'Kyebom (Bread and Egg)',
    'category': 'Breakfast',
    'calories': 380,
    'carbs': 45.0,
    'protein': 15.3,
    'fat': 12.5,
    'image': 'assets/images/kyebom.jpg',
    'description': 'Bread served with fried eggs, often accompanied by a side of fresh vegetables.',
    'culturalContext': 'A simple yet hearty breakfast option popular in urban areas of Ghana, influenced by colonial breakfast traditions but adapted to local preferences.',
    'healthBenefits': [
      'Eggs provide high-quality protein and essential amino acids',
      'Contains choline which is important for brain health',
      'Good source of B vitamins from the bread',
      'When served with vegetables, adds vitamins and fiber'
    ],
    'similarFoods': ['Tea and Bread', 'Fried Egg Sandwich', 'Toast and Omelette']
  },
  {
    'id': 'tea_bread',
    'name': 'Tea and Bread',
    'category': 'Breakfast',
    'calories': 250,
    'carbs': 42.0,
    'protein': 6.0,
    'fat': 5.5,
    'image': 'assets/images/bread_tea.jpg',
    'description': 'Sweet milky tea served with soft Ghanaian bread, sometimes accompanied by omelette or boiled eggs.',
    'culturalContext': 'A breakfast option that reflects colonial influence yet has been adapted with local bread varieties and preparation methods to create a distinctly Ghanaian breakfast experience.',
    'healthBenefits': [
      'Provides quick energy to start the day',
      'Milk in tea offers calcium and vitamin D',
      'Contains antioxidants from the tea',
      'When served with eggs, increases protein content'
    ],
    'similarFoods': ['Chibom', 'Bread and Butter', 'Coffee and Bread']
  },
  
  {
    'id': 'jollof',
    'name': 'Jollof Rice',
    'category': 'Rice Dishes',
    'calories': 350,
    'carbs': 65.3,
    'protein': 7.5,
    'fat': 8.2,
    'image': 'assets/images/jollof.jpg',
    'description': 'A flavorful one-pot rice dish cooked with tomatoes, spices, and vegetables.',
    'culturalContext': 'Jollof rice is a West African dish popular in Ghana and Nigeria. It\'s often served at celebrations and gatherings and has become a symbol of West African cuisine. In Ghana, it\'s typically made with long grain rice, tomatoes, onions, and various spices.',
    'healthBenefits': [
      'Rich in lycopene from tomatoes, which has antioxidant properties',
      'Good source of carbohydrates for energy',
      'Contains various vitamins from the vegetable ingredients',
      'Can be made healthier by adding more vegetables or using brown rice'
    ],
    'similarFoods': ['Waakye', 'Fried Rice', 'Plain Rice with Stew']
  },
  {
    'id': 'fufu',
    'name': 'Fufu with Light Soup',
    'category': 'Starchy Staples',
    'calories': 320,
    'carbs': 70.5,
    'protein': 5.2,
    'fat': 1.3,
    'image': 'assets/images/fufu.jpg',
    'description': 'A starchy dough made from cassava and plantains, served with light soup containing meat or fish.',
    'culturalContext': 'Fufu is a traditional Ghanaian staple food typically made by pounding boiled cassava and plantains together. It\'s traditionally eaten with the fingers by taking a small piece, forming it into a ball, and dipping it into accompanying soups or sauces.',
    'healthBenefits': [
      'Good source of complex carbohydrates for sustained energy',
      'Contains resistant starch which may benefit gut health',
      'Light soup contains vegetables and protein that provide essential nutrients',
      'Moderate in calories despite being filling'
    ],
    'similarFoods': ['Banku', 'Kokonte', 'Tuo Zaafi']
  },
  {
    'id': 'waakye',
    'name': 'Waakye',
    'category': 'Rice and Bean Dishes',
    'calories': 380,
    'carbs': 72.0,
    'protein': 12.8,
    'fat': 3.5,
    'image': 'assets/images/waakye.jpg',
    'description': 'Rice and beans cooked together with millet leaves or sorghum leaves, giving it a characteristic reddish-brown color.',
    'culturalContext': 'Waakye is a popular Ghanaian street food originating from the northern regions of Ghana. It\'s often served with various accompaniments like shito (hot pepper sauce), spaghetti, gari (cassava flakes), fried plantains, and protein sources like meat or eggs.',
    'healthBenefits': [
      'High in plant-based protein from the beans',
      'Good source of fiber which promotes digestive health',
      'Contains complex carbohydrates for sustained energy',
      'The combination of rice and beans provides complementary proteins'
    ],
    'similarFoods': ['Jollof Rice', 'Red Red', 'Rice and Beans']
  },
  {
    'id': 'kenkey',
    'name': 'Kenkey with Fish',
    'category': 'Fermented Dishes',
    'calories': 290,
    'carbs': 58.0,
    'protein': 15.3,
    'fat': 4.7,
    'image': 'assets/images/kenkey.jpg',
    'description': 'Fermented corn dough wrapped in corn husks or banana leaves and steamed, typically served with fried fish and pepper sauce.',
    'culturalContext': 'Kenkey is a staple food among the Ga people of southern Ghana. The fermentation process gives it a unique sour taste. There are several variations including Ga kenkey (made with white corn) and Fanti kenkey (partially cooked before wrapping and has a more acidic taste).',
    'healthBenefits': [
      'The fermentation process increases vitamin B content and improves digestibility',
      'Good source of probiotics that support gut health',
      'When served with fish, provides essential omega-3 fatty acids',
      'The fermentation reduces anti-nutrients making minerals more bioavailable'
    ],
    'similarFoods': ['Banku', 'Akple', 'Fanti Kenkey']
  },
  {
    'id': 'banku',
    'name': 'Banku with Okro Soup',
    'category': 'Fermented Dishes',
    'calories': 300,
    'carbs': 64.5,
    'protein': 6.8,
    'fat': 2.9,
    'image': 'assets/images/banku.jpg',
    'description': 'Fermented corn and cassava dough cooked into a smooth, whitish paste, typically served with okra soup, grilled tilapia, or pepper sauce.',
    'culturalContext': 'Banku is a popular dish among the Ewe, Ga, and Fanti tribes of Ghana. It\'s traditionally eaten with the fingers by taking a small piece, forming it into a ball, and dipping it into accompanying soups or sauces. The fermentation gives it a distinct sour flavor.',
    'healthBenefits': [
      'The fermentation process enhances nutritional value and digestibility',
      'Contains probiotics that promote gut health',
      'Okro soup contains vegetables rich in vitamins and minerals',
      'Moderate in calories while being filling and satisfying'
    ],
    'similarFoods': ['Kenkey', 'Akple', 'Fufu']
  },
  {
    'id': 'redred',
    'name': 'Red Red',
    'category': 'Bean Dishes',
    'calories': 320,
    'carbs': 55.0,
    'protein': 18.5,
    'fat': 6.2,
    'image': 'assets/images/redred.jpg',
    'description': 'A bean stew made with black-eyed peas, palm oil, and spices, typically served with fried plantains (kelewele).',
    'culturalContext': 'Red Red gets its name from the reddish color imparted by palm oil and tomatoes. It\'s a nutritious everyday dish in Ghana, especially popular as a protein source for those who don\'t eat meat. The combination of beans and plantains creates a balanced meal important in Ghanaian cuisine.',
    'healthBenefits': [
      'High in plant protein from black-eyed peas',
      'Rich in fiber that promotes digestive health',
      'Contains iron and other nutrients from the beans',
      'Plantains provide potassium and vitamins A and C'
    ],
    'similarFoods': ['Waakye', 'Gari and Beans', 'Beans Stew']
  },
  {
    'id': 'kelewele',
    'name': 'Kelewele',
    'category': 'Snacks',
    'calories': 280,
    'carbs': 45.0,
    'protein': 2.3,
    'fat': 10.8,
    'image': 'assets/images/kelewele.jpg',
    'description': 'Spicy fried plantains seasoned with ginger, garlic, and other spices, often served as a snack or side dish.',
    'culturalContext': 'Kelewele is a popular Ghanaian street food and snack. It\'s known for its distinct spicy flavor profile from ginger, chili, and other spices. It\'s often sold by street vendors in the evening and eaten alone as a snack or as an accompaniment to peanuts, beans, or rice dishes.',
    'healthBenefits': [
      'Plantains are good sources of potassium, vitamins A, B6, and C',
      'Contains ginger which has anti-inflammatory properties',
      'Provides quick energy from natural sugars in ripe plantains',
      'The spices used have various health benefits, including improved digestion'
    ],
    'similarFoods': ['Tatale', 'Fried Plantains', 'Plantain Chips']
  },
  {
    'id': 'ampesi',
    'name': 'Ampesi',
    'category': 'Starchy Staples',
    'calories': 270,
    'carbs': 60.0,
    'protein': 4.8,
    'fat': 1.0,
    'image': 'assets/images/ampesi.jpg',
    'description': 'Boiled yam, plantain, or cocoyam served with a vegetable stew or garden egg sauce. A simple yet satisfying dish common in many Ghanaian homes.',
    'culturalContext': 'Ampesi is a staple in Ghanaian cuisine that showcases the versatility of root vegetables. It\'s often prepared for ordinary meals and is beloved for its simplicity and heartiness. The dish demonstrates the Ghanaian appreciation for incorporating locally available crops into everyday meals.',
    'healthBenefits': [
      'Rich in complex carbohydrates that provide sustained energy',
      'Good source of potassium, especially when made with plantains',
      'Low in fat and can be part of a healthy diet',
      'The accompanying sauces often contain vegetables that provide additional nutrients'
    ],
    'similarFoods': ['Boiled Yam', 'Plantain and Bean Stew', 'Cocoyam Stew']
  },
  {
    'id': 'tuozaafi',
    'name': 'TZ (Tuo Zaafi)',
    'category': 'Starchy Staples',
    'calories': 310,
    'carbs': 67.0,
    'protein': 6.2,
    'fat': 1.8,
    'image': 'assets/images/tz.jpg',
    'description': 'A thick, stretchy dough made from millet or corn flour, typically served with spicy soup or stew. Popular in Northern Ghana.',
    'culturalContext': 'Tuo Zaafi (or TZ) is a staple food from Northern Ghana, particularly among the Dagomba, Mamprusi, and Gonja people. It exemplifies the regional diversity of Ghanaian cuisine and is usually prepared for lunch or dinner. The dish is known for its ability to sustain energy throughout the day.',
    'healthBenefits': [
      'Millet-based versions are rich in B vitamins and minerals like magnesium',
      'The accompanying soups often contain vegetables and protein sources',
      'Good source of dietary fiber for digestive health',
      'Relatively low in fat compared to other staples'
    ],
    'similarFoods': ['Fufu', 'Banku', 'Akple']
  },

  
  // ADDITIONAL LUNCH & DINNER FOODS

  
  {
    'id': 'gari_fortor',
    'name': 'Gari Fortor',
    'category': 'Lunch & Dinner',
    'calories': 280,
    'carbs': 45.0,
    'protein': 14.0,
    'fat': 7.5,
    'image': 'assets/images/gari_fotor.jpg',
    'description': 'A dish made from gari (cassava flakes) mixed with palm oil and other ingredients like fish, vegetables, and spices.',
    'culturalContext': 'Gari Fortor shows the ingenuity in Ghanaian cuisine, transforming preserved cassava into a quick, flavorful meal. It\'s particularly associated with coastal communities but enjoyed throughout Ghana.',
    'healthBenefits': [
      'Fast source of energy from the cassava',
      'Added protein from fish or other protein additions',
      'Contains various nutrients from the vegetable ingredients',
      'Relatively shelf-stable ingredients make it accessible'
    ],
    'similarFoods': ['Gari and Beans', 'Gari Soakings', 'Atieke']
  },
  
  {
    'id': 'yam_palava',
    'name': 'Yam with Palava Sauce',
    'category': 'Lunch & Dinner',
    'calories': 305,
    'carbs': 50.0,
    'protein': 16.5,
    'fat': 9.0,
    'image': 'assets/images/yam_palava.jpeg',
    'description': 'Boiled yam served with palava sauce, a stew made from cocoyam leaves or spinach, egusi (melon seeds), fish or meat, and palm oil.',
    'culturalContext': 'This dish exemplifies the importance of green leafy vegetables in Ghanaian cuisine. The combination of starchy yam with the nutritious palava sauce creates a balanced meal enjoyed across different regions.',
    'healthBenefits': [
      'Very high in protein, especially with the addition of egusi seeds',
      'Rich in iron, calcium, and vitamin A from the green leaves',
      'Good source of complex carbohydrates from the yam',
      'Contains healthy fats from the egusi seeds'
    ],
    'similarFoods': ['Ampesi with Kontomire', 'Yam with Garden Egg Stew', 'Cocoyam with Palava Sauce']
  },
  
  {
    'id': 'rice_balls_groundnut',
    'name': 'Rice Balls with Groundnut Soup',
    'category': 'Lunch & Dinner',
    'calories': 420,
    'carbs': 65.0,
    'protein': 18.0,
    'fat': 14.5,
    'image': 'assets/images/riceballs_groundnut.jpg',
    'description': 'Molded balls of soft-cooked rice served with groundnut (peanut) soup, often containing meat or fish and vegetables.',
    'culturalContext': 'This comfort food demonstrates the versatility of rice in Ghanaian cuisine. The groundnut soup is rich and hearty, making this combination particularly satisfying and often served at special gatherings.',
    'healthBenefits': [
      'High in plant-based protein from the groundnuts',
      'Good source of healthy fats',
      'Contains various minerals including magnesium and phosphorus',
      'Provides sustained energy from the rice'
    ],
    'similarFoods': ['Fufu with Groundnut Soup', 'Omo Tuo', 'Plain Rice with Groundnut Soup']
  },
  
  {
    'id': 'boiled_yam_egg',
    'name': 'Boiled Yam and Egg Stew',
    'category': 'Lunch & Dinner',
    'calories': 290,
    'carbs': 48.0,
    'protein': 14.0,
    'fat': 7.5,
    'image': 'assets/images/yam_eggstew.jpg',
    'description': 'Simple yet delicious boiled yam served with a tomato-based stew containing boiled eggs, sometimes with fish or meat.',
    'culturalContext': 'This straightforward dish shows how everyday ingredients can create a satisfying meal in Ghanaian homes. It\'s often prepared for ordinary family meals and showcases the importance of yam in the diet.',
    'healthBenefits': [
      'Good source of high-quality protein from the eggs',
      'Complex carbohydrates from the yam provide sustained energy',
      'Contains lycopene and other antioxidants from the tomatoes',
      'Relatively balanced macronutrient profile'
    ],
    'similarFoods': ['Ampesi', 'Boiled Plantain with Stew', 'Yam with Fish Stew']
  },
  
  // SNACKS
  {
    'id': 'bofrot',
    'name': 'Bofrot (Puff Puff)',
    'category': 'Snacks',
    'calories': 180,
    'carbs': 25.0,
    'protein': 3.0,
    'fat': 8.5,
    'image': 'assets/images/bofrot.png', // Using actual bofrot image
    'description': 'Sweet, deep-fried dough balls made from flour, sugar, yeast, and spices. A popular sweet snack in Ghana.',
    'culturalContext': 'Bofrot (also known as Puff Puff in other West African countries) is a beloved street food in Ghana. It\'s often sold by vendors in markets and along roadsides, particularly in the evenings, and is enjoyed as a snack or light breakfast.',
    'healthBenefits': [
      'Provides quick energy from simple carbohydrates',
      'Contains small amounts of protein from wheat flour',
      'The fermentation process (from yeast) may improve digestibility',
      'Can be enriched with spices like nutmeg that have antioxidant properties'
    ],
    'similarFoods': ['Kose', 'Atweaa', 'Donuts']
  },
  
  // DRINKS
  {
    'id': 'sobolo',
    'name': 'Sobolo (Hibiscus Drink)',
    'category': 'Drinks',
    'calories': 85,
    'carbs': 22.0,
    'protein': 0.5,
    'fat': 0.1,
    'image': 'assets/images/sobolo.png', // Using actual sobolo image
    'description': 'A refreshing deep red drink made from dried hibiscus flowers (bissap), often flavored with ginger, pineapple, and other spices.',
    'culturalContext': 'Sobolo is a popular drink in Ghana, especially during hot weather and festivities. It\'s appreciated for both its vibrant color and distinctive flavor. Many Ghanaians believe it has medicinal properties and drink it regularly for health reasons.',
    'healthBenefits': [
      'Rich in vitamin C and antioxidants',
      'Studies suggest it may help lower blood pressure',
      'Contains anti-inflammatory compounds',
      'Can be made with less sugar for a healthier version'
    ],
    'similarFoods': ['Bisap', 'Zobo', 'Fruity Drinks']
  },
  
  {
    'id': 'pito',
    'name': 'Pito',
    'category': 'Drinks',
    'calories': 110,
    'carbs': 22.0,
    'protein': 1.5,
    'fat': 0.2,
    'image': 'assets/images/pito.jpg', // Verified this image exists
    'description': 'A traditional fermented millet drink that varies from non-alcoholic to mildly alcoholic depending on the fermentation time.',
    'culturalContext': 'Pito is particularly associated with Northern Ghana and has deep cultural significance. It\'s often used in traditional ceremonies and social gatherings. The brewing process is considered an art form passed down through generations, especially by women.',
    'healthBenefits': [
      'Contains probiotics from the fermentation process that benefit gut health',
      'Rich in B vitamins from the millet',
      'Provides various minerals including iron and zinc',
      'The lactic acid helps with mineral absorption'
    ],
    'similarFoods': ['Burkina', 'Brukina', 'Palm Wine']
  },
  
  {
    'id': 'brukina',
    'name': 'Brukina',
    'category': 'Drinks',
    'calories': 150,
    'carbs': 25.0,
    'protein': 7.5,
    'fat': 3.0,
    'image': 'assets/images/brukina.jpg',
    'description': 'A refreshing drink made from millet and milk, popular across Ghana especially in northern regions.',
    'culturalContext': 'Brukina (also called Burkina) combines the fermented flavor of millet with the creamy texture of milk to create a nutritious beverage enjoyed by many Ghanaians. It\'s often sold by street vendors and considered both a refreshment and a light meal.',
    'healthBenefits': [
      'Rich in proteins and calcium from milk',
      'Contains probiotics from fermentation',
      'Provides quick energy and sustenance',
      'Good source of B vitamins from millet'
    ],
    'similarFoods': ['Pito', 'Yogurt Drinks', 'Millet Porridge']
  }

];
