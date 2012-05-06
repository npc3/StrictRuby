class Test
  include StrictAttributeAccess
  def fail
    p @@doesnt_exist
  end
end

Test.new.fail

