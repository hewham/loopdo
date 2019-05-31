# FUNCTION TO INITIALIZE A FAKE DATA SET

def initData
  all_sp = []
  serviceSet1 = [
    Service.new('A', 200, 60),
    Service.new('B', 100, 120),
    Service.new('C', 50, 60)
  ]
  serviceSet2 = [
    Service.new('D', 300, 180),
    Service.new('E', 150, 120)
  ]
  all_sp.push(ServiceProvider.new('Jim', '1111111111', serviceSet1, {}, []))
  all_sp.push(ServiceProvider.new('Sue', '1111111112', serviceSet2, {}, []))
  return all_sp
end
