defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number), do:
    [{3, 'Pling'}, {5, 'Plang'}, {7, 'Plong'}]
    |> Enum.map(&raindrop_sound(&1, number))
    |> Enum.join()
    |> number_if_empty(number)

  defp raindrop_sound({factor, sound}, number) when rem(number, factor) == 0, do: sound
  defp raindrop_sound(_, _), do: ''

  defp number_if_empty("", number), do: to_string(number)
  defp number_if_empty(sounds, _), do: sounds
end
