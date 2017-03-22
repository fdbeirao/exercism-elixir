defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift), do:
    text
    |> to_charlist
    |> Enum.map(&advance(&1, shift))
    |> to_string

  defp advance(chr, shift) when chr >= ?a and chr <= ?z, do:
    advance(chr, shift, ?a)

  defp advance(chr, shift) when chr >= ?A and chr <= ?Z, do:
    advance(chr, shift, ?A)

  defp advance(chr, _), do:
    chr

  defp advance(chr, shift, base), do:
    (rem (chr - base + shift), 26) + base
end

