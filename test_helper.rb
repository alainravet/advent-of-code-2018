def assert_equal(exp, act, msg = nil)
  if exp == act
    print '.'
  else
    print 'X' ; puts
    fail "\nERROR: #{msg}\n\texpected #{exp.inspect} - got #{act.inspect}"
  end
end
