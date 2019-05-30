# FUNCTION TO INITIALIZE A FAKE DATA SET

def initData
  all_sp = []
  serviceSet1 = [
    Service.new('Demon Removal', 200, 60),
    Service.new('Soul Cleaning', 100, 120),
    Service.new('Pitchfock Rental', 50, 60)
  ]
  serviceSet2 = [
    Service.new('Pentagram Setup', 300, 180),
    Service.new('Curse Training', 150, 120)
  ]
  all_sp.push(ServiceProvider.new('Jim', '1111111111', serviceSet1, {}, []))
  all_sp.push(ServiceProvider.new('Sue', '1111111112', serviceSet2, {}, []))
  return all_sp
end
