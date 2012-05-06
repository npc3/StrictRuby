class Test
  include StrictAttributeAccess
  def or_or_equals
    @doesnt_exist1 ||= "nut"
  end

  def and_and_equals
    @doesnt_exist2 &&= "nut"
  end

  def and_equals
    @doesnt_exist3 &= "nut"
  end

  def or_equals
    @doesnt_exist4 |= "nut"
  end

  def xor_equals
    @doesnt_exist5 ^= "nut"
  end

  def plus_equals
    @doesnt_exist6 += "nut"
  end
end

t = Test.new
p t.or_or_equals == (nil || "nut")
#p t.and_and_equals == (nil && "nut")
#p t.and_equals == nil & "nut"
#p t.or_equals == nil | "nut"
#p t.xor_equals == nil ^ "nut"
p t.plus_equals
