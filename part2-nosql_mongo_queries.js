!pip3 install JSON;

use ecommerce_db;
switched to db ecommerce_db
db.products.insertMany([ //OP1: insertMany() — insert all 3 documents from sample_documents.json
  //Electronics product 
  {
    product_id: "E1001",
    name: "Smart LED TV 55 inch",
    category: "Electronics",
    brand: "Samsung",
    price: 64999,
    specifications: {
      screen_size: "55 inch",
      resolution: "4K UHD",
      voltage: "220V",
      smart_features: ["Netflix", "YouTube", "Prime Video"]
    },
    warranty: {
      period: "2 years",
      type: "Manufacturer"
    },
    ratings: {
      average: 4.5,
      reviews: 1200
    }
  },
  // Clothing product
  {
    product_id: "C2001",
    name: "Men's Casual Shirt",
    category: "Clothing",
    brand: "Levi's",
    price: 1999,
    sizes_available: ["S", "M", "L", "XL"],
    material: "Cotton",
    color_options: ["Blue", "Black", "White"],
    care_instructions: {
      wash: "Machine wash",
      dry: "Do not tumble dry",
      iron: "Medium heat"
    },
    ratings: {
      average: 4.2,
      reviews: 350
    }
  },

  // Groceries product
  {
    product_id: "G3001",
    name: "Organic Almonds 500g",
    category: "Groceries",
    brand: "Organic India",
    price: 750,
    weight: "500g",
    expiry_date: "2026-01-15",
    nutritional_info: {
      calories: 579,
      protein: "21g",
      fat: "50g"
    },
    storage_instructions: "Store in a cool, dry place",
    ingredients: ["Almonds"],
    ratings: {
      average: 4.7,
      reviews: 890
    }
  }

]);
{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId('69bd1aec010ead79aa3bc969'),
    '1': ObjectId('69bd1aec010ead79aa3bc96a'),
    '2': ObjectId('69bd1aec010ead79aa3bc96b')
  }
}
//OP2: find() — retrieve all Electronics products with price > 20000
db.products.find(
  {
    category: "Electronics",
    price: { $gt: 20000 }
  }
);
{
  _id: ObjectId('69bbccfd51189ad7b7493150'),
  product_id: 'E1001',
  name: 'Smart LED TV 55 inch',
  category: 'Electronics',
  brand: 'Samsung',
  price: 64999,
  specifications: {
    screen_size: '55 inch',
    resolution: '4K UHD',
    voltage: '220V',
    smart_features: [
      'Netflix',
      'YouTube',
      'Prime Video'
    ]
  },
  warranty: {
    period: '2 years',
    type: 'Manufacturer'
  },
  ratings: {
    average: 4.5,
    reviews: 1200
  }
}
{
  _id: ObjectId('69bd1aec010ead79aa3bc969'),
  product_id: 'E1001',
  name: 'Smart LED TV 55 inch',
  category: 'Electronics',
  brand: 'Samsung',
  price: 64999,
  specifications: {
    screen_size: '55 inch',
    resolution: '4K UHD',
    voltage: '220V',
    smart_features: [
      'Netflix',
      'YouTube',
      'Prime Video'
    ]
  },
  warranty: {
    period: '2 years',
    type: 'Manufacturer'
  },
  ratings: {
    average: 4.5,
    reviews: 1200
  }
}
//OP3: find() — retrieve all Groceries expiring before 2025-01-01
db.products.find(
  {
    category: "Groceries",
    expiry_date: { $lt: ISODate("2025-01-01") }
  }
);
db.products.find(
  {
    category: "Groceries",
    expiry_date: { $lt: "2025-01-01" }
  }
);
// OP4: updateOne() — add a "discount_percent" field to a specific product
db.products.updateOne(
  {
    product_id: "C2001",  
    category: "Clothing"
  },
  {
    $set: {
      discount_percent: 15
    }
  }
);
{
  acknowledged: true,
  insertedId: null,
  matchedCount: 1,
  modifiedCount: 0,
  upsertedCount: 0
}

//OP5: createIndex() — create an index on category field and explain why
//Create an index on the category field
db.products.createIndex({ category: 1 });
//It creates an ascending index on a category
/*Now if we want to find the category 'Clothing', it is faster with an index created on a field. It uses indexed lookup,
which quickly retrieves the data for the specific category and avoids full collection scan */
db.products.find({ category: "Clothing" })

{
  _id: ObjectId('69bbccfd51189ad7b7493151'),
  product_id: 'C2001',
  name: "Men's Casual Shirt",
  category: 'Clothing',
  brand: "Levi's",
  price: 1999,
  sizes_available: [
    'S',
    'M',
    'L',
    'XL'
  ],
  material: 'Cotton',
  color_options: [
    'Blue',
    'Black',
    'White'
  ],
  care_instructions: {
    wash: 'Machine wash',
    dry: 'Do not tumble dry',
    iron: 'Medium heat'
  },
  ratings: {
    average: 4.2,
    reviews: 350
  },