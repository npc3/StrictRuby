#new classes exist
assert_equal 'StrictAttributeAccess', %q{StrictAttributeAccess}

assert_equal 'NoAttributeError', %q{NoAttributeError}

#strict? exists
assert_equal 'true', %q{Class.method_defined? 'strict?'}

#normal IV reads work properly
assert_equal '', %q{
  class Test
    def succeed
      @doesnt_exist
    end
  end

  Test.new.succeed
}

#strict? on normal class
assert_equal 'false', %q{
  class Test
  end

  Test.strict?
}

#simple strict reads
assert_equal 'no instance variable named @doesnt_exist', %q{
  class Test
    include StrictAttributeAccess
    def fail
      @doesnt_exist
    end
  end

  begin
    Test.new.fail
  rescue NoAttributeError => e
    e
  end
}

#simple strict?
assert_equal 'true', %q{
  class Test
    include StrictAttributeAccess
  end

  Test.strict?
}

#inheritance with method in superclass
assert_equal 'no instance variable named @doesnt_exist', %q{
  class Test
    include StrictAttributeAccess
    def fail
      @doesnt_exist
    end
  end

  class TestSub < Test
  end

  begin
    TestSub.new.fail
  rescue NoAttributeError => e
    e
  end
}

#inheritance with method in subclass
assert_equal 'no instance variable named @doesnt_exist', %q{
  class Test
    include StrictAttributeAccess
  end

  class TestSub < Test
    def fail
      @doesnt_exist
    end
  end

  begin
    TestSub.new.fail
  rescue NoAttributeError => e
    e
  end
}

#strict? with inheritance
assert_equal 'true', %q{
  class Test
    include StrictAttributeAccess
  end

  class TestSub < Test
  end

  TestSub.strict?
}

#monkeypatching
assert_equal 'no instance variable named @doesnt_exist', %q{
  class Test
    def fail
      @doesnt_exist
    end
  end

  class Test
    include StrictAttributeAccess
  end

  begin
    Test.new.fail
  rescue NoAttributeError => e
    e
  end
}

#monkeypatching with inheritance with method in superclass
assert_equal 'no instance variable named @doesnt_exist', %q{
  class Test
    def fail
      @doesnt_exist
    end
  end

  class TestSub < Test
  end

  class Test
    include StrictAttributeAccess
  end

  begin
    TestSub.new.fail
  rescue NoAttributeError => e
    e
  end
}

#monkeypatching with inheritance with method in subclass
assert_equal 'no instance variable named @doesnt_exist', %q{
  class Test
  end

  class TestSub < Test
    def fail
      @doesnt_exist
    end
  end

  class Test
    include StrictAttributeAccess
  end

  begin
    TestSub.new.fail
  rescue NoAttributeError => e
    e
  end
}

#strict? with monkeypatching
assert_equal 'true', %q{
  class Test
  end

  class TestSub < Test
  end

  class Test
    include StrictAttributeAccess
  end

  TestSub.strict?
}

#strict doesn't affect non-inherited classes
assert_equal '', %q{
  class Test
    def succeed
      @doesnt_exist
    end
  end

  class StrictSub < Test
    include StrictAttributeAccess
  end

  class HippySub < Test
  end

  HippySub.new.succeed
}

#strict? with non-inherited classes
assert_equal 'false', %q{
  class Test
  end

  class StrictSub < Test
    include StrictAttributeAccess
  end

  class HippySub < Test
  end

  HippySub.strict?
}

# $STRICT exists
assert_equal 'false', %q{$STRICT}

# $STRICT works
assert_equal 'no instance variable named @doesnt_exist', %q{
  $STRICT = true

  class Test
    def fail
      @doesnt_exist
    end
  end

  begin
    Test.new.fail
  rescue NoAttributeError => e
    e
  end
}

assert_equal 'true', %q{
  $STRICT = true

  class Test
  end

  Test.strict?
}

#require_unstrict exists
assert_equal 'true', %q{Kernel.respond_to? 'require_unstrict'}

#require_unstrict works
#this is a little terrible I admit, we have to make sure that the interpreter
#assert_equal is using has the same load path as ours. note the interpolation.
assert_equal '', %Q{
  #$LOAD_PATH.each do |f|
    $LOAD_PATH.unshift f
  end
  $STRICT = true
  require_unstrict 'unstrictrequired'
  Required.new.succeed
}

# ||= operator
assert_equal 'ok', %q{
  class Test
    include StrictAttributeAccess
    def succeed
      @doesnt_exist ||= 'ok'
    end
  end

  Test.new.succeed
}

# &&= operator
assert_equal 'no instance variable named @doesnt_exist', %q{
  class Test
    include StrictAttributeAccess
    def fail
      @doesnt_exist &&= 'ok'
    end
  end

  begin
    Test.new.fail
  rescue NoAttributeError => e
    e
  end
}
