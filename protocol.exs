defprotocol Caesar do
  def encrypt(string, shift)
  def rot13(string)
end

defimpl Caesar, for: BitString do

  def encrypt("", _), do: ""
  def encrypt(<< head::utf8, tail::binary >>, shift)
  when (head + shift > 122) do
    << (96 + rem(head + shift, 122))::utf8, encrypt(tail, shift)::binary >>
  end
  def encrypt(<< head::utf8, tail::binary >>, shift) do
    << (head + shift)::utf8, encrypt(tail, shift)::binary >>
  end

  def rot13(string) do
    encrypt(string, 13)
  end
end

defimpl Caesar, for: List do
  def encrypt([], _), do: []
  def encrypt([head | tail], shift) when (head + shift > 122) do
    [96 + rem(head + shift, 122) | encrypt(tail, shift)]
  end
  def encrypt([head | tail], shift), do: [head + shift | encrypt(tail, shift)]

  def rot13(string) do
    encrypt(string, 13)
  end
end
