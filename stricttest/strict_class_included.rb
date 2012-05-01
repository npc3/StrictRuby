class Test
  include StrictAttributeAccess
end

class Test2 < Test
end

module Test3
  include StrictAttributeAccess
end

module Test4
  include Test3
end
