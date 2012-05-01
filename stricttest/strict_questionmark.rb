class Test
  def fail
    @doesnt_exist
  end
end

t = Test.new
p Test.strict?
p Test.new.fail
p t.fail

class Test
  include StrictAttributeAccess
end


p Test.strict?

begin
  p Test.new.fail
rescue NoAttributeError
  p $!
end

begin
  p t.fail
rescue NoAttributeError
  p $!
end
