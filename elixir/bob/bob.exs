defmodule Bob do
  def hey(input) when is_bitstring(input) do
    cond do
        is_silence?(input)  -> "Fine. Be that way!"
        is_question?(input) -> "Sure."
        is_shouting?(input) -> "Whoa, chill out!"
        true                -> "Whatever."

    end
  end

  defp is_shouting?(input), do:
    has_letters?(input)
    and
    is_all_caps?(input)

  defp has_letters?(input), do:
    input 
    |> matches_regex?(~r[\p{L}])
  
  defp matches_regex?(input, regex), do:
    Regex.match?(regex, input)

  defp is_all_caps?(input), do:
    input == String.upcase(input)

  defp is_question?(input), do:
    input
    |> String.ends_with?("?")

  defp is_silence?(input), do:
    input
    |> String.trim
    |> String.length
    == 0
end
