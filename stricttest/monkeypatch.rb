class Monkey
end

class Test < Monkey
  def fail
    @doesnt_exist
  end
end

p Test.strict?
p Test.new.fail

class Monkey
  include StrictAttributeAccess
end

p Test.strict?
begin
  p Test.new.fail
rescue NoAttributeError
  p $!
  p $!.name
end

#===

class Test2
  def fail
    @doesnt_exist
  end
end

p Test2.strict?
p Test2.new.fail

class Object
  include StrictAttributeAccess
end

p Test2.strict?
begin
  p Test2.new.fail
rescue NoAttributeError
  p $!
  p $!.name
end
