class Hash
  def default!(other_hash)
    merge!( other_hash ){|k,o,n| o }
  end
end
