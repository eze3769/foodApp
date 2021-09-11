# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Shop.create(name:"mc king", nick:"mcking",category:"fast food") 
Shop.create(name:"pollos Hermanos", nick:"polloshermanos",category:"fast food")
Shop.first.products.create(name:'pizza',price:800,category:'comida',description:'pizza de 8 porciones al horno de barro')
Shop.products.create(name:'gaseosa 500ml',price:120,category:'bebida',description:'botella de gaseosa línea pepsi')