json.presidents do
  presidents = [
    { name: "Luis Lacalle Pou", age: 48 },
    { name: "Tabaré Vázquez", age: 80 },
    { name: "José Mujica", age: 88 },
    { name: "Tabaré Vázquez", age: 80 },
    { name: "Jorge Batlle", age: 88 },
    { name: "Julio María Sanguinetti", age: 87 }
  ]

  json.array! presidents do |president|
    json.name president[:name]
    json.age president[:age]
  end
end
